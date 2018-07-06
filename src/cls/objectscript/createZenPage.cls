Class objectscript.createZenPage
{
	classmethod test() {
		// create Application...
		set app=##class(%Dictionary.ClassDefinition).%New()
		set app.Super="%ZEN.application"
		set app.Name="ZenTest.MyZenApplication"
		set app.ProcedureBlock=1
		 
		set param=##class(%Dictionary.ParameterDefinition).%New()
		set param.Name="APPLICATIONNAME"
		set param.Default="MyZenApplication"
		set param.parent=app
		do param.%Save()
		 
		set param=##class(%Dictionary.ParameterDefinition).%New()
		set param.Name="HOMEPAGE"
		set param.Default=""
		set param.parent=app
		do param.%Save()
		 
		set ok=app.%Save()
		if 'ok {
		        do DecomposeStatus^%apiOBJ(ok,.err)
		        write "Error creating App class: "_err(1),!
		        }
		 
		// create Page...
		set page=##class(%Dictionary.ClassDefinition).%New()
		set page.Name="ZenTest.MyZenPage"
		set page.ProcedureBlock=1
		set page.Super="%ZEN.Component.page"
		 
		set param=##class(%Dictionary.ParameterDefinition).%New()
		set param.Name="APPLICATIONNAME"
		set param.Default="ZenTest.MyZenApplication"
		set param.parent=page
		do param.%Save()
		 
		set param=##class(%Dictionary.ParameterDefinition).%New()
		set param.Name="PAGENAME"
		set param.Default="MyZenPage"
		set param.parent=page
		do param.%Save()
		 
		set xds=##class(%Dictionary.XDataDefinition).%New()
		set xds.parent=page
		set xds.Name="Style"
		set xds.Data=##class(%Stream.TmpCharacter).%New()
		do xds.Data.Rewind()
		do xds.Data.Write(" <style type=""text/css"">"_$c(13,10)_"</style>")
		do xds.%Save()
		 
		set xdc=##class(%Dictionary.XDataDefinition).%New()
		set xdc.parent=page
		set xdc.Name="Content"
		set xdc.XMLNamespace="http://www.intersystems.com/zen"
		set xdc.Data=##class(%Stream.TmpCharacter).%New()
		do xdc.Data.Rewind()
		do xdc.Data.Write(" <page xmlns=""http://www.intersystems.com/zen"" title="""">")
		do xdc.Data.Write($c(13,10))
		do xdc.Data.Write(" <text id=""MyText"" value=""this is great!"" />")
		do xdc.Data.Write($c(13,10))
		do xdc.Data.Write(" </page>")
		do xdc.Data.Write($c(13,10))
		do xdc.%Save()
		 
		set method=##class(%Dictionary.MethodDefinition).%New()
		set method.Name="%OnAfterCreatePage"
		set method.ReturnType="%Status"
		set method.parent=page
		//implementation is a %Stream
		set code=##class(%Stream.TmpCharacter).%New()
		do code.Rewind()
		do code.Write(" Set tBtn = ##class(%ZEN.Component.button).%New()")
		do code.Write($c(13,10)) // carriage return line feed
		do code.Write(" Set tBtn.caption = ""Button 2""")
		do code.Write($c(13,10))
		do code.Write(" Do %page.%AddChild(tBtn)"_$c(13,10))
		do code.Write($c(13,10))
		do code.Write(" quit $$$OK")
		do code.Write($c(13,10))
		set method.Implementation=code
		do method.%Save()
		 
		set ok=page.%Save()
		if 'ok {
		        do DecomposeStatus^%apiOBJ(ok,.err)
		        write "Error creating Page class: "_err(1),!
		        }
		 
		do $system.OBJ.Compile("ZenTest.MyZenApplication")     
		do $system.OBJ.Compile("ZenTest.MyZenPage")    
		quit
	}
}