/// Really simple example of a responsive Zen page, using CSS to rearrange it based on the screen size.
 Class timleavitt.simpleResponsive Extends %ZEN.Component.page
{

/// This Style block contains page-specific CSS style definitions.
/// For more information on @media, see: https://developer.mozilla.org/en-US/docs/Web/Guide/CSS/Media_queries
XData Style
{
<style type="text/css">
.demoPage {
    width: 97%;
}
 
.demoLabel {
    float: left;
    text-align: center;
    width: 19%;
    padding: 1%;
    margin: 1%;
    -webkit-border-radius: 5px;
    -moz-border-radius: 5px;
    border-radius: 5px;
    background-color: #FCFCFC;
    border: 1px solid #CCCCCC;
}
 
@media screen and (max-width: 1279px) {
    .demoLabel {
        width: 29%;
    }
}
 
@media screen and (max-width: 799px) {
    .demoLabel {
        width: 45%;
    }
}
 
@media screen and (max-width: 479px) {
    .demoLabel {
        width: 97%;
    }
}
</style>
}
 
/// Layout="none" is particularly the key thing here. Without that, Zen will arrange
/// the page contents vertically and the CSS will have no effect.
XData Contents [ XMLNamespace = "http://www.intersystems.com/zen" ]
{
<page xmlns="http://www.intersystems.com/zen" title="" layout="none" enclosingClass="demoPage">
<label value="Label 1" enclosingClass="demoLabel" />
<label value="Label 2" enclosingClass="demoLabel" />
<label value="Label 3" enclosingClass="demoLabel" />
<label value="Label 4" enclosingClass="demoLabel" />
<label value="Label 5" enclosingClass="demoLabel" />
<label value="Label 6" enclosingClass="demoLabel" />
<label value="Label 7" enclosingClass="demoLabel" />
<label value="Label 8" enclosingClass="demoLabel" />
</page>
}
 
}
