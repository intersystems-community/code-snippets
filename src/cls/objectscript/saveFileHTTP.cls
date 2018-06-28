Class objectscript.saveFileHTTP Extends %RegisteredObject
{
	classmethod test() {
		Set httprequest = ##class(%Net.HttpRequest).%New()
		Set httprequest.Server = "docs.intersystems.com"
		Do httprequest.Get("/documentation/cache/20101/pdfs/GCRN.pdf")
		Do $System.OBJ.Dump(httprequest.HttpResponse)
		 
		Set stream=##class(%FileBinaryStream).%New()
		Set stream.Filename="c:\test.pdf"
		Set stream=##class(%FileBinaryStream).%New()
		Set stream.Filename="c:\test.pdf"
		Write stream.CopyFrom(httprequest.HttpResponse.Data)
		Write stream.%Save()
	}
}