Class objectscript.sendEmail Extends %RegisteredObject
{
	classmethod test() {
		set m=##class(%Net.MailMessage).%New()
		set m.From="user@company.com"
		 
		set m.IsHTML=1
		 
		do m.To.Insert("user@company.com")
		set m.Subject="Sent by Cache' mail"
		set m.Charset="iso-8859-1"
		do m.TextData.Write("<HTML><HEAD><TITLE></TITLE>"_$char(13,10))
		do m.TextData.Write("<META http-equiv=Content-Type content=""text/html; charset=iso-8859-2""></HEAD>"_$char(13,10))
		do m.TextData.Write("<BODY><FONT face=Arial size=2>Test <B>Test</B></FONT></BODY></HTML>")
		set s=##class(%Net.SMTP).%New()
		set s.smtpserver="mail.company.com"
		set status=s.Send(m)
	}
}