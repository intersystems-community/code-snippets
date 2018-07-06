class objectscript.createClass Extends %RegisteredObject
{
	classmethod test() {
		; Create a class
		s c=##class(%ClassDefinition).%New("MyClass")
		i '$IsObject(c) d $system.Status.DisplayError(c) q
		s c.Description="This is my test class"_$c(13,10)_"testing %ClassDefinition"
		s c.Super="%Persistent"
 
		; Create a property and add it
		s p=##class(%PropertyDefinition).%New("MyClass.MyProperty")
		i '$IsObject(p) d $system.Status.DisplayError(p) k  q
		s r=c.Properties.Insert(p)
		i $system.Status.IsError(r) d $system.Status.DisplayError(r) k  q
		s p.Type="%String"
		s p.Description="This is a property"
		s r=p.%Close()
		i $system.Status.IsError(r) d $system.Status.DisplayError(r) k  q
		k p
 
		; Create a method and add it
		s m=##class(%MethodDefinition).%New("MyClass.MyMethod")
		i '$IsObject(m) d $system.Status.DisplayError(m) k  q
		s r=c.Methods.Insert(m)
		i $system.Status.IsError(r) d $system.Status.DisplayError(r) k  q
		s m.ReturnType="%Integer"
		s m.FormalSpec="x:%Integer,y:%Integer=10"
		s m.Description="Return product of x and y"
		s m.CodeMode="code"
		s m.Code=" new result"_$c(13,10)_" set result=x*y"_$c(13,10)_" quit result"
		s r=m.%Close()
		i $system.Status.IsError(r) d $system.Status.DisplayError(r) k  q
		k m
 
		; Save and close the class definition
		s r=c.%Save()
		i $system.Status.IsError(r) d $system.Status.DisplayError(r) k  q
		s r=c.%Close()
		i $system.Status.IsError(r) d $system.Status.DisplayError(r) k  q
		k c
	}
}