class Nave{
	var property velocidad = 0

	method propulsar(){
		if (velocidad + 20000 > self.velocidadMaxima()){
			velocidad = self.velocidadMaxima()
		}
		else{
			velocidad += 20000
		}
	}
	method velocidadMaxima(){
		return 300000
	}

	method recibirAmenaza(){}

	method prepararseParaViajar(){
		if (velocidad + 15000 > self.velocidadMaxima()){
			velocidad = self.velocidadMaxima()
		}
		else{
			velocidad += 15000
		}
	}
}

class NaveDeCarga inherits Nave {
	var property carga = 0

	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	override method recibirAmenaza() {
		carga = 0
	}
}

class NaveDeCargaRadiactiva inherits NaveDeCarga {
	var property estaSellada = false

	override method recibirAmenaza(){
		velocidad = 0
	}

	override method prepararseParaViajar(){
		super()
		self.cerrarAlVacio()
	}

	method cerrarAlVacio(){
		estaSellada = true
	}
}

class NaveDePasajeros inherits Nave {
	var property alarma = false

	const cantidadDePasajeros = 0

	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaLegal() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaLegal() or alarma

	override method recibirAmenaza() {
		alarma = true
	}
}

class NaveDeCombate inherits Nave{
	var property modo = reposo
	const property mensajesEmitidos = []

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible()

	override method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}

	override method prepararseParaViajar(){
		super()
		modo.prepararseParaViajar(self)
	}

	method cambiarModo(_modo){
		modo = _modo
	}
}

object reposo {

	method invisible() = false

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}

	method prepararseParaViajar(nave){
		nave.emitirMensaje("Saliendo en misión")
		nave.cambiarModo(ataque)
	}
}

object ataque {

	method invisible() = true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}

	method prepararseParaViajar(nave){
		nave.emitirMensaje("Volviendo a la base")
	}
}
