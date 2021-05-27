
function getfilename(turl, filetype, intro): String
{
	var from= turl.lastIndexOf('/')+ 1;
	var filename = turl.substring(from, turl.length);
	var to:Number = filename.indexOf('.');
	var xmlname = intro;
		xmlname+= filename.substring(0, to);
		xmlname+= filetype;
	trace("getfilename: "+ xmlname);
	return xmlname;
}
/*
var path = "xml/espanol/";
var xmlname = getfilename(_url, '.xml', path);
*/