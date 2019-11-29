using System.Collections.Generic;
using System.Linq;
using System.Text;
using SlimShader.Chunks;
using SlimShader.Chunks.Ifce;
using SlimShader.Chunks.Rdef;
using SlimShader.Chunks.Sfi0;
using SlimShader.Chunks.Shex;
using SlimShader.Chunks.Stat;
using SlimShader.Chunks.Xsgn;
using SlimShader.Util;

namespace SlimShader
{
	public class BytecodeContainer
	{
		private readonly byte[] _rawBytes;

		public byte[] RawBytes
		{
			get { return _rawBytes; }
		}

		public BytecodeContainerHeader Header { get; private set; }
		public List<BytecodeChunk> Chunks { get; private set; }

		public ResourceDefinitionChunk ResourceDefinition
		{
			get { return Chunks.OfType<ResourceDefinitionChunk>().SingleOrDefault(); }
		}

		public PatchConstantSignatureChunk PatchConstantSignature
		{
			get { return Chunks.OfType<PatchConstantSignatureChunk>().SingleOrDefault(); }
		}

		public InputSignatureChunk InputSignature
		{
			get { return Chunks.OfType<InputSignatureChunk>().SingleOrDefault(); }
		}

		public OutputSignatureChunk OutputSignature
		{
			get { return Chunks.OfType<OutputSignatureChunk>().SingleOrDefault(); }
		}

		public Sfi0Chunk Sfi0
		{
			get { return Chunks.OfType<Sfi0Chunk>().SingleOrDefault(); }
		}

		public ShaderProgramChunk Shader
		{
			get { return Chunks.OfType<ShaderProgramChunk>().SingleOrDefault(); }
		}

		public StatisticsChunk Statistics
		{
			get { return Chunks.OfType<StatisticsChunk>().SingleOrDefault(); }
		}

		public InterfacesChunk Interfaces
		{
			get { return Chunks.OfType<InterfacesChunk>().SingleOrDefault(); }
		}

		public BytecodeContainer(byte[] rawBytes)
		{
			_rawBytes = rawBytes;
			Chunks = new List<BytecodeChunk>();

			var reader = new BytecodeReader(rawBytes, 0, rawBytes.Length);

			Header = BytecodeContainerHeader.Parse(reader);

			for (uint i = 0; i < Header.ChunkCount; i++)
			{
				uint chunkOffset = reader.ReadUInt32();
				var chunkReader = reader.CopyAtOffset((int)chunkOffset);

                var chunk = BytecodeChunk.ParseChunk(chunkReader, this);
                if (chunk != null)
    				Chunks.Add(chunk);
			}
		}

		public static BytecodeContainer Parse(byte[] bytes)
		{
			return new BytecodeContainer(bytes);
		}

		public override string ToString()
		{
			var sb = new StringBuilder();
			sb.AppendLine("//");
			sb.AppendLine("// Generated by " + ResourceDefinition.Creator);
			sb.AppendLine("//");
			sb.AppendLine("//");

			if (Shader.Tokens.Any(x => x.Header.OpcodeType == OpcodeType.Abort)) // TODO
			{
				sb.AppendLine("// Note: SHADER WILL ONLY WORK WITH THE DEBUG SDK LAYER ENABLED.");
				sb.AppendLine("//");
				sb.AppendLine("//");
			}

			if (Sfi0 != null)
				sb.Append(Sfi0);

			if (ResourceDefinition != null)
				sb.Append(ResourceDefinition);

			sb.AppendLine(@"//");

			if (PatchConstantSignature != null)
			{
				sb.Append(PatchConstantSignature);
				sb.AppendLine(@"//");
			}

			sb.Append(InputSignature);
			sb.AppendLine(@"//");

			sb.Append(OutputSignature);

			sb.Append(Statistics);

			if (Interfaces != null)
				sb.Append(Interfaces);

			if (Shader != null)
				sb.Append(Shader);

			if(Statistics != null) 
				sb.AppendFormat("// Approximately {0} instruction slots used", Statistics.InstructionCount);

			return sb.ToString();
		}

		public static implicit operator byte[](BytecodeContainer container)
		{
			return container._rawBytes;
		}
	}
}