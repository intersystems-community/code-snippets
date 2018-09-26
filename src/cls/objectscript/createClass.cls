class objectscript.createClass Extends %RegisteredObject
{
ClassMethod test() As %Status
{
	set sc = $$$OK
	
	// Create a class
	set class = ##class(%ClassDefinition).%New("MyClass")
	set class.Description = "This is my test class"_$c(13,10)_"testing %ClassDefinition"
	set class.Super = "%Persistent"

	// Create a property and add it
	set property = ##class(%PropertyDefinition).%New("MyClass.MyProperty")
	set property.Type = "%String"
	set property.Description="This is a property"
	set sc1 = class.Properties.Insert(property)
	do:$$$ISERR(sc1) $system.Status.DisplayError(sc1)
	set sc = $$$ADDSC(sc, sc1)
	
	// Create a method and add it
	set method = ##class(%MethodDefinition).%New("MyClass.MyMethod")
	set method.ReturnType = "%Integer"
	set method.FormalSpec = "x:%Integer,y:%Integer=10"
	set method.Description = "Return product of x and y"
	set method.CodeMode = "code"
	set method.Code = " new result"_$c(13,10)_" set result=x*y"_$c(13,10)_" quit result"
	set sc2 = class.Methods.Insert(method)
	do:$$$ISERR(sc2) $system.Status.DisplayError(sc2)
	set sc = $$$ADDSC(sc, sc2)
	
	// Save the class definition
	set sc3 = class.%Save()
	do:$$$ISERR(sc3) $system.Status.DisplayError(sc3)
	set sc = $$$ADDSC(sc, sc3)
	
	return sc
}
}
