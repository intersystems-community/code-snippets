Class objectscript.findTable Extends %RegisteredObject
{
	classmethod test(name as %String="mytable") {
		#dim result as %ResultSet
	    #dim tName as %String
	    #dim contain as %Integer
	     
	    Set contain=0
	    Set result=##class(%ResultSet).%New("%ClassDefinition.ClassInfo")
	    Do result.Execute()
	    For{ 
	        If (result.Next()=0 ) Quit
	        Set tName=result.GetDataByName("Name")
	        &sql(select position (:name in :tName) into :contain)
	        If (contain '= 0) Write tName, " ... ", name, " (", contain,")", !
	    }
	     
	    Do result.%Close()
	}
}