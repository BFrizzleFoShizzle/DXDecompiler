namespace DXDecompilerCmd
{
	public class Options
	{
		public string SourcePath;
		public string DestPath;
		public DecompileMode Mode;
		public bool AddComments;
		public bool DisableErrorFX;
		public bool DisableWarningFX;
		public bool Verbose;
		public bool DisableCleanup;
		public bool IgnorePreshaders;
	}
}
