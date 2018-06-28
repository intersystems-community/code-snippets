Class objectscript.sendEmailWithImage Extends %RegisteredObject
{
	classmethod test() {
		S SmtpServer = ""
		S SmtpUserName = ""
		S SmtpPassword = ""
  
		S imgPath="C:\test.jpg"
		 
		set s=##class(%Net.SMTP).%New()
		set s.smtpserver=SmtpServer
		set auth=##class(%Net.Authenticator).%New() ; use default authentication list
		set auth.UserName=SmtpUserName
		set auth.Password=SmtpPassword
		set s.authenticator=auth
		Set objMail=##class(%Net.MailMessage).%New()
		Set objMail.From="sender@testhost.com"
		Do objMail.To.Insert("reciever@testhost.com")
		Set objMail.Subject="Test-Email"
		Set objMail.Charset="iso-8859-1"
		  
		Set obj1 =objMail
		  
		Set obj1.IsHTML=1
		Set obj1.IsBinary = 0
		Set obj1.IsMultiPart = 1
		Set obj1.MultiPartType ="related"
		Do obj1.Headers.SetAt("inline","Content-Disposition")
		 
		//alternative container for the text-parts
		#dim textbody as %Net.MailMessagePart
		s textbody = obj1.AttachNewMessage()
		s textbody.IsMultiPart=1
		s textbody.IsHTML=0
		s textbody.MultiPartType="alternative"
		  
		//html part
		#dim text as %Net.MailMessagePart
		//text part
		#dim texttxt as %Net.MailMessagePart
		 
		s texttxt = textbody.AttachNewMessage()
		//s texttxt.ContentType="text/plain"
		d texttxt.TextData.Write("this is plain text")
		  
		s text = textbody.AttachNewMessage()
		s text.IsHTML=1
		s text.IsBinary=0
		s text.IsMultiPart=0
		  
		Do text.TextData.Write("<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.01 Transitional//EN"">")
		do text.TextData.Write("<html><head><meta http-equiv=""content-type"" content=""text/html; charset=ISO-8859-1"">")
		Do text.TextData.Write("</head><body text=""#000000"" bgcolor=""#ffffff"">")
		Do text.TextData.Write("Das ist ein Test in html")
		Do text.TextData.Write("<img src=""cid:test.jpg"" />")
		Do text.TextData.Write("</body></html>")
		  
		// Image Message Part
		#dim obj2 as %Net.MailMessagePart
		Set obj2 = obj1.AttachNewMessage()
		Set obj2.IsBinary = 1
		Set obj2.IsMultiPart = 0
		Set obj2.FileName="test.jpg"
		  
		Do obj2.BinaryData.LinkToFile(imgPath)
		Do obj2.Headers.SetAt("inline","Content-Disposition")
		Do obj2.Headers.SetAt("<test.jpg>","Content-ID")
		set status=s.Send(objMail)
		  
		d $system.OBJ.DisplayError(status)
		w status,!
	}
}