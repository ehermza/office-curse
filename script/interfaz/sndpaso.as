
var objsndmp3: Sound = new Sound();

var myInterval: Number;

function pr(soundObj:Object):Void 
{
    var numBytesLoaded:Number = soundObj.getBytesLoaded();
    var numBytesTotal:Number = soundObj.getBytesTotal();
    var numPercentLoaded:Number = Math.floor(numBytesLoaded / numBytesTotal * 100);
	
	trace("numPercentLoaded: "+ numPercentLoaded);
	
    if (!isNaN(numPercentLoaded))  {

		if(numPercentLoaded == 100) 
			clearInterval(myInterval);
    } 
};

objsndmp3.onSoundComplete = function()
{
	replay();	// simulacion.as
}

objsndmp3.onLoad = function(t) 
{
	if(t) {
		this.start();
	}
}

// When the file has finished loading, clear the interval interlocutoring.
function playSoundPaso(idpaso:Number) 
{
	var mp3name = "/";
		mp3name+= (idpaso< 10)? "0"+ idpaso: idpaso;
		mp3name+= ".mp3";

	var ptname = objp.getfilename();
	var dirname= ptname.substring(0, ptname.indexOf('.'));
	
	var mp3file = _url.substring(0, _url.lastIndexOf('/'));
		mp3file+= "/locucion/"+ dirname + mp3name;	
	
	objsndmp3.loadSound(mp3file, false);
	objsndmp3.setVolume((blVolumenOn)? 100: 0);
	//myInterval = setInterval(pr, 511, objsndmp3);
}

