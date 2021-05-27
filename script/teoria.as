
#include "script/corrector.as"
#include "script/getfilename.as"

var atxtlibre:Array = new Array();
var strtitle = ""
function iniciar()
{
	mctitle.texto.htmlText = corregir(strtitle);
	trace("atxtlibre: "+ atxtlibre.length)

	for(var i=0; i<atxtlibre.length; i++) {
		var l= atxtlibre[i];
		if(l!= null)
			eval("txtlibre"+ i + ".texto").htmlText = corregir(l);
	}
}

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
		if(tl.indexOf("txtlibre")!=-1) {
			var p= (tl.substring("txtlibre".length, tl.length));
			var idtl:Number= Number(p); 
			atxtlibre[idtl]= tc;
		}
		else if(tl.indexOf("title")!=-1) {
			strtitle = tc;
		}
	}	
	iniciar();
}

function loadteoria(englsh:Boolean)
{
	var path = (englsh)? "xml/english/" : "xml/espanol/";
	var xmlname = getfilename(_url, '.xml', path);
	atlines = new Array();
	ptXML.load(xmlname);
}

if (_parent == undefined) {
	loadteoria(true);
}
