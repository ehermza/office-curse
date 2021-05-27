
#include "script/corrector.as"
#include "script/mchoice/xmlchoice.as"
#include "script/mchoice/random.as"

/*
var aPreguntas:Array;	
var rptasArray:Array;
var aOpciones:Array;
var totalPorItem:Array;
var totalpreguntas:Number;
var txtAprobado= "";
var txtDesaprobo= "";
*/
var rptasDelalumno:Array = new Array();

var PGTASxPTLLA:Number = 2;
var PantallaActual:Number= 0;
var COORDINIT:Number = 210;
var elementos:Array = new Array();
var mostrarRptas:Boolean;
var elegidos:Array = new Array();			//	comprobar si presiono en todos los enunciados q componen la pantalla
var lastPantalla:Number= 1;

var testResuelto:Boolean= false;

var FRBLANK:Number = 1;
var FRPRESS:Number = 2;
var FRACIER:Number = 3;
var FRERROR:Number = 4;
var FRCORRE:Number = 5;

function getCoordenada(nivelnro:Number, itemnro:Number): Number
{
	return (COORDINIT + nivelnro * 150 + itemnro * 35);
}
function getPtaNumero(nivel:Number, item:Number) 
{
	return (PantallaActual * PGTASxPTLLA) + item;
}

function Comprobar(nivel:Number, item:Number):Boolean
{
	// comprueba si se han respondido a todas las preguntas que aparecen en la pantalla actual
	if(lastPantalla > PantallaActual) 
		return true;
		
	elegidos[nivel]= 1;

	for(i=0; i< PGTASxPTLLA; i++) {
		if(elegidos[i]!= 1)	
			return false;
	}
	elegidos = new Array();
	return true;
}

function PintarOpcion(nconsigna:Number, nivel:Number, btpres:String) 
{
	if(rptasDelalumno[nconsigna-1]) 
	{
		for (var i=1; i<=totalPorItem[nconsigna-1]; i++) {
			var stroption = "ptcheck" + nivel;
			stroption+= "_item" + i;
			eval(stroption).gotoAndStop(FRBLANK);
		}		
	}
	eval(btpres).gotoAndStop(FRPRESS);		// marcar rpsta marcada por alumno
}

function VerResultados(nconsigna:Number, nivel:Number)
{
	var respondi:Number= rptasDelalumno[nconsigna];
	var correcto:Number= rptasArray[nconsigna];	
	
	if(respondi!= correcto) 
	{
		var mcalumno= "ptcheck" + nivel + "_item" + respondi;
		var mccorrec= "ptcheck" + nivel + "_item" + correcto;
		eval(mcalumno).gotoAndStop(FRERROR);
		eval(mccorrec).gotoAndStop(FRCORRE);
	} else {
		var mcpintar = "ptcheck" + nivel +"_item" + correcto;
		eval(mcpintar).gotoAndStop(FRACIER);		
	}
}

function BtsSiguiente()
{
	btAnterior._visible = (PantallaActual != 1);		
	if (totalpreguntas == rptasDelalumno.length) {
		BtsCompletar();
		return;
	}
	btSiguiente._visible = PantallaActual+ 1 <= lastPantalla;
	
}
function BtsCompletar()
{
	var completo = (PantallaActual == getTotalPtllas());
	btSiguiente._visible = !completo
	btfinalizar._visible = completo;
}

function OnPressEvent(btopcion:String)
{
	eval(btopcion).onRelease = function() 
	{
		if(testResuelto) return;
		var btpress:String= this._name;
		var nivel= Number(btpress.charAt(7));
		var itemnro = Number(btpress.charAt(13));
		
		var consigna = nivel + (PantallaActual -1)* PGTASxPTLLA;
		
		rptasDelalumno[consigna-1] = itemnro;
		PintarOpcion(consigna, nivel, btpress);
		
		var PtllaR = Comprobar(consigna% PGTASxPTLLA, itemnro);
		if(lastPantalla == PantallaActual && PtllaR)
		{
			lastPantalla++;
			BtsCompletar();
		}
	}
}

