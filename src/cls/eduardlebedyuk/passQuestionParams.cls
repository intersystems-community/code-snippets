Class eduardlebedyuk.passQuestionParams
{
	classmethod test(pValue = 50) {
		s ns = $Namespace
	    zn "samples"
	    s tSQL = "SELECT ID, Name FROM Sample.Person WHERE Id > ?"
	    s tPR = ##class(%ZEN.Auxiliary.jsonSQLProvider).%New()
	    s tPR.sql = tSQL
	    s tPR.%Format = "tw"
	    s tPR.maxRows = 100
	 
	    s tParam = ##class(%ZEN.Auxiliary.parameter).%New()
	    s tParam.value = pValue
	    d tPR.parameters.SetAt(tParam,1)
	  
	    d tPR.%DrawJSON() 
	    //d ##class(%ZEN.Auxiliary.jsonSQLProvider).%WriteJSONFromSQL(,,,,,tPR)  //same thing
	    zn ns
	}
}