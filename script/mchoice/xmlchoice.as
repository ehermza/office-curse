stop();


var aPreguntas:Array ;
var rptasArray:Array = new Array();
var aOpciones:Array = new Array();
var totalPorItem:Array = new Array();

var totalpreguntas:Number;
var txtAprobado= "";
var txtDesaprobo= "";

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
		
		if(tl.indexOf("intro")!=-1) {
			mcintro.htmlText = corregir(tc);
		} 
		else if(tl.indexOf("title")!=-1)  {
			mctitulo.texto.htmlText = corregir(tc);
		}
		else if(tl.indexOf("fbcorrecto")!=-1)  {
			txtAprobado = tc;
		}
		else if(tl.indexOf("fbincorrecto")!=-1)  {
			txtDesaprobo = tc;
		}
		else if(tl.indexOf("rptas")!=-1) 
		{
			rptasArray = tc.split(',');
			totalpreguntas = rptasArray.length;
			 aPreguntas = new Array(totalpreguntas);
			aOpciones= new Array(totalpreguntas)
			for(var t=0; t<totalpreguntas; t++) {
				totalPorItem.push(3); 
			}
		} 
		
		if(tl.indexOf("pregunta")!=-1)  
		{
			var str= tl.substring("pregunta".length, tl.length);
			var id:Number= int(str);			
			var nodopreg= xmlcontainer[i].childNodes;//.firstChild.childNodes;
			//trace(nodopreg.length);
			for(var l=0; l<nodopreg.length; l++)
			{
				var pl= nodopreg[l].nodeName;
				var pc= nodopreg[l].firstChild.nodeValue;
				if(pl.indexOf('question')!=-1) {
					aPreguntas[id-1]= pc;
				}
				if(pl.indexOf('opciones')!=-1) {
					aOpciones[id-1]= pc.split('|');
					
				} 
			}
		}
	}
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
