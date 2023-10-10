class NaveEspacial {
	var velocidad = 0
	var direccion = 0
	var combustible = 0
	
	method velocidad(){
		return velocidad
	}
	
	method direccion(){
		return direccion 
	}
	
	method acelerar(cuanto){
		velocidad += 100000.min(velocidad + cuanto)
	}
	
	method desacelerar(cuanto){
		velocidad -= 0.max(velocidad - cuanto)
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
	
	method prepararViaje(){
		self.cargarCombustible(30000)
		self.acelerar(5000)
		self.accionAdicional()
	}
	
	method accionAdicional()
	
	method combustible(){
		return combustible
	}
	
	method cargarCombustible(unaCantidad){
		combustible += unaCantidad
	}
	
	method descargarCombustible(unaCantidad){
		combustible -= 0.max(combustible - unaCantidad)
	}
	
	method estaTranquila(){
		return combustible >= 4000 and velocidad < 12000
	}
	
	method recibirAmenaza(){
		self.escapar()
		self.avisar()
	}
	
	method escapar()
	
	method avisar()
	
	method estaDeRelajado(){
		return self.estaTranquila() and self.pocaActividad()
	}
	
	method pocaActividad()
}


class NaveBaliza inherits NaveEspacial{
	var colorDeBaliza
	var property cambioColorBaliza = false
	
	method colorDeBaliza(){
		return colorDeBaliza
	}
	
	method cambiarColorDeBaliza(otroColor){
		colorDeBaliza = otroColor
	}
	
	override method accionAdicional(){
		colorDeBaliza = "Verde"
		self.ponerseParaleloAlSol()
	}
	
	override method estaTranquila(){
		return super() and colorDeBaliza!="Rojo"
	}
	
	override method escapar(){
		self.irHaciaElSol()
	}
	
	override method avisar(){
		self.cambiarColorDeBaliza("Rojo")
	}
	
	override method pocaActividad(){
		return not cambioColorBaliza
	}
}

class NavePasajero inherits NaveEspacial{
	var property cantidadDePasajeros 
	var racionesDeComida = 0
	var racionesDeBebida = 0
	var descargadas = 0
	
	method racionesDeComida(){
		return racionesDeComida
	}
	
	method racionesDeBebida(){
		return racionesDeBebida
	}
	
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
		descargadas += 1
	}
	
	override method accionAdicional(){
		self.cargarRacionesDeComida(4 * cantidadDePasajeros)
		self.cargarRacionesDeBebida(6 * cantidadDePasajeros)
		self.acercarseUnPocoAlSol()
	}
	
	override method escapar(){
		self.acelerar(velocidad)
	}
	
	override method avisar(){
		self.descargarRacionesDeComida(cantidadDePasajeros)
		self.descargarRacionesDeBebida(cantidadDePasajeros * 2)
	}
	
	override method pocaActividad(){
		return descargadas < 50 
	}
}

class NaveDeCombate inherits NaveEspacial{
	var estaVisible = true 
	var misilesDesplegados = false
	const mensajes
	
	method estaVisible(){
		return estaVisible
	}
	
	method ponerseVisible(){
		estaVisible = true
	}
	
	method ponerseInvisible(){
		estaVisible = false
	}
	
	method estaInvisible(){
		return not estaVisible
	}
	
	method desplegarMisiles(){
		misilesDesplegados = true
	}
	
	method replegarMisiles(){
		misilesDesplegados = false
	}
	
	method misilesDesplegados(){
		return misilesDesplegados
	}
	
	method mensajes(){
		return mensajes
	}
	
	method emitirMensaje(mensaje){
		mensajes.add(mensaje)
	}
	
	method mensajesEmitidos(){
		return mensajes.size()
	}
	
	method primerMensajeEmitido(){
		if (mensajes.isEmpty()){
			self.error("La lista de mensajes esta vacia")
		}
		return mensajes.first()
	}
	
	method ultimoMensajeEmitido(){
		if (mensajes.isEmpty()){
			self.error("La lista de mensajes esta vacia")
		}
		return mensajes.last()
	}
	
	method esEscueta(){
		return mensajes.all({mensaje => mensaje.size() <= 30})
	}
	
	method emitioMensaje(mensaje){
		return mensajes.contains(mensaje)
	}
	
	override method accionAdicional(){
		self.ponerseVisible()
		self.replegarMisiles()
		self.emitirMensaje("Saliendo en misión")
		self.acelerar(15000)
	}
	
	override method estaTranquila(){
		return super() and not misilesDesplegados
	}
	
	override method escapar(){
		self.emitirMensaje("Amenaza recibida")
	}
	
	override method avisar(){
		self.acercarseUnPocoAlSol()
		self.acercarseUnPocoAlSol()
	}
	
	override method pocaActividad(){
		return self.esEscueta()
	}
}

class NaveHospital inherits NavePasajero{
	var property tienePreparadoQuirofano = false 
	
	override method estaTranquila(){
		return super() and not tienePreparadoQuirofano
	}
	
	override method recibirAmenaza(){
		super()
		tienePreparadoQuirofano = true 
	}
}

class NaveSigilosa inherits NaveDeCombate{
	
	override method estaTranquila(){
		return super() and estaVisible
	}
	
	override method recibirAmenaza(){
		super()
		self.desplegarMisiles()
		self.ponerseInvisible()
	}
	
}