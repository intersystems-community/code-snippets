/// Note: this only works for Linux, although I'm sure there are Windows equivalents.
Class timleavitt.createThumbnail Extends %RegisteredObject
{
	classmethod test(pSourceFile as %String, output pDestFile as %String = "") as %Status
	{
		Set tSC = $$$OK
     
		If (pDestFile = "") {
	        //Put the file in a /thumbs subdirectory under its current location.
	        Set pDestFile = pSourceFile
	        Set $Piece(pDestFile,"/",*-1) = $Piece(pDestFile,"/",*-1)_"/thumbs"
	     
	        //Create thumbs directory if it doesn't exist.
	        Do ##class(%File).CreateDirectoryChain(##class(%File).NormalizeDirectory($Piece(pDestFile,"/",1,*-1)))
	    }
	     
	    //If pDestFile already exists, don't both recreating it.
	    Quit:##class(%File).Exists(pDestFile) tSC
	 
	    //Create the thumbnail
	    Set tCMD = "convert -size 200x200 "_##class(%File).NormalizeFilenameWithSpaces(pSourceFile)_" -resize 200x200 +profile '*' "_##class(%File).NormalizeFilenameWithSpaces(pDestFile)
	    Do $zf(-1,tCMD)
	     
	    If '##class(%File).Exists(pDestFile) {
	        Set tSC = $$$ERROR($$$GeneralError,"Thumbnail could not be created.")
	    }
	     
	    Quit tSC
	}
}