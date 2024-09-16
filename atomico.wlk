//TP SE DICE ATÓMICO


object ciudad {
  const suelo = 0.9
  const velocidadVientos = 10

  method suelo() = suelo
  method velocidadVientos() = velocidadVientos  
}
object burns {
    var varillasUranio = 0

  method varillasUranio(unasVarillas) {
    varillasUranio = unasVarillas
  }

  method varillasUranio() = varillasUranio

  method produccionEnergetica() = 0.1*varillasUranio //en millones de kwh

  method perjudicaAlMedioAmbiente() = varillasUranio > 20 //seria lo mismo que contaminación
}

object exBosque {
    
    var property toneladas = 0

    method toneladas(unasTons) {
      toneladas = unasTons
    }

    method toneladas() = toneladas

  method produccionEnergetica() = 0.5 + toneladas*ciudad.suelo()

  method perjudicaAlMedioAmbiente() = true
}


object turbina {

  method produccion() = 0.2*ciudad.velocidadVientos()
}
object elSuspiro {
  const turbinas = [turbina]

  method turbinas() = turbinas

  method agregarTurbina(nuevaTurbina) {
    turbinas.add(nuevaTurbina)
  }

  method produccionEnergetica() = self.produccionesDeTurbinas().sum()

  method produccionesDeTurbinas() = turbinas.map({unaTurbina => unaTurbina.produccion()})

  method contaminacion() = false 
}