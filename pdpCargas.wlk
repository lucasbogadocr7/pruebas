//PDEP CARGAS

object verdurin {
  var cajones = 10
  const pesoCajon = 50
  var kilometraje = 700000

  method cajones(cantidad) {
    cajones = cantidad
  }

  method pesoCarga() = pesoCajon*cajones
  method velocidadMax() = 80 - self.pesoCarga().div(500)  //se llama al pesoCrga con self. y eso es un objeto que llama al mensaje div(500)

  method recorrer(km, vel) {
    kilometraje += km
  } 
}

object scannion {
  const capacidad = 5000
  var densidad = 1
  
  method densidad(unaDensidad) {
    densidad = unaDensidad
  }

  method pesoCarga() = densidad*capacidad

  method velocidadMax() = 140

  method recorrer(km, vel) {} // metodo vacío (cuando no se produce nada)

}

object ceralitas {
  var nivelDeterioro = 0
  var property pesoCarga = 0 // necesito que haya un setter para poder indicarle el peso segun los viajes que hizo

  method velocidadMax() {
    if(nivelDeterioro < 10){
        return 40
    } else {
        return 60 - nivelDeterioro
    }
  }
  method recorrer(km, vel) {
    nivelDeterioro -= (vel-45).max(0)
  } 

}

object empresa {
  var recaudacion = 0

  method cobrar(unaTarifa) {
    recaudacion += unaTarifa
  }
}       
object rutatlantica {
  method cobro(unCamion) = 7000 + unCamion.pesoCarga().div(1000)*100  // usamos polimorfismo con pesoCarga
  method velocidadQuePasa(unCamion) = (unCamion.velocidadMax()).min(75) // usamos polimorfismo con velocidadMax
  
  method camionQuePasa(unCamion) {
    unCamion.recorrer(400, self.velocidadQuePasa(unCamion))
    empresa.cobrar(self.cobro(unCamion))
  }
}

