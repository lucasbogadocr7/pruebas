class Personaje {
    var globos = 60

    method comprarGlobos(cantidad) {
        globos += cantidad
    }

    method globos() = globos
}



object manic inherits Personaje{
    var estrellas = 0

    method encontrarEstrellas() {
      estrellas += 8     // estrellas = estrellas + 8
    }  

    method regalarEstrellas() {
      estrellas = 0.max(estrellas-1)   // para que no queden estrellas negativas
    }

    method estrellas() = estrellas

    method tieneTodoListo() = estrellas >= 4
}

object fiesta {
    var organizador = chuy
    
    method estaPreparada() = organizador.tieneSuficientesGlobos(50) && organizador.tieneTodoListo()
  
}

object chuy inherits Personaje {
    var estrellas = 6

    method tieneTodoListo() = estrellas >= 4

    method tieneSuficientesGlobos(cantidad) = globos > cantidad
  
}

object capy inherits Personaje {
    var estrellas = 0
    var latas = 60

    method recolectar() {
        latas += 1
    }

    method reciclar() {
        latas = 0.max(latas-1)
    }

    method latas() = latas

    method cantidadPar() = latas.even()

    method tieneTodoListo() = cantidadPar()

}
