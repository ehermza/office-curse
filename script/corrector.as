
function reemplazar(frase:String, rar, rdo):String
{
	var oracion:Array= frase.split(rar);
	return oracion.join(rdo);
}

function corregir(frase:String): String
 {
	frase = reemplazar(frase, "[b]", "<b>");
	frase = reemplazar(frase, "[/b]", "</b>");
	frase = reemplazar(frase, "[br]", "<br>");
	frase = reemplazar(frase, "[li]", "<li>");
	
	return frase;
}
