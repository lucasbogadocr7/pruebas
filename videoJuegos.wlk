//VIDEOJUEGOS

object play {
    var bateria = "alta"
  method usar() {
  }
  method jugabilidad() = 10

}

object portatil {
  var bateria = "alta"

  method bateria() = bateria
  
  method usar() {
    bateria = "baja"
  }

  method jugabilidad() {
    if(bateria == "baja"){
        return 1
    } else { return 8}
  }
}
object delfina {
  var nivelDiversion = 0
  var consolaEnMano = play

  method consolaEnMano() = consolaEnMano

  method nivelDiversion() = nivelDiversion

  method agarrar(consola) {
    consolaEnMano = consola   //seria como un setter de consolaEnMano
  }

  method jugar(juego) {
    nivelDiversion += juego.diversion()
    consolaEnMano.usar()
  }
}

object arkanoid {
  method diversion() = 50
}

object mario {
    method consolaUsada() = delfina.consolaEnMano()

    method tienejugabilidadNecesaria(unaConsola) = unaConsola.jugabilidad() > 5

    method diversion() {
    if(self.tienejugabilidadNecesaria(self.consolaUsada())){
        return 100
    } else {return 15}
  }
}

object pokemon {
    method consolaUsada() = delfina.consolaEnMano()
    method diversion() = 10*((self.consolaUsada()).jugabilidad())

}