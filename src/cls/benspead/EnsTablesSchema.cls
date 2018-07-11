Class benspead.EnsTablesSchema
{
	classmethod test() {
		If ##class(%Dictionary.CompiledClass).%ExistsId("Ens.Util.LookupTableDocument") {
		    // only supported in Ensemble 2012.1+
		    Write !,!,"Exporting Ensemble Lookup Tables..."
		    Set sc = $$$OK
		    Set rs = ##class(%ResultSet).%New("Ens.Util.LookupTableDocument:List")
		    Do rs.Execute()
		    While rs.Next() {
		        Set item=rs.Data("name")
		        Write "document found: "_ item,!
		    }
		    Do rs.Close()
		    Set rs=""
		}
		If ##class(%Dictionary.CompiledClass).%ExistsId("EnsLib.HL7.SchemaDocument") {
		    Write !,!,"Exporting Ensemble HL7 Schemas..."
		    Set sc = $$$OK
		    Set rs = ##class(%ResultSet).%New("EnsLib.HL7.SchemaDocument:List")
		    Do rs.Execute()
		    While rs.Next() {
		        Set item=rs.Data("name")
		        Continue:$listfind($lb("2.1.HL7","2.2.HL7","2.3.HL7","2.4.HL7","2.5.HL7","2.6.HL7","2.7.HL7","2.3.1.HL7","2.5.1.HL7","2.7.1.HL7","ITK.HL7")
		                            ,item)
		        Write "document found: "_ item,!
		    }
		    Do rs.Close()
		    Set rs=""
		}
	}
}