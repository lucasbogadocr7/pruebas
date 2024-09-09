//EJERCICIO TOM Y JERRY



object jerry {
  var peso = 3
  var property posicion = 10

  method peso() = peso

  method velocidad() = 10 - self.peso()
}
object tom {
  var energia = 80
  var property posicion = 0

  method energia() = energia 
  
  method velocidad() = 5 + self.energia().div(10)

  method distanciaCon(alguien) = 0.max(self.posicion() - alguien.posicion())

  method correA(raton) {
    energia -= (self.velocidad()*self.distanciaCon(raton))/2    //divido por dos en vez de multiplicar por 0.5
    posicion = jerry.posicion()
  }

  method esMasVeloz(raton) = self.velocidad() > raton.velocidad()

}

object robotRaton {
    var property posicion = 12
    method velocidad() = 10
  
}

//probado y funciona en la consola