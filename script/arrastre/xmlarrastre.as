stop();

#include "script/corrector.as"
/*
var totalrptas:Number;
var inhabilitar:Array = new Array();
var aciertos:Array = new Array();
var btNormales:Array = new Array();
var totaldestinos:Number;
var btnsArray:Array = new Array();
var btpuestos:Number= 0;

*/
var ptXML:XML = new XML();
System.useCodepage=true;
ptXML.ignoreWhite=true;

ptXML.onLoad = function(success) 
{
	if(!success) return;
	
	//var aptllas:Array = new Array();
	var xmlcontainer= this.firstChild.childNodes;
	
	for(var i=0; i<xmlcontainer.length; i++)
	{
		var aChild:Array= xmlcontainer[i].childNodes;
		
		for(var l=0; l<aChild.length; l++)  
		{	
			var tl= xmlcontainer[i].nodeName;
			var tc= xmlcontainer[i].firstChild.nodeValue;
			
			if(tl == "title")
				mctitle.texto.htmlText = tc;			
				
			if(tl == "palabras") {
				//btnsArray.push(tc);			
				btnsArray = tc.split(',');
				totaldestinos = btnsArray.length;
			}
			else if(tl == "intro") {
				textoLibre01.htmlText = corregir(tc);
			} else if(tl == "respuestas") 
				respuestas= tc.split(',');
				//totalrptas = respuestas.length;
			
			else if(tl == "botones") 	
				btNormales = tc.split(',');
			
			else if(tl == "msjacierto")
				fbcorrecto.texto.htmlText = tc;
				
			else if(tl == "msj1erfallo")
				fbotravez.texto.htmlText = tc;

			else if(tl == "msj2dofallo")
				fdperdiste.texto.htmlText = tc;
				
			else if(tl == "enunciado01")
				oracionArray[0]= tc;
				
			else if(tl == "enunciado02")
				oracionArray[1]= tc;
				
			else if(tl == "enunciado03")
				oracionArray[2]= tc;
		}
	}
	iniciar();
	//trace(oracionArray)
//	CargarDatos();
}

function loadteoria(uk:Boolean)
{
	var from= _url.lastIndexOf('/')+ 1;
	var filename = _url.substring(from, _url.length);
	var to: Number = filename.indexOf('.');
	var dir:String = (uk)? "xml/espanol/": "xml/english/";
	//var xmlname= filename.substring(0, to)+ ".xml";
	var xmlname= dir + filename.substring(0, to)+ ".xml";
	trace(xmlname);
	
	ptXML.load(xmlname);
}

if(_parent == undefined) {
	loadteoria(true);
}
