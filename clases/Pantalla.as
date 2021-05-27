
class clases.Pantalla
{
	var ptactual: Number;
	var titles: Array;
	var subtitles: Array;
	var contenido: Array;	
	var filename: Array;
	var ptllatype: Array;
	
	function Pantalla(t:Array, st:Array, files:Array, ptype:Array) {
		this.titles = t;
		this.subtitles = st;
		this.ptllatype = ptype;
		this.filename = files;
	}
	public function setContenido(ptype:Array) {
		this.contenido = ptype;
	}
	public function setPtllaActual(idptlla:Number) {	
		this.ptactual = idptlla;
		trace("pt: "+ ptactual)
	}
	public function getitulo():String {
	//trace(titles)
		return this.titles[ptactual-1];
	}
	public function getsubtitle():String {
		return this.subtitles[ptactual-1];
	}
	public function getfilename():String {
		return this.filename[ptactual-1];
	}
	public function getContenido():String {
		return this.contenido[ptactual-1];
	}
	public function getPtllaType():String {
		return this.ptllatype[ptactual-1];
	}
}
