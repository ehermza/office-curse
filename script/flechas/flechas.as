
#include "script/flechas/xmlflechas.as"

var dibujarNo:Number;


var btpres = "";
var flname = "";
var origenActual:Number =-1;

var ohechos:Array = new Array();		// array de origenes marcados antes
var dhechos:Array = new Array();		// array de destinos marcados antes

var pressArray:Array;
var btsArray:Array = new Array();

var btX:Number;
var btY:Number;
var count:Number= 0;
var nReiterar;


function ocultar(bool:Boolean) 
{
	for (var l=1; l<=totalitems; l++) {
		setProperty("flecha"+ l, _visible, !bool);
	}
}

function colorearfl(flname, orig, dest, colorfl, n)
{
	createEmptyMovieClip(flname, n);
	var orx = eval(orig)._x;
	var ory = eval(orig)._y;
    eval(flname).moveTo(orx, ory);
	eval(flname).lineStyle(2, colorfl, 100);
	
	var dtx = eval(dest)._x;
	var dty = eval(dest)._y;
    eval(flname).lineTo(dtx, dty);
}
function deletefl()
{
	for (var i:Number=1; i<=totalitems; i++)
	{
		eval("flecha"+ i).removeMovieClip();
	}
}
function comprobar(colorear:Boolean)
{
	if(!colorear) 
		ocultar(true);	
	var malhecho:Boolean= false;
	
	for (var i:Number=1; i<=totalitems; i++)
	{		
		//var eligio:Number= pressArray[i-1];		
		var difer:Boolean= (pressArray[i-1]!= rptasArray[i-1]);
		if(!malhecho) malhecho= difer;
		
		if (colorear) {
			var flname = "flecha" + i;
			var florig = "btorigen" + i;
			var fldest = "btdest" + pressArray[i-1];
			var colorbt = (!difer)? 0x00FA00: 0xFA0000;		
			colorearfl(flname, florig, fldest, colorbt, i);
		}
//		colorbt = (!difer)? "lblCorrect": "lblWrong";		
		//eval("flecha"+ i).gotoAndStop(colorbt);
	}
	if(colorear) return;
	
	var strbt = "";
	if(malhecho) {
		strbt= (!nReiterar)? "fbotravez": "fbperdiste";
		eval(strbt)._visible = true;
		nReiterar++;
	} else {
		fbcorrecto._visible = true;
	}
		
}

function IsBloq(btn:Number, bdestine:Boolean) :Boolean
{	
	//trace(dhechos)
	if(bdestine)
	{
		for(var i=0; i< dhechos.length; i++){
			if(btn == dhechos[i]) 
				return true;
		}		
	} else {
		for(var t=0; t< ohechos.length; t++){
			if(btn == ohechos[t]) 
				return true;
		}
	}
	return false;
}

function cargarItemsTexto(nro:Number)
{
	var objOrigen = "txtorigen"+ nro;
	eval(objOrigen).htmlText = origenArray[nro- 1];
	
	var objDest = "txtdest"+ nro;
	eval(objDest).htmlText = destArray[nro- 1];

}

function colocando(idbt:Number) 
{
	count++;
	eval(flname)._visible = true;	
	pressArray[origenActual-1] = idbt;		
	ohechos.push(origenActual);
	dhechos.push(idbt);
	
	origenActual =-1;
	eval(btpres)._visible = false;

	if(count == totalitems)
		btn1._visible = true;

}

function dibujar(idfl, lx, ly)
{
	flname= "flecha"+ idfl;
	createEmptyMovieClip(flname, idfl);
    eval(flname).moveTo(lx, ly);
	eval(flname).lineStyle(2, 0x666666, 100);
    eval(flname).lineTo(_xmouse, _ymouse);
}

function cargarItemsFlechas(idbt:Number) 
{
	var btDest = "btdest"+ idbt;
	

/*		if(IsBloq(idbt, true)) return;
		if(origenActual==-1) return;
		
		pressArray[origenActual-1] = idbt;	
		//ReDraw(origenActual, btX, btY, _xmouse, _ymouse);
		
		ohechos.push(origenActual);
		dhechos.push(idbt);
		
		origenActual =-1;
		eval(btDest).gotoAndStop("selected");
		
		//trace(count)
		if(count == totalitems)
			btn1._visible = true;
	}
*/	
	var btOrigen = "btdrag"+ idbt;
	eval(btOrigen)._alpha = 0;	
	eval(btOrigen).onPress = function()
	{
		btpres= this;
		origenActual= idbt; 
		btX = _xmouse;
		btY = _ymouse;
		this.startDrag();
		dibujarNo = setInterval(dibujar, 50, idbt, this._x, this._y);		
	}
	eval(btOrigen).onRelease = function() 
	{
		//trace(this);
		clearInterval(dibujarNo);	

		eval(flname)._visible = false;	//es necesario borrar la flecha para saber si debajo del btn invisible esta el destino o no;
		eval(btpres).stopDrag();
		
		var destname = eval(btpres)._droptarget;
		if (destname.indexOf("btdest")!=-1) {
			// flecha es arrastrada hasta alguno de los n destinos
			var strinit = destname.lastIndexOf("/");	
				strinit+= "/btdest".length
			var r= destname.substr(strinit, 1);
			colocando(int(r));
		} else {
			eval(flname).removeMovieClip();
			eval(btpres)._x= btX;
			eval(btpres)._y= btY;
		}
	}
	
}
function mostrarsolucion()			//rehacer
{
	deletefl();
	setProperty(mcsolucion, _visible, true);
/*	pressArray = new Array(totalitems);
	for (var i:Number=1; i<=totalitems; i++)
	{
		var rpta:Number= rptasArray[i-1];	
		pressArray[i-1]= rpta;
		var btXo:Number= eval("btorigen"+ i)._x;
		var btyo:Number= eval("btorigen"+ i)._y;
		var btXd:Number= eval("btdest"+ rpta)._x;
		var btyd:Number= eval("btdest"+ rpta)._y;
		//ReDraw( i, btXo, btyo, btXd, btyd);
	}	
	comprobar(true);
*/	
}
function CerrarPopup(fbcorrecto:Boolean )
{	
	//ocultar(false);
	comprobar(true);
	if(fbcorrecto) return;
	
	if (nReiterar==1) {
		btn2._visible = true;
	} else {
		btn3._visible = true;
	}
}

function PresionarBt(btn:String)
{
	eval(btn).onRelease = function() 
	{
		if(btn.indexOf("btn1")!=-1) {
			comprobar(false);
		} else if(btn.indexOf("btn2")!=-1){
			deletefl();
			nextFrame(); 
		} else if(btn.indexOf("btn3")!=-1){
			mostrarsolucion(); 
		}
		this._visible = false;			
	}
}
function CargarBotones()
{
	for(var i=1; i<=btsArray.length; i++) 
	{
		var bt= "btn"+ i;
		PresionarBt(bt);
		eval(bt)._visible = false;			
		
		bt+= ".texto";
		eval(bt).htmlText = btsArray[i-1];
	}
	trace(btsArray);
}
function precarga(theFirst:Boolean)
{
	pressArray= new Array(totalitems);
	if(theFirst)
	{
		nReiterar= 0;
//		btSiguiente(false);
	}
	ptllablanca._visible = false;
	mcsolucion._visible = false;
}


function iniciar()
 {
	for (var i:Number=1; i<=totalitems; i++)
	{
		cargarItemsFlechas(i);
		cargarItemsTexto(i);
		
	}
	CargarBotones();
	
	precarga(isNaN(nReiterar));
}
