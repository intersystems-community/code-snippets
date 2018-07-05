Class objectscript.postXML
{
	classmethod test() {
		Set HTTPRequest = ##class(%Net.HttpRequest).%New()
	    Set HTTPRequest.ContentType = "text/xml"
	    Set HTTPRequest.NoDefaultContentCharset = 1
	    Set HTTPRequest.Location = "ITOMCZ"
	    Set HTTPRequest.Server = "wph.foactive.com"
	    Do HTTPRequest.RemoveHeader("User-Agent")  
	    Do HTTPRequest.RemoveHeader("Accept-Encoding") 
	    Do HTTPRequest.RemoveHeader("Connection")
	    Do HTTPRequest.SetHeader("Expect","100-continue")
	 
	    Set RequestXML = ##class(%Library.File).%New("c:\test.xml")
	    Do RequestXML.Open("RS")
	    Do HTTPRequest.EntityBody.CopyFrom(RequestXML)
	    Do RequestXML.%Close()
	 
	    Do HTTPRequest.Post(HTTPRequest.Location)
	 
	    Do $System.OBJ.Dump(HTTPRequest)
	    Do $System.OBJ.Dump(HTTPRequest.HttpResponse)
	 
	    Write HTTPRequest.HttpResponse.Data.Size
	    Write HTTPRequest.ContentLength
	 
	    Set ResponseStream = ##class(%Stream.FileBinary).%New()
	    // Second part is typically the file extension, i.e.: application/pdf -> pdf
	    Set FileType = $Piece(HTTPRequest.HttpResponse.GetHeader("CONTENT-TYPE"),"/",2)
	    Set ResponseStream.Filename = "C:\test."_FileType
	 
	    Write ResponseStream.CopyFrom(HTTPRequest.HttpResponse.Data)
	 
	    Write ResponseStream.%Save()
	    Do ResponseStream.%Close()
	}
}