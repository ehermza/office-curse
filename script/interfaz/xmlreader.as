
function depurarInfo(nodoinfo)
{
	var aChild:Array= nodoinfo.childNodes;
	
	for(var l=0; l<aChild.length; l++)  
	{	
		if(aChild[l].nodeName == "subtitle")
			asubtitles.push(aChild[l].firstChild.nodeValue);
			
		else if(aChild[l].nodeName == "title")
			atitles.push(aChild[l].firstChild.nodeValue);
			
		else if(aChild[l].nodeName == "filename")
			afilename.push(aChild[l].firstChild.nodeValue);
			
		else if(aChild[l].nodeName == "texto")
			ateoria.push(aChild[l].firstChild.nodeValue);
	}
}
var myXML:XML = new XML();
System.useCodepage=true;
myXML.ignoreWhite=true;
myXML.load("apuntador.xml");
myXML.onLoad = function(success) 
{
	if(!success) return;
	
	var aptllas:Array = new Array();
	var xmlcontainer= this.firstChild.childNodes;
	
	for(var i=0; i<xmlcontainer.length; i++)
	{
		//if(xmlcontainer[i].nodeType == "teoria")
		var ptype= xmlcontainer[i].attributes["type"];
		aptllaType.push(ptype)
		depurarInfo(xmlcontainer[i]);
	}	
	Init(xmlcontainer.length);		// arrancar indicando cant de nodos declarados en xml.
}
