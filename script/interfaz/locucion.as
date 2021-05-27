
#include "script/getfilename.as"

var blSoundActive:Boolean = false;
var sonido:Sound;
var blVolumenOn = true;
var ptr = this;

function playSound() 
{
	if(blSoundActive) {
		sonido.start();
	}
	trace("blSoundActive: "+ blSoundActive)
	trace("blVolumenOn: "+ blVolumenOn)
}

function playlocucion(strfile: String, ptlla_mc: MovieClip) 	
/*	called from kernel.as	*/
{
	// Create a new Sound object to play the sound.
	var myInterval:Number;
	var filename = strfile;
	var blteoria:Boolean = isteoria;
	sonido = new Sound();	
	//var mp3sound = ""; 
		
	function SoundComplete() {
	/*	Una vez completa la carga de snd 
				se inicia carga pt actual */
		clearInterval(myInterval);
		blSoundActive = true;
		ptr.CargarImagen(filename, ptlla_mc);		// call to loadimagen.as
		trace("SoundComplete!")
	}

	function soundprogress(soundObj:Object):Void 
	/*	llamadas recursivas from playlocucion()	*/
	{
		if(isNaN(soundObj.getBytesLoaded()))
			return;
		if (soundObj.getBytesLoaded()== soundObj.getBytesTotal()) {
			SoundComplete();
			//trace(soundObj.getBytesLoaded());
		} 
	};

	sonido.onSoundComplete = function() {
	/*	luz intermitente bt sgte */
		lightsgte.play();
	}
	
	sonido.onLoad = function(bl:Boolean) {
		if(!bl) return;
		myInterval = setInterval(soundprogress, 511, sonido);
	}
	var mp3sound = getfilename(filename, '.mp3', 'locucion/');

	sonido.loadSound(mp3sound, false);
	sonido.setVolume((blVolumenOn)? 100: 0);
	//myInterval = setInterval(soundprogress, 511, sonido);
}

function mutear()
{
	blVolumenOn= !blVolumenOn;
	sonido.setVolume((blVolumenOn)? 100: 0);
	var l= (blVolumenOn)? "soundon": "soundoff";
	mcaudio.gotoAndStop(l);
}
