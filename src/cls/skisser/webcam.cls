Class skisser.camComponent Extends %ZEN.Component.component
	{
	 
	Parameter NAMESPACE = "http://www.intersystems.com/zen";
	 
	XData Style
	{
	<style type="text/css">
	</style>
	}
	 
	Method %DrawHTML()
	{
	    &html<
	<video id="video" width="640" height="480" autoplay="true"></video>
	<canvas id="canvas" width="640" height="480" style="display:none;"></canvas>    >}
	 
	ClientMethod snapshot(imgcontainer) [ Language = javascript ]
	{
	    var video = document.querySelector('video');
	    var canvas = document.querySelector('canvas');
	    var ctx = canvas.getContext('2d');
	    var localMediaStream = null;
	    ctx.drawImage(video, 0, 0, 640, 480);
	    imgcontainer.src = canvas.toDataURL('image/png');
	}
	 
	ClientMethod startWebcam() [ Language = javascript ]
	{
	    var video = this
	    navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia || navigator.oGetUserMedia;
	    if (navigator.getUserMedia) 
	    {      
	        navigator.getUserMedia({video: true}, video.handleVideo,video.camError);
	    }
	}
	 
	ClientMethod handleVideo(stream) [ Language = javascript ]
	{
	    video.src = window.URL.createObjectURL(stream);
	}
	 
	ClientMethod camError(err) [ Language = javascript ]
	{
	     alert("The following error occurred:"+err.name);
	}
	 
	ClassMethod SaveImageToDB(snap As %ZEN.Component.component) [ ZenMethod ]
	{
	    Try {
	        set img = snap
	        set file = ##class(%FileBinaryStream).%New()
	        set file.Filename="C:\Temp\00001snapshot.png"
	        set photo=$P(img.src,",",2)
	        do file.Write($System.Encryption.Base64Decode(photo))
	        do file.%Save()
	    }
	    Catch(ex) {
	        &js<alert('Error in Server method:\n#($ZCVT(ex.DisplayString(),"O","JS"))#');>    }
	    Quit
	}
}
