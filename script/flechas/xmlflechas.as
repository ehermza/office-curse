
/*
var totalbotones:Number;
var totalitems:Number;
var origenArray:Array = new Array();
var destArray:Array = new Array();
var rptasArray:Array;
var btsArray:Array;
 */
 
 #include "script/corrector.as"
 
 var destArray:Array = new Array();
 var origenArray:Array = new Array();


var ptXML:XML = new XML();
System.useCodepage=true;
ptXML.ignoreWhite=true;

ptXML.onLoad = function(success) 
{
	if(!success) return;
	
	var aptllas:Array = new Array();
	var xmlcontainer= this.firstChild.childNodes;
	
	for(var i=0; i<xmlcontainer.length; i++)
	{
		var tl= xmlcontainer[i].nodeName;
		var tc= xmlcontainer[i].firstChild.nodeValue;
		
		if(tl.indexOf("titulo")!=-1) {
			mctitle.texto.htmlText= corregir(tc);
		} else if(tl.indexOf("intro")!=-1) {
			txtintro.htmlText = corregir(tc);
		} else if(tl.indexOf("origenes")!=-1) {
			origenArray = tc.split("|");
		} else if(tl.indexOf("destinos")!=-1) {
			destArray = tc.split("|");
		} else if(tl.indexOf("rptas")!=-1) {
			rptasArray = tc.split(',');
		} else if(tl.indexOf("msj1erfallo")!=-1) {
			fbotravez.texto.htmlText = tc;
		} else if(tl.indexOf("msj2dofallo")!=-1) {
			fbperdiste.texto.htmlText = tc;
		}  else if(tl.indexOf("msjacierto")!=-1) {
			fbcorrecto.texto.htmlText = tc;
		}  else if(tl.indexOf("botones")!=-1) {
			btsArray = tc.split('|');
		}		
	}	
	totalitems = 3;
	iniciar();			// flechas.as
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
