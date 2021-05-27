
btidioma.onRelease = function() {
	CambiarIdioma(this);
}

btnext.bt.onRelease = function() {
	CambiarPtlla(-1, true)
}

btprev.bt.onRelease = function() {
	CambiarPtlla(-1, false);
}

btmute.bt.onRelease = function() {
	mutear();
}

mcvisor.btplay.onRelease = function() {
	presbtplay(true);
}

btsalir.bt.onRelease = function() {
	getURL("javascript:window.close();");
}

mc_reiniciar.btreplay.bt.onRelease = function() {
	reiniciar();		//simulacion.as
}


btexcel.onRelease = function() {
	CambiarPtlla(5);
}

btaccess.onRelease = function() {
	CambiarPtlla(9);
}

btword.onRelease = function() {
	CambiarPtlla(1);
}

btejer.onRelease = function() {
	CambiarPtlla(13);
}
