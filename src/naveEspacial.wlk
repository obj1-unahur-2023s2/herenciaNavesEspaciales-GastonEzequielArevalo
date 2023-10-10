class NaveEspacial {
	var property velocidad = 0
	var property direccion = 0
	
	method acelerar(cuanto){
		velocidad = velocidad + 100000.min(cuanto)
	}
	
	method desacelerar(cuanto){
		velocidad = velocidad - 0.max(cuanto)
	}
	
	method irHaciaElSol(){
		direccion = 10
	}
	
	method escaparDelSol(){
		direccion = -10
	}
	
	method ponerseParaleloAlSol(){
		direccion = 0
	}
	
	method acercarseUnPocoAlSol(){
		direccion = 10.min(direccion + 1)
	}
	
	method alejarseUnPocoDelSol(){
		direccion = -10.max(direccion - 1)
	}
}


class NaveBaliza inherits NaveEspacial{
	var property baliza
	
	method cambiarColorDeBaliza(otroColor){
		baliza = otroColor
	}
	
}

class NavePasajero inherits NaveEspacial{
	var property cantidadDePasajeros 
	var property racionesDeComida = 0
	var property racionesDeBebida = 0
	
	method cargarRacionesDeComida(cantidad){
		racionesDeComida += cantidad
	}
	
	method descargarRacionesDeComida(cantidad){
		racionesDeComida = 0.min(racionesDeComida - cantidad)
	}
	
	method cargarRacionesDeBebida(cantidad){
		racionesDeBebida += cantidad
	}
	
	method descargarRacionesDeBebida(cantidad){
		racionesDeBebida = 0.min(racionesDeBebida - cantidad)
	}
	
}

class NaveDeCombate inherits NaveEspacial{
	var property estaVisible
	var property cantDeMisiles
	
	method ponerseVisible(){
		estaVisible = true
	}
	
	method ponerseInvisible(){
		estaVisible = false
	}
	
	method estaInvisible(){
		return estaVisible
	}
	
	method desplegarMisiles(){
		cantDeMisiles = 0
	}
	
	method replegarMisiles(){
		return cantDeMisiles
	}
	
	method misilesDesplegados(){
		return cantDeMisiles
	}
	
	
}