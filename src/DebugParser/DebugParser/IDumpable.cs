namespace DXDecompiler.DebugParser
{
	public interface IDumpable
	{
		string Dump();
		string Name { get; }
		int Indent { get; }
		uint AbsoluteIndex { get; }
		uint RelativeIndex { get; }
		uint Size { get; }
		string Type { get; }
		string Value { get; }
		void AddNote(string key, object value);
	}
}
