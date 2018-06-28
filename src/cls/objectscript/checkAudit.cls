class objectscript.checkAudit Extends %RegisteredObject
{
	classmethod test() {
		w "Checking for Auditing...",!
		Set SYSOBJ = ##class(Security.System).%OpenId("SYSTEM")
		If +SYSOBJ = 0 Set SYSOBJ = ##class(Security.System).%New()
		i SYSOBJ.AuditEnabled {
			w "Security Auditing is enabled for the following services",!
			s rs=##class(%ResultSet).%New("Security.Events:ListAllSystem")
			s sc=rs.Execute()  If $$$ISERR(sc) Do DisplayError^%apiOBJ(sc) Quit
			while rs.%Next() {
                d:rs.Data("Enabled")="Yes" rs.%Print()
            }
            d rs.Close()
         
            s rs=##class(%ResultSet).%New("Security.Events:ListAllUser")
            s sc=rs.Execute()  If $$$ISERR(sc) Do DisplayError^%apiOBJ(sc) Quit
            while rs.%Next() {
                d:rs.Data("Enabled")="Yes" rs.%Print()
            }
            d rs.Close()
        }
    }
}	