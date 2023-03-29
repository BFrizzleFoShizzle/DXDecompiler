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

		public static void CompileShader(string compiler, string inFile, string outFile, StreamWriter stream)
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
				stream.Write(process.StandardOutput.ReadToEnd());
				throw new Exception("Error compiling ");
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
						foreach(DXDecompiler.DX9Shader.FX9.Technique technique in model.EffectChunk.Techniques)
						{
							foreach(DXDecompiler.DX9Shader.FX9.Pass pass in technique.Passes)
							{
								sw.WriteLine(technique.Name + " " + pass.Name);
							}
						}

						foreach(DXDecompiler.DX9Shader.FX9.StateBlob blob in model.EffectChunk.StateBlobs)
						{
							// TODO Expression
							if(blob.BlobType == DXDecompiler.DX9Shader.FX9.StateBlobType.Shader && blob.Shader.Type != DXDecompiler.DX9Shader.ShaderType.Expression)
							{
								sw.WriteLine(blob.TechniqueIndex + " " + blob.PassIndex);
								DXDecompiler.DX9Shader.FX9.Technique technique = model.EffectChunk.Techniques[(int)blob.TechniqueIndex];
								DXDecompiler.DX9Shader.FX9.Pass pass = technique.Passes[(int)blob.PassIndex];
								string shaderName = baseFileName + "." + technique.Name + "." + pass.Name + "." + blob.Shader.Type;
								if(!(blob.Shader.Preshader is null))
								{
									string preshaderPath = shaderName + ".preshader.fxa";
									sw.WriteLine(preshaderPath);
									StreamWriter preshaderFile = File.CreateText(preshaderPath);
									// write inputs
									DXDecompiler.DX9Shader.AsmWriter preshaderDisassembler = new DXDecompiler.DX9Shader.AsmWriter(blob.Shader.Preshader.Shader);
									preshaderDisassembler.SetStream(preshaderFile);
									preshaderDisassembler.WriteConstantTable(blob.Shader.Preshader.Shader.ConstantTable);
									foreach(var instruction in blob.Shader.Preshader.Shader.Fxlc.Tokens)
									{
										preshaderFile.WriteLine(instruction);
									}
									preshaderFile.Close();
								}
								string shaderPath = shaderName + ".fxa";
								sw.WriteLine(shaderPath);
								StreamWriter outFile = File.CreateText(shaderPath);
								// write inputs
								DXDecompiler.DX9Shader.AsmWriter shaderDisassembler = new DXDecompiler.DX9Shader.AsmWriter(blob.Shader);
								shaderDisassembler.SetStream(outFile);
								shaderDisassembler.WriteConstantTable(blob.Shader.ConstantTable);
								outFile.WriteLine(shaderDisassembler.Version());
								foreach(DXDecompiler.DX9Shader.InstructionToken instruction in blob.Shader.Instructions)
									shaderDisassembler.WriteInstruction(instruction);

								outFile.Close();
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
								BinaryWriter writer = new BinaryWriter(File.OpenWrite("out.fxo"));

								DebugBytecodeReader footerReader = (DebugBytecodeReader)reader.GetNamedMember("FooterReader");
								DebugEntry stateBlobCountEntry = (DebugEntry)footerReader.GetNamedMember("StateBlobCount");
								int stateBlobCount = Int32.Parse(stateBlobCountEntry.Value);

								// everything before the state blobs remains unchanged
								uint statesStart = ((DebugIndent)footerReader.GetNamedMember("StateBlob 0")).AbsoluteIndex;
								byte[] headerBytes = new byte[statesStart];
								Array.Copy(data, headerBytes, statesStart);
								writer.Write(headerBytes);

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
											CompileShader("vsa.exe", shaderBaseName + ".fxa", shaderBaseName + ".vo", sw);
											replacementBytes = LoadCompiledShaderFunction(shaderBaseName + ".vo");
										}
										else if(blobShaderType == "Pixel" && File.Exists(shaderBaseName + ".fxa"))
										{
											CompileShader("psa.exe", shaderBaseName + ".fxa", shaderBaseName + ".po", sw);
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
