using DXDecompiler;
using DXDecompiler.DebugParser;
using DXDecompiler.DebugParser.DX9;
using DXDecompiler.DebugParser.FX9;
using DXDecompiler.Decompiler;
using DXDecompiler.Util;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;

namespace DXDecompilerCmd
{
	class Program
	{
		public static byte[] LoadCompiledShaderFunction(string filename)
		{
			// have to remove the first 4 bytes
			byte[] fileBytes = null;
			fileBytes = File.ReadAllBytes(filename);
			byte[] outBytes = new byte[fileBytes.Length - 4];
			Array.Copy(fileBytes, 4, outBytes, 0, outBytes.Length);
			return outBytes;
		}

		public static void AssembleShader(string compiler, string inFile, string outFile, StreamWriter stream)
		{
			System.Diagnostics.Process process = new System.Diagnostics.Process();
			process.StartInfo.FileName = compiler;
			process.StartInfo.Arguments = inFile + " /nologo /Fo " + outFile;
			process.StartInfo.RedirectStandardOutput = true;
			process.StartInfo.UseShellExecute = false;
			process.Start();
			process.WaitForExit();
			if(process.ExitCode != 0)
			{
				if(!(stream is null))
				{
					stream.Write(process.StandardOutput.ReadToEnd());
					stream.Write(process.StandardError.ReadToEnd());
				}
				throw new Exception("Error compiling ");
			}
		}

		public static void CompileShaderToAsm(string shaderType, string mainFunctionName, string inFile, string outFile, StreamWriter stream)
		{
			System.Diagnostics.Process process = new System.Diagnostics.Process();
			process.StartInfo.FileName = "fxc.exe";
			process.StartInfo.Arguments = inFile + " /nologo /E" + mainFunctionName + " /T" + shaderType + " /Fc " + outFile;
			process.StartInfo.RedirectStandardOutput = true;
			process.StartInfo.RedirectStandardError = true;
			process.StartInfo.UseShellExecute = false;
			process.Start();
			process.WaitForExit();
			if(process.ExitCode != 0)
			{
				if(!(stream is null))
				{
					stream.Write(process.StandardOutput.ReadToEnd());
					stream.Write(process.StandardError.ReadToEnd());
				}
				throw new Exception("Error compiling ");
			}
		}

