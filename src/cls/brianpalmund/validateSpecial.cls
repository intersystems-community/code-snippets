Class brianpalmund.validateSpecial Extends %RegisteredObject
{
	// I had an issue validating email addresses, and it seems that doing a 100% safe validation is near impossible.
	// I found a RegEx validation rule that seemed to do the job with the only problem being on handling special international characters.
	//
	//This method matches almost all of our 1.8 mil. email addresses correct and catches almost all invalid ones:
	//
	ClassMethod test(email As %String) As %Boolean
	{
	    set specialCharacters = "wáàãââæåçéèêëìíîïñòóôõöøùúûüıÿ"
	    quit $MATCH(email, "^[a-zA-Z0-9"_specialCharacters_".!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9"_specialCharacters_"](?:[a-zA-Z0-9-"_specialCharacters_"]{0,61}[a-zA-Z0-9"_specialCharacters_"])?(?:\.[a-zA-Z0-9"_specialCharacters_"](?:[a-zA-Z0-9-"_specialCharacters_"]{0,61}[a-zA-Z0-9"_specialCharacters_"])?)*$")
	}
}