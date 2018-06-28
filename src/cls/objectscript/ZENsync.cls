Class objectscript.ZENsync Extends %RegisteredObject
{
	classmethod test() {
		Write ##class(%ZEN.Component.abstractPage).%ZENVersion()
 
		; Return Zen Library version.
		;This is used to make sure that the class library is in sync with the zenutils.js file and any generated js files. This must match the value in the zenutils.js file.
	}
}