		public static void SaveShader(string shaderName, DXDecompiler.DX9Shader.ShaderModel shader, bool addComments, bool outputErrorFiles, bool outputWarningFiles, bool verbose, StreamWriter sw)
		{
			if(!(shader.Preshader is null))
			{
				string preshaderPath = shaderName + ".preshader.fxa";
				sw.WriteLine(preshaderPath);
				StreamWriter preshaderFile = File.CreateText(preshaderPath);
				// write inputs
				DXDecompiler.DX9Shader.AsmWriter preshaderDisassembler = new DXDecompiler.DX9Shader.AsmWriter(shader.Preshader.Shader);
				preshaderDisassembler.SetStream(preshaderFile);
				preshaderDisassembler.WriteConstantTable(shader.Preshader.Shader.ConstantTable);
				foreach(var instruction in shader.Preshader.Shader.Fxlc.Tokens)
				{
					preshaderFile.WriteLine(instruction);
				}
				preshaderFile.Close();
			}
			string shaderPath = shaderName + ".fxa";

			if(shader.Type == DXDecompiler.DX9Shader.ShaderType.Expression)
			{
				int instructionCount = 0;
				foreach(DXDecompiler.DX9Shader.InstructionToken instruction in shader.Instructions)
					++instructionCount;
				sw.WriteLine(instructionCount);
				sw.WriteLine(shader.Fxlc.Tokens.Count);
				return;

			}

			// create disassembly
			StreamWriter outFile = File.CreateText(shaderPath);
			// write inputs
			DXDecompiler.DX9Shader.AsmWriter shaderDisassembler = new DXDecompiler.DX9Shader.AsmWriter(shader);
			shaderDisassembler.SetStream(outFile);
			shaderDisassembler.WriteConstantTable(shader.ConstantTable);
			outFile.WriteLine(shaderDisassembler.Version());
			foreach(DXDecompiler.DX9Shader.InstructionToken instruction in shader.Instructions)
				shaderDisassembler.WriteInstruction(instruction);

			outFile.Close();

			// create decompile
			// disable preshader
			var preshader = shader.Preshader;
			shader.Preshader = null;
			string decompiledHlsl = DXDecompiler.DX9Shader.HlslWriter.Decompile(shader, null, null, true);
			string finalHlsl = "";
			if(!addComments)
			{
				foreach(string line in decompiledHlsl.Split('\n'))
					if(!line.Contains("//"))
						finalHlsl += line + "\n";
			}
			else
			{
				finalHlsl = decompiledHlsl;
			}
			bool tryCompile = true;
			if(finalHlsl.Contains("Error Const"))
			{
				sw.WriteLine(shaderName + ".fxa");
				if(outputErrorFiles)
				{
					sw.WriteLine(shaderName + ".fx has bad constants");
					outFile = File.CreateText(shaderName + ".ERROR" + ".fx");

				}
				else
				{
					return;
				}
				finalHlsl = "// File has bad constants\n" + finalHlsl;
				tryCompile = false;
			}
			else
			{
				outFile = File.CreateText(shaderName + ".fx");
			}
			shader.Preshader = preshader;
			outFile.Write(finalHlsl);
			outFile.Close();

			if(tryCompile)
			{
				try
				{
					string mainFunctionName = shader.Type == DXDecompiler.DX9Shader.ShaderType.Pixel ? "PixelMain" : "VertexMain";
					StreamWriter logger = verbose ? sw : null;
					CompileShaderToAsm(shaderDisassembler.Version(), mainFunctionName, shaderName + ".fx", shaderName + "_temp.fxa", logger);

					try
					{
						// Success! Compare to assembly
						string compiler = shader.Type == DXDecompiler.DX9Shader.ShaderType.Pixel ? "psa.exe" : "vsa.exe";
						AssembleShader(compiler, shaderName + ".fxa", shaderName + "_temp_1.fxo", logger);
						AssembleShader(compiler, shaderName + "_temp.fxa", shaderName + "_temp_2.fxo", logger);

						byte[] assembled = LoadCompiledShaderFunction(shaderName + "_temp_1.fxo");
						byte[] compiled = LoadCompiledShaderFunction(shaderName + "_temp_2.fxo");
						if(assembled.Length != compiled.Length)
						{
							sw.WriteLine(shaderPath);
							if(outputWarningFiles)
							{
								sw.WriteLine(shaderName + ".fx - warning: binary differs after recompilation (length)");
							}
							else
							{
								// delete warning'd decompiled source
								if(File.Exists(shaderName + ".fx"))
									File.Delete(shaderName + ".fx");
							}
							// leave both files and let the user decide what to do
							return;
						}
						for(int i=0;i<assembled.Length;++i)
						{
							if(assembled[i] != compiled[i])
							{
								sw.WriteLine(shaderPath);
								if(outputWarningFiles)
								{
									sw.WriteLine(shaderName + ".fx - warning: binary differs after recompilation (bytes)");
								}
								else
								{
									// delete warning'd decompiled source
									if(File.Exists(shaderName + ".fx"))
										File.Delete(shaderName + ".fx");
								}
								// leave both files and let the user decide what to do
								return;
							}
						}
						// Successful decompile!
						sw.WriteLine(shaderName + ".fx");
						// assembler isn't needed
						if(File.Exists(shaderName + ".fxa"))
							File.Delete(shaderName + ".fxa");
					}
					catch(Exception e)
					{
						sw.WriteLine("A bug was encountered reassembling " + shaderName + ".fxa");
					}
					finally
					{
						// object cleanup
						if(File.Exists(shaderName + "_temp_1.fxo"))
							File.Delete(shaderName + "_temp_1.fxo");
						if(File.Exists(shaderName + "_temp_2.fxo"))
							File.Delete(shaderName + "_temp_2.fxo");
					}
				}
				catch(Exception e)
				{
					sw.WriteLine(shaderPath);
					if(outputErrorFiles)
					{
						sw.WriteLine(shaderName + ".fx - unable to recompile");
						if(File.Exists(shaderName + ".ERROR" + ".fx"))
							File.Delete(shaderName + ".ERROR" + ".fx");
						System.IO.File.Move(shaderName + ".fx", shaderName + ".ERROR" + ".fx");
					}
					else
					{
						// delete error'd decompiled source
						if(File.Exists(shaderName + ".fx"))
							File.Delete(shaderName + ".fx");
					}
				}
				finally
				{
					// recompile cleanup
					if(File.Exists(shaderName + "_temp.fxa"))
						File.Delete(shaderName + "_temp.fxa");
				}
			}
		}

