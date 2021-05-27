

import com.greensock.*;
import com.greensock.easing.*;

#include "script/interfaz/sndpaso.as"
#include "script/corrector.as"

var arraytl:Array;			// array de pasos agregados al xml
var interplay:Number= 0;

var FPS = 30;

function getreloj(currentfr:Number) :String
{
	var timer= "00:"
	var total:Number= Math.ceil(currentfr/FPS);
	if(total >59) {
		var l= (total/60);
		timer = (l<10)? "0"+ l: l;
		timer+= ":";
	}
	var f= (total >59)? total^60: total;
	timer+= (f<10)? "0"+ f: f;
	
	return timer;
}
var totalframes:Number;
var totalprogr:Number;

var blplaying:Boolean;

function finalCaptura()						
{
	clearInterval(interplay);
	interplay= 0;
	blplaying = false;
	mcvisor.mcteoria.idactual.text = "";
	mcvisor.mcteoria.texto.htmlText= "";	
	
	mc_reiniciar._visible = true;
	TweenLite.from(mc_reiniciar, 1, {_alpha:0, ease:Back.easeInOut});
	lightsgte.play();
}

function mostrartl() 
{
	var currentfr= mcpantalla._currentframe;
	var reloj= getreloj(currentfr);
	//trace(mcpantalla._currentframe)
	var ptaje:Number = currentfr/totalframes;
	var frametl:Number = Math.ceil(totalprogr* ptaje);

	mcvisor.tlprogres.gotoAndStop(frametl);	
	mcvisor.timer.text = reloj;
	if(currentfr == totalframes) {
		//finalCaptura();
	}
}

function playtline() // llamado desde 'simulacion.as al arrancar simulacion.
{	
	trace("playtline!")
	mcpantalla.play();
	totalframes= mcpantalla._totalframes;
	totalprogr = mcvisor.tlprogres._totalframes;

	blplaying = true;
	interplay = setInterval(mostrartl, 255);
}

function prestline(idtl:Number) 			//llamado desde mclip 'tlprogress.bt
{
	if(!blplaying)return;	
	
	var ptaje:Number= idtl /40;	
	var currentfr:Number= ptaje* totalframes;
	mcpantalla.gotoframe(Math.ceil(currentfr));	
	
	mcvisor.mcteoria.idactual.text = "";
	mcvisor.mcteoria.texto.htmlText= "Cargando..";
}

function setformato(resaltar) 
{
	var ft:TextFormat= mcvisor.mcteoria.idactual.getNewTextFormat();
	ft.color= (resaltar)? 0xFFCC33: 0xFFFFFF;
	//ft.bold = resaltar;
	mcvisor.mcteoria.idactual.setTextFormat(ft);
	mcvisor.play();
	//mcvisor.fondo._visible = resaltar;	
}
var intPausadoAutomat= 0;

function replay () 
{
	clearInterval(intPausadoAutomat);
	intPausadoAutomat = 0;
	setformato(false);
	presbtplay();
	//mcpantalla.play();
}

function presbtplay(blpress)
{
	if(interplay== 0)
		return;
	//trace()
	if(blplaying) {
		blplaying = false;
		mcpantalla.stop();
		mcvisor.btplay.gotoAndStop("ftplay");
		return;
	} 	
	blplaying = true;
	if(blpress && intPausadoAutomat!= 0) {		// alumno quiere esquivar el paso..
		clearInterval(intPausadoAutomat);
		intPausadoAutomat = 0;
		//txtdebug.text = intPausadoAutomat;
		setformato(false);
	}
	mcpantalla.play();
	mcvisor.btplay.gotoAndStop("ftpause");
	mcfondo._visible = false;
}

import mx.transitions.Tween;

function tlinetxt(idtl:Number)		// función llamada desde ptlla.contenido
{
	var tlconten= arraytl[idtl-1];
	trace("tlconten: "+ tlconten)
	var str = "Paso ";
		str+= (idtl<10)? "0"+ idtl: idtl;
	
	//new Tween(mcvisor, "_y", Strong.easeOut, 626, 300, 1, true);
	mcfondo._visible = true;
	new Tween(mcfondo, "_alpha", Regular, 0, 80, 1, true)
	
	mcvisor.mcteoria.idactual.text = str;
	mcvisor.mcteoria.texto.htmlText= corregir(tlconten);
	setformato(true);
	
	//intPausadoAutomat= setInterval(replay, 4095);
	presbtplay();		
	playSoundPaso(idtl);
}

function reiniciar() 
{
	mc_reiniciar._visible = false;
	CambiarPtlla(Number.POSITIVE_INFINITY);	
}

function sendtlines(atlines:Array)
{
	arraytl = atlines;
}

mc_reiniciar._visible=0;	// hugo