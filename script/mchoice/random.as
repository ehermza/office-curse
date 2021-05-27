

function mezclarPgtas() 
{
	for(var i=0; i<totalpreguntas; i++)
	{
		var r:Number= randomArray[i];
		
		aPreguntas.push(aPreguntasXML[r]);
		rptasArray.push(rptasArrayXML[r]);
		aOpciones.push(aOpcionesXML[r]);
		totalPorItem.push(totalPorItXML[r]);
	}
//	trace("aPreguntas: "+aPreguntas)
}
/*
var aPreguntas:Array = new Array();	
var rptasArray:Array = new Array();
var aOpciones:Array = new Array();
var totalPorItem:Array = new Array();

*/

var randomArray:Array = new Array();

function randomizar()
{
	//var randomArray:Array = new Array();
	var ctdor:Number= 0;
	while(ctdor < totalpreguntas)
	{
		var r:Number= Math.floor(Math.random() * totalpreguntas);
		var repeat:Boolean= false;
		for(var t=0; t<randomArray.length; t++)
		{
			if(randomArray[t] == r) {
				repeat= true;
				break;
			}
		}
		if(!repeat)
		{
			ctdor++;
			randomArray.push(r);
		}		
	}
	mezclarPgtas();
}
