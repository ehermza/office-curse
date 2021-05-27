
#include "getfilename.as"

var atlines:Array;			// array de pasos agregados al xml

function gotoframe(nframe:Number) {
	gotoAndPlay(nframe);
}

var tlXML:XML = new XML();
//System.useCodepage=true;
tlXML.ignoreWhite=true;

tlXML.onLoad = function(success) 
{
	if(!success) 
		return;	
	atlines = new Array();
	var ctdor:Number = 1;
	var xmlcontainer= this.firstChild.childNodes;
	
	for(var i=0; i<xmlcontainer.length; i++)
	{
		//var l= xmlcontainer[i].firstChild.nodeValue;
		var tlname= (xmlcontainer[i].nodeName);
		if(tlname.indexOf("tline")!=-1)
		{
			var idstr= tlname.substring("tline".length, tlname.length);
			var idint:Number = Number(idstr);
			if(ctdor == idint) {
				atlines.push(xmlcontainer[i].firstChild.nodeValue);	
				ctdor++;
			}
		}
	}	
	_level0.sendtlines(atlines);
	_level0.playtline();
}

function loadtline(englsh:Boolean)
{
/*	var from= path.lastIndexOf('/')+ 1;
	var filename = path.substring(from, path.length);
	var to:Number = filename.indexOf('.');
	var xmlname= filename.substring(0, to)+ ".xml";
	//trace(xmlname);
*/
	var path = (englsh)? "xml/english/" : "xml/espanol/";
	var xmlname = getfilename(_url, '.xml', path);
	
	//atlines = new Array();
	tlXML.load(xmlname);
	_level0.apuntar(this);
}
if (_parent == undefined) {
	loadtline(true);
}