function printOpcion(nconsigna:Number, itemnro:Number, nivelnro:Number):Void
{
	//var nivelnro:Number = item % PGTASxPTLLA;
	var opcionstr = aOpciones[nconsigna][itemnro-1];
	var ptopcion = "ptopcion" + nivelnro;
	ptopcion += "_item" + itemnro;
	
	var t:Number= getCoordenada(nivelnro-1, itemnro);
	attachMovie("mc_opcion", ptopcion, this.getNextHighestDepth(), {_x:470, _y:t});
	eval(ptopcion).texto.htmlText = opcionstr;
	
	elementos.push(ptopcion);
}

function printConsigna(itemnro:Number, nivelnro:Number):Boolean
{
	//var nivelnro:Number = item % PGTASxPTLLA;
	var consignastr= aPreguntas[itemnro];
	if(consignastr == undefined) 
		return false;
	var question:String = "ptquestion" + nivelnro;
	
	var t:Number= getCoordenada(nivelnro, 0);
	attachMovie("mc_consigna", question, this.getNextHighestDepth(), {_x:400, _y:t});		
	var tl = itemnro + 1;
		tl+= ".- " + corregir(consignastr);
	eval(question).texto.htmlText = tl;
	elementos.push(question);
	
	return true;
}

function printCheck(itemnro:Number, nivelnro:Number, inhabilitar:Boolean):Void
{
	var ptcheck = "ptcheck" + nivelnro;
	ptcheck += "_item" + itemnro;
	
	var t:Number= getCoordenada(nivelnro-1, itemnro);
	attachMovie("mc_check", ptcheck, this.getNextHighestDepth(), {_x:100, _y:t});	
	
	OnPressEvent(ptcheck);		
	elementos.push(ptcheck);
}
function CalcularItem(ptllaActual:Number, nivel:Number):Number
{
	return (ptllaActual* PGTASxPTLLA) + nivel;
}

function limpiarPtlla():Void
{
	for (var t=0; t< elementos.length; t++)
	{
		eval(elementos[t]).removeMovieClip();
	}
	elementos = new Array();
}

function MostrarPtlla(ptllaActual:Number, mostrarRptas:Boolean):Void
{
	limpiarPtlla();
	
	for (var t=1; t<=PGTASxPTLLA; t++)
	{
		var nconsigna:Number = CalcularItem(ptllaActual-1, t-1);
		var hayPregunta= printConsigna(nconsigna, t-1);
		if(!hayPregunta) return;
		
		for (var i=1; i<=totalPorItem[nconsigna]; i++) 
		{
			printOpcion(nconsigna, i, t);
			printCheck(i, t, mostrarRptas);
		}
		var rpta= rptasDelalumno[nconsigna];
		
		if(testResuelto)
		{
			VerResultados(nconsigna, t);
		}
		else if(!isNaN(rpta)) {
			var btpress = "ptcheck" + t 
				btpress+= "_item" + rpta;
			PintarOpcion(nconsigna, t, btpress);		
		}
		
	}
}
var finalizar:Boolean;

function getTotalPtllas():Number
{
	var totalptllas:Number= int(totalpreguntas/PGTASxPTLLA);
	totalptllas+= (totalpreguntas % PGTASxPTLLA > 0)? 1: 0;
	//trace("totalptllas: "+ totalpreguntas)
	return totalptllas;	
}
function Navegar(avanzar:Boolean):Void 
{
	if(getTotalPtllas()== PantallaActual- 1)
		mctextofinal._visible= false;	
	PantallaActual+= (avanzar)? 1: -1;
	BtsSiguiente();
	MostrarPtlla(PantallaActual, mostrarRptas);
}

function CalcularPtje():Number
{
	var ptos:Number= 0;
	for (var t=0; t<totalpreguntas; t++){
		ptos+= (rptasArray[t]== rptasDelalumno[t])? 1: 0;
	}
	return int(100*ptos/totalpreguntas);
}

function mostrarFeedback() 
{
	mctextofinal._visible= true;
	if(!testResuelto)
	{
		testResuelto= true;
		var ptos:Number= CalcularPtje();
		mctextofinal.texto.htmlText
		var strfinal= "\n PUNTAJE FINAL: " + ptos + "% \n";
			strfinal+= (ptos>= 70)? txtAprobado: txtDesaprobo;
		mctextofinal.texto.htmlText = strfinal;
	}
}
mctextofinal._visible= false;	
