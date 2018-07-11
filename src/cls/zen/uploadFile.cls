/// Created using the page template: Default
Class zen.uploadFile Extends %ZEN.Component.page
{

/// Class name of application this page belongs to.
Parameter APPLICATION = "";

/// Displayed name of this page.
Parameter PAGENAME = "";

/// Domain used for localization.
Parameter DOMAIN = "";

/// This Style block contains page-specific CSS style definitions.
XData Style
{
<style type="text/css">
</style>
}
XData Contents [XMLNamespace="http://www.intersystems.com/zen"]
{
<page xmlns="http://www.intersystems.com/zen" title="">
<form id="filetestform" name="filetestform" nextPage="" enctype="multipart/form-data" autoValidate="true">
<fileUpload name="filetest" id="filetest" required="true"/>
<submit caption="Hochladen"/>
</form>
</page>
}
  
ClassMethod %OnSubmit(pSubmit As %ZEN.Submit) As %Status
{
    Set NewFile = ##class(%FileBinaryStream).%New()
 
    Set Location = "C:\"
    Set NewFile.Filename = Location_pSubmit.%GetStream("filetest").FileName
    Do NewFile.CopyFrom(pSubmit.%GetStream("filetest"))
    Set status = NewFile.%Save()
 
    Quit status
}
}
