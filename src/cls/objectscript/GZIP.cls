Class objectscript.GZIP Extends %RegisteredObject
{
	classmethod test() {
		//Export Global(s) uncompressed
		set filename="C:\Temp\myglobal.xml"
		do $System.OBJ.Export("^oddEXTR.gbl",filename)
		//Open exported Globals
		set uncompressed = ##class(%FileBinaryStream).%New()
		set uncompressed.Filename=filename
		Set compressed = "C:\temp\mycomglobal.xml"
		//Open File Device over Gzip and Copy Uncompressed information to it
		Open compressed:("WUNK":::/GZIP=1:/NOXY=1:/OBUFSIZE=32768):0
		Use compressed
		do uncompressed.OutputToDevice()
		close compressed
		//Create New File  
		set out = ##class(%FileBinaryStream).%New()
		set out.Filename= "C:\Temp\decomp.xml"
		//Open compressed File and save information uncompressed over gzip
		Set file=##class(%File).%New(compressed)
		Do file.Open("RUK:::/GZIP=1:/NOXY=1")
		while ' file.AtEnd
		{
		    set line = file.ReadLine()
		    do out.Write(line)
		}
		do out.%Save()
	}
}