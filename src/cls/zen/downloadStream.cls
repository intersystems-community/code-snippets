/// We assume that you have stored your data within this schema:
/// MyApp.Model.Storage: Filename,FileSize,Content,ContentType
Class zen.downloadStream Extends (%ZEN.Component.page,%CSP.StreamServer)
{
 
	/// Wrapper to get the id of the download, we assume that the id is passed to this zen page
	/// as a URI parameter, i.e.: MyApp.Downloads.cls?OID=1234
	ClassMethod GetId()
	{
	    Quit $Get(%request.Data("OID",1))
	}
	 
	/// Set the appropriate header for the file.
	ClassMethod OnPreHTTP() As %Boolean
	{
	    Set tId = ..GetId()
	 
	    If ##Class(MyApp.Model.Storage).%ExistsId(tId) {
	        Set tStream = ##Class(MyApp.Model.Storage).%OpenId(tId)
	        // You could "guess" the content type by its file extension
	        // or you can store it (before) in the database separately (like in this example).
	        // Set Extension = $Piece(tStream.Filename,".",$Length(tStream.Filename,"."))
	        // Set ContentType = ..FileClassify(Extension)
	 
	        Set %response.ContentType = tStream.ContentType
	        Do %response.SetHeader("content-disposition","attachment; filename="_tStream.Filename)
	        Do %response.SetHeader("Content-Length",tStream.FileSize)
	    }
	    Else {
	        Set %response.Status="404 File Not Found"
	        Quit 0
	    }
	    Quit $$$OK
	}
	 
	ClassMethod OnPage() As %Status
	{
	    Set Download = ##Class(MyApp.Model.Storage).%OpenId(..GetId())
	    Do Download.Content.OutputToDevice()
	    Quit $$$OK
	}
 
}
