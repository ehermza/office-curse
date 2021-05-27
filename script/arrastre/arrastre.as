
//var totalrptas:Number;
var inhabilitar:Array = new Array();
var aciertos:Array = new Array();
var btNormales:Array = new Array();
var totaldestinos:Number;
var btnsArray:Array = new Array();
var btpuestos:Number= 0;
var oracionArray: Array= new Array(3);

if (isNaN(nReiterar))
{
	var nReiterar:Number= 0;

	var btX:Number;
	var btY:Number;

	var colorR= "f10000";
	var colorG= "00a100";
	var colorB= "050070";
	var btsok:Array = new Array();
	var colocadas:Array = new Array();

}
#include "script/corrector.as"
#include "script/arrastre/xmlarrastre.as"

function btSiguiente(habilitar:Boolean) 
{
}

function reubicar(btn:String)
{
	eval(btn)._x = btX;
	eval(btn)._y = btY;
}

function setColorbt(nrobtn:Number, colorbt)
{
	var strbtn = "btdrag"+ nrobtn  + ".texto";

	var txtcolor = "<font color='#";
		txtcolor+= colorbt + "'>";
		txtcolor+= btnsArray[nrobtn-1];
		txtcolor+= "</font>";
	eval(strbtn).htmlText = txtcolor;		
}
function reiniciar()
{
	for (t=0; t<colocadas.length; t++) 
	{
		if(btsok[t] > 0)
		{
			var l:Number = btsok[t];
			var btdrag:String= "btdrag"+ l;
			var target:String= "btrpta"+ (t+1);
			responder(btdrag, target);
			setColorbt(l, "");
			btpuestos++;
		}
	}
	colocadas = new Array();
}

function malhecho():Boolean 
{	
	var difer:Boolean = false;
	
	for(var i=1; i<=colocadas.length; i++)  
	{
		var l= colocadas[i-1];
		if(l!= undefined) {
			if(!difer)
				difer= (l!= i);
		}
	}	
	return difer;
}
function comprobar()
{
	btn1._visible = false;

	if(malhecho()) 
	{
		var strbt= (!nReiterar)? "fbotravez": "fbperdiste";
		eval(strbt)._visible = true;		
		for(var i=1; i<=colocadas.length; i++)  
		{
			var l= colocadas[i-1];
			if(l!= undefined) {
				var itsgood:Boolean= (l==i);
				setColorbt(l, (itsgood)? colorG: colorR);
				btsok[i-1] = (itsgood)? l: 0;
			}
		}
		nReiterar++;
		return;
	} 

	fbcorrecto._visible = true;
	btSiguiente(true);			
}

function mostrarsolucion()
{
	for(var i=1; i<=btNormales.length; i++) 
	{		
		var strbtrpta = "btrpta" + i;
		var strbtdrag = "btdrag"+ i;
		if(eval(strbtrpta)!= undefined) {
			var cordx:Number= eval(strbtrpta)._x;
			var cordy:Number= eval(strbtrpta)._y;
			eval(strbtdrag)._x = cordx;
			eval(strbtdrag)._y = cordy;
			setColorbt(i, colorG);
			
		}  else {
			eval(strbtdrag)._visible = false;
		}
	}
}

function PosicAnterior(rpsta:Number):Number {
	var l:Number= -1;
	for(var i=0; i<=colocadas.length; i++) {
		if(colocadas[i] == rpsta)
			l= i;
	}
	return l;
}

function responder(btn:String, target:String)
{	
	//inhabilitar.push(btn);
	eval(btn)._x = eval(target)._x;
	eval(btn)._y = eval(target)._y;
	
	var tcant:Number= (target.length== "/btrptaxx".length)? 2: 1;
	var tid:Number= int(substring(target, "/btrptax".length, tcant));
	var dcant:Number= (btn.length== "btdragxx".length)? 2: 1;
	var did:Number= int(substring(btn, "btdragx".length, dcant));

	//suprimirPtos(tid-1);

	var l:Number= PosicAnterior(did);
	if(l!=-1) {
		colocadas[l] = undefined;
	}
	colocadas[tid-1] = did;
	btpuestos+= (l!=-1)? 0: 1;	
}
function IsPushed(bt:String):Boolean 
{
	for(var i:Number= 0; i<inhabilitar.length; i++)
	{
		if(inhabilitar[i]== bt) 
			return true;
	}
	return false;
}
function ArrastrarBt(btn:String)
{
	eval(btn).onPress = function() 
	{
		if(IsPushed(btn)) return;
		btX = this._x;
		btY = this._y;
		this.startDrag();
	}
	eval(btn).onRelease = function() 
	{
		this.stopDrag();
		var strtarget= this._droptarget;
		//trace(starget)
		if(strtarget.indexOf("btrpta")==-1) {
			reubicar(btn);
			return;
		}
		responder(btn, strtarget);
		
		trace("btpuestos: "+btpuestos);
		if(btpuestos == totaldestinos)
			btn1._visible= true;
	}
}
function cargartexto(btn:String, ide:Number)
{
	var btr= btnsArray[ide];
	eval(btn).texto.htmlText = corregir(btr);
	
	var strfrase = "txtfrase"+ (ide+ 1);
	var dtr= oracionArray[ide];
	eval(strfrase).htmlText = corregir(dtr);
}
function CerrarPopup(fbcorrecto:Boolean )
{	
	if(!fbcorrecto) {
		btn2._visible = (nReiterar==1);
		btn3._visible = !btn2._visible;
	}	
}

function PresionarBt(btn:String)
{
	eval(btn).onRelease = function() 
	{
		if(btn.indexOf("btn1")!=-1) {
			comprobar(false);
		} else if(btn.indexOf("btn2")!=-1){
			nextFrame(); 
		} else if(btn.indexOf("btn3")!=-1){
			mostrarsolucion(); 
			btSiguiente(true);
		}
		this._visible = false;			
	}
	eval(btn)._visible = false;			

}

function iniciar()
{	
	for(var i=1; i<=respuestas.length; i++) 
	{
		var strbtdrag= "btdrag"+ i;

		cargartexto(strbtdrag, i-1);
		//trace(strbtdrag)
		ArrastrarBt(strbtdrag);
	}
	for(var i=1; i<=btNormales.length; i++) 
	{
		var bt= "btn"+ i;
		PresionarBt(bt);
		bt+= ".texto";
		eval(bt).htmlText = btNormales[i-1];
	}	
	//ptllablanca._visible = false;
	btSiguiente(false);
	
	if(nReiterar) reiniciar();	
}

