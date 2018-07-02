Class eduardlebedyuk.filenamesInDir Extends %RegisteredObject
{
	classmethod test() {
		// replace dir with file path you want
		set dir = "D:\directory" 
		set dir = ##class(%File).NormalizeDirectory(dir)
		set file=$ZSEARCH(dir_"*")
		while file'="" {
			write !,file
			set file=$ZSEARCH("")
		}
	}
}