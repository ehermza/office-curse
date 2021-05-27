
import clases.*;

var atitles:Array = new Array();
var asubtitles:Array = new Array();
var ateoria:Array  = new Array();
var afilename:Array = new Array();
var aptllaType:Array = new Array();

var atlpasos:Array ;

#include "script/interfaz/xmlreader.as"
#include "script/loadimagen.as"
#include "script/interfaz/locucion.as"
#include "script/interfaz/simulacion.as"
#include "script/interfaz/botones.as"

var is_theory:Boolean;
var objn:Navegacion = new Navegacion();
var objp:Pantalla;
//var objc:Contenido = new Contenido();

var blenglish:Boolean = false;

function CambiarIdioma(idioma_bt: MovieClip) 
{
	blenglish= !blenglish;
	idioma_bt.texto.htmlText = (blenglish)? "English": "Español";
	CambiarPtlla(Number.POSITIVE_INFINITY);
	trace("CambiarIdioma!");	
}

function PlayPtlla() 		
{	// llamado desde loadimagen.as una vez cargada la ptlla
	objn.habilitar();
	
	if(!is_theory) {
		mcpantalla.loadtline(blenglish);
		//playtline();	//simulacion.as
		return;
	}
	mcpantalla.loadteoria(blenglish);
	playSound();		//locucion.as
	
}

function CambiarPtlla(nroptlla:Number, btsgte:Boolean)
{
	var ptactual:Number= (nroptlla!= Number.POSITIVE_INFINITY)? nroptlla: objn.getptactual();
	/* Cuando (nroptlla = POSITIVE_INFINITY) se repite pt_actual	*/
	
	if(nroptlla== -1) {
		ptactual= (btsgte)? objn.avanzar(): objn.atrasar();
	} else {
		objn.setptactual(ptactual);	
	}
	if(ptactual==0) return ;
	
	objp.setPtllaActual(ptactual);
	
	var ptaje= objn.getPtjeVistas();
	/*	mostrar precarga y ptaje	*/
	ptjeprogres.text = ptaje;		
	mcprogres.gotoAndStop(Math.ceil(20* Number(ptaje)/ 100));
	
	ctdor.actual.text= ptactual;
	txtitle.htmlText = objp.getitulo();			/*	mostrar titulo	*/
	txtsubtitle.htmlText = objp.getsubtitle();	/*	mostrar subtitulo	*/
	
	var filept = objp.getfilename();	
	var type_pt= objp.getPtllaType();
	is_theory = type_pt.indexOf("teoria")!= -1;
	
	if(is_theory) {
		mcvisor._visible = false;
	}
	else //if(type_pt== "simulacion") 
	{
		mcvisor._visible = true;
		mcvisor.mcteoria.texto.htmlText = "";	
		mcvisor.mcteoria.idactual.text = ""
		mcvisor.tlprogres._visible = true;
	}
	var gtfr= objp.getContenido();
	logoSoft.gotoAndStop(gtfr);
	
	if(!is_theory) {
		/* simulación: Cargar Pantalla */
		stopAllSounds();
		CargarImagen(filept, mcpantalla);		// simulación -call to loadimagen.as	
		return;
	}
	/* teoria: Cargar Locucion	*/	
	mcfondo._visible = false;
	objn.deshabilitar();
	mc_reiniciar._visible = false;
	lightsgte.gotoAndStop("stop");
	stopAllSounds();
	playlocucion(filept, mcpantalla);			// locucion.as
}


function Init(cant:Number)
{
	objp= new Pantalla(atitles, asubtitles, afilename, aptllaType);
	trace("afilename: "+afilename)
	objp.setContenido(ateoria);
	
	objn.iniciar(cant);
	ctdor.total.text= objn.getotalptllas();

	CambiarPtlla(-1, true);
}
