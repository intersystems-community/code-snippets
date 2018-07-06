/// get property value within class by indirection
Class objectscript.getPropOfThisClass Extends %RegisteredObject
{
	// extra code to help test
	Property myProp as %Integer;
	
	// need to instantiate an object to access property value
	method test() {
		// extra code to help test
		set ..myProp = 32
		
		// code from the CODE post
		set property = $PROPERTY($THIS, "myProp")
		
		// extra code to help test
		write property
	}
}