/// This Zen page has a property that is accessible as a JavaScript object on the client
/// and a %ZEN.proxyObject on the server. The object has a property that's a COS list (JavaScript array) of
/// COS lists (JavaScript arrays) of objects.
/// The critical/transferrable part is the transformation done in %OnDrawObjectProperties, onSerialize, and
/// %OnZENDeserialize.
Class timleavitt.JSobjProp Extends %ZEN.Component.page
{
 
/// Class name of application this page belongs to.
Parameter APPLICATION;
 
/// Displayed name of this page.
Parameter PAGENAME;
 
/// Domain used for localization.
Parameter DOMAIN;
 
/// Stores complex object as JSON for server-side reference.
/// On the client, object is referenced in _complexdata, which is reserialized
/// and sent back to the server as a JSON string and later unpacked.
Property complexdata As %ZEN.Datatype.string;
 
/// This Style block contains page-specific CSS style definitions.
XData Style
{
<style type="text/css">
</style>
}
 
/// This XML block defines the contents of this page.
XData Contents [ XMLNamespace = "http://www.intersystems.com/zen" ]
{
<page xmlns="http://www.intersystems.com/zen" title="">
<text onchange="zenPage._complexdata.children[0][4].prop3 = zenThis.getValue();" label="Change Deep Property" />
<button onclick="zenPage.ServerMethod()" caption="Ship back to server" />
</page>
}
 
/// Alert a value from complexdata
Method ServerMethod() [ ZenMethod ]
{
    &js<alert('..complexdata.children.GetAt(1).GetAt(5).prop3 = '+#(..QuoteJS(..complexdata.children.GetAt(1).GetAt(5).prop3))#);>
}
 
/// This just initializes the complexdata property with an object with a list of lists of objects.
Method %OnAfterCreatePage() As %Status
{
    //Populate complexdata with sample data.
    Set ..complexdata = ##class(%ZEN.proxyObject).%New()
    Set ..complexdata.children = ##class(%ListOfObjects).%New()
    For i=1:1:10 {
        Set tChild = ##class(%ListOfObjects).%New()
        For j=1:1:10 {
            Set tSubChild = ##class(%ZEN.proxyObject).%New()
            Set tSubChild.prop1 = "prop1_"_i_"_"_j
            Set tSubChild.prop2 = "prop2_"_i_"_"_j
            Set tSubChild.prop3 = "prop3_"_i_"_"_j
            Do tChild.Insert(tSubChild)
        }
        Do ..complexdata.children.Insert(tChild)
    }
    Quit $$$OK
}
 
/// Render complexdata (the proxyObject) as a JSON in this._complexdata.
Method %OnDrawObjectProperties()
{
    Write "o._complexdata = "
    Do ..complexdata.%ToJSON()
    Write ";",!
}
 
/// Convert this._complexdata to a string and put it in the "actual" complexdata property
ClientMethod onSerialize() [ Language = javascript ]
{
    this.complexdata = JSON.stringify(this._complexdata);
}
 
/// Convert the string in ..complexdata to a %ZEN.proxyObject again
Method %OnZENDeserialize() As %Status
{
    Set tSC = ##class(%ZEN.Auxiliary.jsonProvider).%ConvertJSONToObject(..complexdata,,.tProxy)
    Quit:$$$ISERR(tSC) tSC
    Set ..complexdata = tProxy
    Quit $$$OK
}
 
}
