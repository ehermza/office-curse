
class clases.Navegacion 
{
	//var aPtlla: Array;
	var ptactual: Number;
	var ptvistas: Number;
	var aPtllasVistas: Array;		// datashared
	var totalptllas: Number;
	var blhabilit: Boolean;	
	
	function Navegacion() {
		ptactual = 0;
		ptvistas = 0;
		blhabilit = true;
	}
	
	function getotalptllas(): Number {
		return this.totalptllas;
	}
	
	function iniciar(totalpt:Number) 	
	{
		//this.aPtlla = ptarray;
		this.totalptllas = totalpt;	
		this.aPtllasVistas = new Array();
		
		for(var t=0; t<totalpt; t++) {
			aPtllasVistas.push('N');
		}
	}

	function getPtjeVistas(): Number
	{
		return int(this.ptvistas* 100 /totalptllas);
	}
	
	function avanzar(): Number			// devuelve el filename de la sgte ptlla
	{
		if(!blhabilit) return 0;
		if(totalptllas == ptactual)
			return 0;	
		ptactual+= 1;
		
		if(aPtllasVistas[ptactual-1]== 'N') {
			aPtllasVistas[ptactual-1]= 'V';
			ptvistas+= 1;
		}
		trace(aPtllasVistas)

		return ptactual;
	}
	
	function atrasar(): Number		// devuelve el filename de la ptlla anterior
	{
		if(!blhabilit) return 0;
		if(ptactual == 1)
			return 0;
		ptactual-= 1;

		return ptactual;
	}
	
	function setptactual(id:Number)
	{
		ptactual = id;
	}
	function getptactual():Number
	{
		return ptactual;
	}
	function habilitar() {
		blhabilit= true;
	}
	function deshabilitar() {
		blhabilit= false;
	}
}