		public static ProgramType GetProgramType(byte[] data)
		{
			if(data.Length < 4)
			{
				return ProgramType.Unknown;
			}
			var dxbcHeader = BitConverter.ToUInt32(data, 0);
			if(dxbcHeader == "DXBC".ToFourCc())
			{
				return ProgramType.DXBC;
			}
			if(dxbcHeader == 0xFEFF2001)
			{
				return ProgramType.DXBC;
			}
			var dx9ShaderType = (DXDecompiler.DX9Shader.ShaderType)BitConverter.ToUInt16(data, 2);
			if(dx9ShaderType == DXDecompiler.DX9Shader.ShaderType.Vertex ||
				dx9ShaderType == DXDecompiler.DX9Shader.ShaderType.Pixel ||
				dx9ShaderType == DXDecompiler.DX9Shader.ShaderType.Effect)
			{
				return ProgramType.DX9;
			}
			return ProgramType.Unknown;
		}
		static StreamWriter GetStream(Options options)
		{
			if(string.IsNullOrEmpty(options.DestPath))
			{
				var sw = new StreamWriter(Console.OpenStandardOutput());
				sw.AutoFlush = true;
				Console.SetOut(sw);
				return sw;
			}
			try
			{
				return new StreamWriter(options.DestPath);
			}
			catch(Exception ex)
			{
				Console.Error.WriteLine("Error creating output file");
				Console.Error.WriteLine(ex);
				Environment.Exit(1);
				return null;
			}
		}
		static void Main(string[] args)
		{
			Trace.Listeners.Add(new ConsoleTraceListener(useErrorStream: true));

			var options = new Options();
			options.AddComments = false;
			options.DisableErrorFX = false;
			options.DisableWarningFX = false;
			options.Verbose = false;
			for(int i = 0; i < args.Length; i++)
			{
				switch(args[i])
				{
					case "-O":
						if(args.Length <= i + 1)
						{
							Console.Error.WriteLine("No output path specified");
							return;
						}
						options.DestPath = args[i + 1];
						i += 1;
						break;
					case "-a":
						options.Mode = DecompileMode.Dissassemble;
						break;
					case "-d":
						options.Mode = DecompileMode.Debug;
						break;
					case "-D":
						options.Mode = DecompileMode.DumpAssembly;
						break;
					case "-C":
						options.Mode = DecompileMode.Reassemble;
						break;
					case "-W":
						options.DisableWarningFX = true;
						break;
					case "-E":
						options.DisableErrorFX = true;
						break;
					case "-v":
						options.Verbose = true;
						break;
					case "-c":
						options.AddComments = true;
						break;
					case "-h":
						options.Mode = DecompileMode.DebugHtml;
						break;
					default:
						options.SourcePath = args[i];
						break;
				}
			}
			if(string.IsNullOrEmpty(options.SourcePath))
			{
				Console.Error.WriteLine("No source path specified");
				Console.Error.WriteLine("Usage: ");
				Console.Error.WriteLine("  DXDecompilerCmd <CompiledShader>                # decompile to stdout");
				Console.Error.WriteLine("  DXDecompilerCmd <CompiledShader>    -O <Output> # decompile to file");
				Console.Error.WriteLine("  DXDecompilerCmd <CompiledShader> -a             # disassemble to stdout");
				Console.Error.WriteLine("  DXDecompilerCmd <CompiledShader> -a -O <Output> # disassemble to file");
				Console.Error.WriteLine("  DXDecompilerCmd <CompiledShader> -h -O <Output> # generate debug HTML");
				Environment.Exit(1);
			}

			byte[] data = null;
			try
			{
				data = File.ReadAllBytes(options.SourcePath);
			}
			catch(Exception ex)
			{
				Console.Error.WriteLine("Error reading source");
				Console.Error.WriteLine(ex);
				Environment.Exit(1);
			}
			var programType = GetProgramType(data);
			using(var sw = GetStream(options))
			{
				if(programType == ProgramType.Unknown)
				{
					Console.Error.WriteLine($"Unable to identify shader object format");
					Environment.Exit(1);
				}
				else if(programType == ProgramType.DXBC)
				{
					if(options.Mode == DecompileMode.Dissassemble)
					{
						var container = new BytecodeContainer(data);
						sw.Write(container.ToString());
					}
					else if(options.Mode == DecompileMode.Decompile)
					{
						var hlsl = HLSLDecompiler.Decompile(data);
						sw.Write(hlsl);
					}
					else if(options.Mode == DecompileMode.Debug)
					{
						sw.WriteLine(string.Join(" ", args));
						var shaderBytecode = DebugBytecodeContainer.Parse(data);
						var result = shaderBytecode.Dump();
						sw.Write(result);
					}
					else if(options.Mode == DecompileMode.DebugHtml)
					{
						var shaderBytecode = DebugBytecodeContainer.Parse(data);
						var result = shaderBytecode.DumpHTML();
						sw.Write(result);
					}
				}
				else if(programType == ProgramType.DX9)
				{
					string baseFileName = Path.GetFileNameWithoutExtension(options.SourcePath);
					if(options.Mode == DecompileMode.Dissassemble)
					{
						var disasm = DXDecompiler.DX9Shader.AsmWriter.Disassemble(data);
						sw.Write(disasm);
					}
					else if(options.Mode == DecompileMode.DumpAssembly)
					{
						DXDecompiler.DX9Shader.ShaderModel model = DXDecompiler.DX9Shader.ShaderReader.ReadShader(data);

						foreach(DXDecompiler.DX9Shader.FX9.Variable variable in model.EffectChunk.Variables)
						{
							if(variable.Parameter.ParameterType == DXDecompiler.DX9Shader.Bytecode.Ctab.ParameterType.PixelShader ||
								variable.Parameter.ParameterType == DXDecompiler.DX9Shader.Bytecode.Ctab.ParameterType.VertexShader)
							{
								string techniqueName = variable.Parameter.Name;
								var elementCount = variable.Parameter.ElementCount == 0 ? 1 : variable.Parameter.ElementCount;
								for(int i = 0; i < elementCount; ++i)
								{
									string shaderName = baseFileName + "." + techniqueName + "." + i + "." + variable.Parameter.ParameterType;
									var blob = model.EffectChunk.VariableBlobLookup[variable.Parameter][i];
									if(blob.IsShader)
									{
										SaveShader(shaderName, blob.Shader, options.AddComments, !options.DisableErrorFX, !options.DisableWarningFX, options.Verbose, sw);
									}
								}
							}
						}

						foreach(DXDecompiler.DX9Shader.FX9.StateBlob blob in model.EffectChunk.StateBlobs)
						{
							if(blob.BlobType == DXDecompiler.DX9Shader.FX9.StateBlobType.Shader && blob.Shader.Type != DXDecompiler.DX9Shader.ShaderType.Expression)
							{
								// I have no idea what these effects are?
								if(blob.TechniqueIndex == 4294967295 || blob.PassIndex == 4294967295)
									continue;

								DXDecompiler.DX9Shader.FX9.Technique technique = model.EffectChunk.Techniques[(int)blob.TechniqueIndex];
								DXDecompiler.DX9Shader.FX9.Pass pass = technique.Passes[(int)blob.PassIndex];
								string shaderName = baseFileName + "." + technique.Name + "." + pass.Name + "." + blob.Shader.Type;
								SaveShader(shaderName, blob.Shader, options.AddComments, !options.DisableErrorFX, !options.DisableWarningFX, options.Verbose, sw);
							}
						}
					}
					else if(options.Mode == DecompileMode.Reassemble)
					{
						var shaderType = (DXDecompiler.DX9Shader.ShaderType)BitConverter.ToUInt16(data, 2);
						if(shaderType == DXDecompiler.DX9Shader.ShaderType.Effect)
						{
							var reader = new DebugBytecodeReader(data, 0, data.Length);
							string error = "";
							try
							{
								reader.ReadByte("minorVersion");
								reader.ReadByte("majorVersion");
								reader.ReadUInt16("shaderType");
								DebugEffectChunk chunk = DebugEffectChunk.Parse(reader, (uint)(data.Length - 4));
								BinaryWriter writer = new BinaryWriter(File.OpenWrite(baseFileName + "_new.fxo"));

								DebugBytecodeReader footerReader = (DebugBytecodeReader)reader.GetNamedMember("FooterReader");


								// everything before the variable blobs remains unchanged
								uint variablesStart = ((DebugIndent)footerReader.GetNamedMember("VariableBlob 0")).AbsoluteIndex;
								byte[] headerBytes = new byte[variablesStart];
								Array.Copy(data, headerBytes, variablesStart);
								writer.Write(headerBytes);

								DebugEntry variableCountEntry = (DebugEntry)footerReader.GetNamedMember("VariableCount");
								DebugEntry variableBlobCountEntry = (DebugEntry)footerReader.GetNamedMember("VariableBlobCount");
								int variableCount = Int32.Parse(variableCountEntry.Value);
								int variableBlobCount = Int32.Parse(variableBlobCountEntry.Value);
								// used to get info about variable blobs
								string[] variableBlobFiles = new string[variableBlobCount];
								DXDecompiler.DX9Shader.ShaderModel model = DXDecompiler.DX9Shader.ShaderReader.ReadShader(data);
								for(int i = 0; i < variableCount; ++i)
								{
									DXDecompiler.DX9Shader.FX9.Variable variable = model.EffectChunk.Variables[i];

									if(variable.Parameter.ParameterType == DXDecompiler.DX9Shader.Bytecode.Ctab.ParameterType.PixelShader ||
										variable.Parameter.ParameterType == DXDecompiler.DX9Shader.Bytecode.Ctab.ParameterType.VertexShader)
									{
										string techniqueName = variable.Parameter.Name;
										var elementCount = variable.Parameter.ElementCount == 0 ? 1 : variable.Parameter.ElementCount;
										for(int j = 0; j < elementCount; ++j)
										{

											string shaderName = baseFileName + "." + techniqueName + "." + j + "." + variable.Parameter.ParameterType;
											var blob = model.EffectChunk.VariableBlobLookup[variable.Parameter][j];
											int blobIndex = model.EffectChunk.VariableBlobs.IndexOf(blob);
											if(blob.IsShader)
											{
												variableBlobFiles[blobIndex] = shaderName;
											}
										}
									}
								}
								for(int i = 0; i < variableBlobCount; ++i)
								{
									DebugIndent variableBlob = (DebugIndent)footerReader.GetNamedMember("VariableBlob " + i);
									DebugEntry blobSize = (DebugEntry)variableBlob.GetNamedMember("Size");
									DebugBytecodeReader shaderReader = (DebugBytecodeReader)variableBlob.GetNamedMember("ShaderReader");
									if(shaderReader != null)
									{
										string blobShaderType = shaderReader.GetNamedMember("ShaderType").Value;
										// TODO Expression
										if(blobShaderType == "Expression")
										{
											uint variableStart = variableBlob.AbsoluteIndex;
											byte[] variableBytes = new byte[variableBlob.Size];
											Array.Copy(data, variableStart, variableBytes, 0, variableBlob.Size);
											writer.Write(variableBytes);
											continue;
										}

										string shaderBaseName = variableBlobFiles[i];
										sw.WriteLine(variableBlobFiles[i]);

										byte[] replacementBytes = null;
										if(blobShaderType == "Vertex" && File.Exists(shaderBaseName + ".fxa"))
										{
											AssembleShader("vsa.exe", shaderBaseName + ".fxa", shaderBaseName + ".vo", sw);
											replacementBytes = LoadCompiledShaderFunction(shaderBaseName + ".vo");
										}
										else if(blobShaderType == "Pixel" && File.Exists(shaderBaseName + ".fxa"))
										{
											AssembleShader("psa.exe", shaderBaseName + ".fxa", shaderBaseName + ".po", sw);
											replacementBytes = LoadCompiledShaderFunction(shaderBaseName + ".po");
										}
										else
										{
											uint variableStart = variableBlob.AbsoluteIndex;
											byte[] variableBytes = new byte[variableBlob.Size];
											Array.Copy(data, variableStart, variableBytes, 0, variableBlob.Size);
											writer.Write(variableBytes);
											sw.WriteLine("Bad shader: " + shaderBaseName);
											continue;
										}

										sw.WriteLine(shaderBaseName);

										List<DebugIndent> instructions = new List<DebugIndent>();
										uint instructionsStart = variableBlob.AbsoluteIndex + variableBlob.Size;
										uint instructionsEnd = variableBlob.AbsoluteIndex;

										foreach(IDumpable shaderEntry in shaderReader.LocalMembers)
										{
											if(shaderEntry is DebugIndent instruction
												&& (!instruction.Name.StartsWith("PRES"))
												&& instruction.Name != "CTAB"
												&& instruction.Name != "CLIT"
												&& instruction.Name != "FXLC")
											{
												instructionsStart = Math.Min(instructionsStart, instruction.AbsoluteIndex);
												instructionsEnd = Math.Max(instructionsEnd, instruction.AbsoluteIndex + instruction.Size);
												instructions.Add(instruction);
											}
										}

										uint variableBlobStart = variableBlob.AbsoluteIndex;
										uint variableHeaderSize = instructionsStart - variableBlobStart;
										uint oldInstrunctionsSize = instructionsEnd - instructionsStart;
										uint newInstrunctionsSize = (uint)replacementBytes.Length;
										uint newvariableBlobSize = (UInt32.Parse(blobSize.Value) - oldInstrunctionsSize) + newInstrunctionsSize;
										/*
										sw.WriteLine("Old: ");
										sw.WriteLine(variableBlobStart);
										sw.WriteLine(variableBlobStart + variableBlob.Size);
										sw.WriteLine("New: ");
										sw.WriteLine(variableBlobStart);
										sw.WriteLine(instructionsStart + newInstrunctionsSize);
										*/
										byte[] variableHeaderBytes = new byte[variableHeaderSize];
										Array.Copy(data, variableBlobStart, variableHeaderBytes, 0, variableHeaderSize);
										// update size
										Array.Copy(BitConverter.GetBytes(newvariableBlobSize), 0, variableHeaderBytes, blobSize.AbsoluteIndex - variableBlobStart, 4);
										writer.Write(variableHeaderBytes);

										writer.Write(replacementBytes);
									}
									else
									{
										uint variableStart = variableBlob.AbsoluteIndex;
										byte[] variableBytes = new byte[variableBlob.Size];
										Array.Copy(data, variableStart, variableBytes, 0, variableBlob.Size);
										writer.Write(variableBytes);
									}
								}

								DebugEntry stateBlobCountEntry = (DebugEntry)footerReader.GetNamedMember("StateBlobCount");
								int stateBlobCount = Int32.Parse(stateBlobCountEntry.Value);

								for(int i=0;i<stateBlobCount;++i)
								{
									DebugIndent stateBlob = (DebugIndent)footerReader.GetNamedMember("StateBlob " + i);
									DebugEntry blobType = (DebugEntry)stateBlob.GetNamedMember("BlobType");
									if(blobType.Value == "Shader")
									{
										DebugBytecodeReader shaderReader = (DebugBytecodeReader)stateBlob.GetNamedMember("ShaderReader");
										DebugEntry blobSize = (DebugEntry)stateBlob.GetNamedMember("BlobSize");
										string blobShaderType = shaderReader.GetNamedMember("ShaderType").Value;
										// TODO Expression
										if(blobShaderType == "Expression")
										{
											uint stateStart = stateBlob.AbsoluteIndex;
											byte[] stateBytes = new byte[stateBlob.Size];
											Array.Copy(data, stateStart, stateBytes, 0, stateBlob.Size);
											writer.Write(stateBytes);
											continue;
										}

										// find technique + pass info to derive file name
										int techniqueIndex = Int32.Parse(stateBlob.GetNamedMember("TechniqueIndex").Value);
										int passIndex = Int32.Parse(stateBlob.GetNamedMember("PassIndex").Value);
										DebugIndent technique = (DebugIndent)footerReader.GetNamedMember("Technique " + techniqueIndex);
										string techniqueName = ((DebugBytecodeReader)technique.GetNamedMember("NameReader")).GetNamedMember("Name").Value.Split('\"')[1];
										DebugIndent pass = (DebugIndent)technique.GetNamedMember("Pass " + passIndex);
										string passName = ((DebugBytecodeReader)pass.GetNamedMember("NameReader")).GetNamedMember("Name").Value.Split('\"')[1];
										string shaderBaseName = baseFileName + "." + techniqueName + "." + passName + "." + blobShaderType;

										byte[] replacementBytes = null;
										if(blobShaderType == "Vertex" && File.Exists(shaderBaseName + ".fxa"))
										{
											AssembleShader("vsa.exe", shaderBaseName + ".fxa", shaderBaseName + ".vo", sw);
											replacementBytes = LoadCompiledShaderFunction(shaderBaseName + ".vo");
										}
										else if(blobShaderType == "Pixel" && File.Exists(shaderBaseName + ".fxa"))
										{
											AssembleShader("psa.exe", shaderBaseName + ".fxa", shaderBaseName + ".po", sw);
											replacementBytes = LoadCompiledShaderFunction(shaderBaseName + ".po");
										}
										else
										{
											uint stateStart = stateBlob.AbsoluteIndex;
											byte[] stateBytes = new byte[stateBlob.Size];
											Array.Copy(data, stateStart, stateBytes, 0, stateBlob.Size);
											writer.Write(stateBytes);
											sw.WriteLine("Bad shader: " + shaderBaseName);
											continue;
										}

										sw.WriteLine(shaderBaseName);

										List<DebugIndent> instructions = new List<DebugIndent>();
										uint instructionsStart = stateBlob.AbsoluteIndex + stateBlob.Size;
										uint instructionsEnd = stateBlob.AbsoluteIndex;

										foreach(IDumpable shaderEntry in shaderReader.LocalMembers)
										{
											if(shaderEntry is DebugIndent instruction 
												&& (!instruction.Name.StartsWith("PRES"))
												&& instruction.Name != "CTAB")
											{
												instructionsStart = Math.Min(instructionsStart, instruction.AbsoluteIndex);
												instructionsEnd = Math.Max(instructionsEnd, instruction.AbsoluteIndex + instruction.Size);
												instructions.Add(instruction);
											}
										}

										uint stateBlobStart = stateBlob.AbsoluteIndex;
										uint stateHeaderSize = instructionsStart - stateBlobStart;
										uint oldInstrunctionsSize = instructionsEnd - instructionsStart;
										uint newInstrunctionsSize = (uint)replacementBytes.Length;
										uint newStateBlobSize = (UInt32.Parse(blobSize.Value) - oldInstrunctionsSize) + newInstrunctionsSize;

										/*
										sw.WriteLine("Old: ");
										sw.WriteLine(stateBlobStart);
										sw.WriteLine(stateBlobStart + stateBlob.Size);
										sw.WriteLine("New: ");
										sw.WriteLine(stateBlobStart);
										sw.WriteLine(instructionsStart + newInstrunctionsSize);
										*/

										byte[] stateHeaderBytes = new byte[stateHeaderSize];
										Array.Copy(data, stateBlobStart, stateHeaderBytes, 0, stateHeaderSize);
										// update size
										Array.Copy(BitConverter.GetBytes(newStateBlobSize), 0, stateHeaderBytes, blobSize.AbsoluteIndex - stateBlobStart, 4);
										writer.Write(stateHeaderBytes);

										writer.Write(replacementBytes);
									}
									else
									{
										uint stateStart = stateBlob.AbsoluteIndex;
										byte[] stateBytes = new byte[stateBlob.Size];
										Array.Copy(data, stateStart, stateBytes, 0, stateBlob.Size);
										writer.Write(stateBytes);
									}
								}
							}
							catch(Exception ex)
							{
								sw.WriteLine(ex);
								error = ex.ToString();
							}
						}
					}
					else if(options.Mode == DecompileMode.Decompile)
					{
						try
						{
							var hlsl = DXDecompiler.DX9Shader.HlslWriter.Decompile(data);
							sw.Write(hlsl);
						}
						catch(Exception e) when(!System.Diagnostics.Debugger.IsAttached)
						{
							Console.Error.WriteLine(e);
							Environment.Exit(1);
						}
					}
					else if(options.Mode == DecompileMode.Debug)
					{
						sw.WriteLine(string.Join(" ", args));
						var shaderType = (DXDecompiler.DX9Shader.ShaderType)BitConverter.ToUInt16(data, 2);
						if(shaderType == DXDecompiler.DX9Shader.ShaderType.Effect)
						{
							var reader = new DebugBytecodeReader(data, 0, data.Length);
							string error = "";
							try
							{
								reader.ReadByte("minorVersion");
								reader.ReadByte("majorVersion");
								reader.ReadUInt16("shaderType");
								DebugEffectChunk.Parse(reader, (uint)(data.Length - 4));
							}
							catch(Exception ex)
							{
								error = ex.ToString();
							}
							var dump = reader.DumpStructure();
							if(!string.IsNullOrEmpty(error))
							{
								dump += "\n" + error;
							}
							sw.Write(dump);
						}
						else
						{
							var reader = new DebugBytecodeReader(data, 0, data.Length);
							string error = "";
							try
							{
								DebugShaderModel.Parse(reader);
							}
							catch(Exception ex)
							{
								error = ex.ToString();
							}
							var dump = reader.DumpStructure();
							if(!string.IsNullOrEmpty(error))
							{
								dump += "\n" + error;
							}
							sw.Write(dump);
						}
					}
					else if(options.Mode == DecompileMode.DebugHtml)
					{
						var shaderType = (DXDecompiler.DX9Shader.ShaderType)BitConverter.ToUInt16(data, 2);
						if(shaderType == DXDecompiler.DX9Shader.ShaderType.Effect)
						{
							var reader = new DebugBytecodeReader(data, 0, data.Length);
							string error = "";
							try
							{
								reader.ReadByte("minorVersion");
								reader.ReadByte("majorVersion");
								reader.ReadUInt16("shaderType");
								DebugEffectChunk.Parse(reader, (uint)(data.Length - 4));
							}
							catch(Exception ex)
							{
								error = ex.ToString();
							}
							var dump = reader.DumpHtml();
							if(!string.IsNullOrEmpty(error))
							{
								dump += "\n" + error;
							}
							sw.Write(dump);
						}
						else
						{
							var reader = new DebugBytecodeReader(data, 0, data.Length);
							string error = "";
							try
							{
								DebugShaderModel.Parse(reader);
							}
							catch(Exception ex)
							{
								error = ex.ToString();
							}
							var dump = reader.DumpHtml();
							if(!string.IsNullOrEmpty(error))
							{
								dump += "\n" + error;
							}
							sw.Write(dump);
						}
					}
				}
			}
		}
	}
}
