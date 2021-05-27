

function CargarImagen(imagefile:String, container:Object):Void
{
	var objImagen:Object = new Object();
	
	countpreload++;	
	
	objImagen.onLoadProgress = function(target:MovieClip, 
		bytesLoaded:Number, bytesTotal:Number):Void 
	{
		var pr:Number= Math.ceil(25* bytesLoaded/ bytesTotal);
		mcpreload.gotoAndStop(pr);
		mcpreload.ptaje.text = Math.floor(100* bytesLoaded/ bytesTotal)+ " %";
	}
	
	objImagen.onLoadInit = function(mc:MovieClip) {
		mcpreload._visible = false;
		PlayPtlla();			// kernel.as
	}		
	mcpreload._visible = true;
	mcpreload.gotoAndStop(1);
	mcpreload.ptaje.text = "Cargando..";
	
	var mcLoader:MovieClipLoader = new MovieClipLoader();
	mcLoader.addListener(objImagen);
	mcLoader.loadClip(imagefile, container);
	
}
