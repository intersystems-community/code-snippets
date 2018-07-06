Class skisser.webcamPage extends %ZEN.Component.page
{
	Parameter APPLICATION;
	 
	Parameter PAGENAME;
	 
	Parameter DOMAIN;
	 
	XData Style
	{
	<style type="text/css">
	</style>
	}
	 
	XData Contents [ XMLNamespace = "http://www.intersystems.com/zen" ]
	{
	<page xmlns="http://www.intersystems.com/zen" title="">
	<button caption="startCam" onclick="zenPage.startCam()"/>
	<button caption="Snapshot" onclick="zenPage.snapshot()"/>
	<camComponent width="600px" height="800px" id="mycam"/>
	<image id="image_source" src="" hidden="true"/>
	 
	</page>
	}
	 
	ClientMethod snapshot() [ Language = javascript ]
	{
	    var snap = zenPage.getComponentById('image_source')
	    zen('mycam').snapshot(snap);
	    zen('mycam').SaveImageToDB(snap);
	    snap.refreshContents();
	}
	 
	ClientMethod startCam() [ Language = javascript ]
	{
	    zen('mycam').startWebcam();
	}
}