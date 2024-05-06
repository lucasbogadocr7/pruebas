import Text.Show.Functions()

--EJERCICIO MONOPOLY

data Participante = UnParticipante {nombre :: String, dinero :: Int , tactica :: String , propiedades :: [Prop] , acciones :: [Acc]} deriving Show
data Prop = UnaPropiedad {nombreprop :: String, precioprop :: Int} deriving Show
type Acc = Participante -> Participante

--FUNCIONES AUX

nombreProp :: Prop -> String
nombreProp (UnaPropiedad nom _) = nom

precioProp :: Prop -> Int
precioProp (UnaPropiedad _ pr) = pr

--modificarDinero :: (Int -> Int) -> Participante -> Participante
--modificarDinero fun jugador = jugador {dinero = fun.dinero $ jugador}

modificarDinero :: (Int -> Int) -> Int -> Int
modificarDinero fun monto = fun monto

--modificarTac :: (String -> String) -> Participante -> Participante
--modificarTac fun jugador = jugador {tactica = fun.tactica $ jugador}

--modificarTac :: (String -> String) -> String -> String
--modificarTac fun tactic = fun tactic

--agregarAccion :: Acc -> Participante -> Participante
--agregarAccion accion jugador = jugador {acciones = (accion :).acciones $ jugador}

agregarAccion :: Acc -> [Acc] -> [Acc]
agregarAccion accion lista = accion : lista

--PERSONAS

carolina :: Participante
carolina = UnParticipante "Carolina" 500 "Accionista" [] [pasarPorElBlanco, pagarAccionistas "Accionista"]


manuel :: Participante
manuel = UnParticipante "Manuel" 500 "Oferente Singular" [] [pasarPorElBlanco, enojarse] 

--ACCIONES

pasarPorElBlanco :: Acc
pasarPorElBlanco jugador = jugador {dinero = modificarDinero (+40).dinero $ jugador, tactica = "CompradorCompulsivo"}

enojarse :: Acc
enojarse jugador = jugador {dinero = modificarDinero (+50).dinero $ jugador, acciones = agregarAccion gritar (acciones jugador) }

gritar :: Acc
gritar jugador = jugador {nombre = (++ "AHHHH").nombre $ jugador}

--usamos pattern-matching
subastar :: String -> Prop -> Acc
subastar "Accionista" propiedad jugador = ganarPropiedad propiedad jugador
subastar "Oferente Singular" propiedad jugador = ganarPropiedad propiedad jugador
subastar _ _ jugador = jugador 

--podemos aplicar parcialemente propiedad

ganarPropiedad :: Prop -> Participante -> Participante
ganarPropiedad propiedad jugador = jugador {dinero = modificarDinero (subtract (precioProp propiedad)).dinero $ jugador, propiedades = agregarPropiedad propiedad (propiedades jugador)}

agregarPropiedad :: Prop -> [Prop] -> [Prop]
agregarPropiedad propiedad lista = propiedad : lista

--si suponemos que se cobra un alquiler por cada turno (en caso de que un jugador caiga)
cobrarAlqui :: Prop -> Acc
cobrarAlqui propiedad jugador
    | esPropiedadBarata propiedad = jugador {dinero = modificarDinero (+10).dinero $ jugador}
    | not(esPropiedadBarata propiedad) = jugador {dinero = modificarDinero (+20).dinero $ jugador}
    | otherwise = jugador

esPropiedadBarata :: Prop -> Bool
esPropiedadBarata propiedad = precioProp propiedad < 150

pagarAccionistas :: String -> Acc
pagarAccionistas "Accionista" jugador = jugador {dinero = modificarDinero (+200).dinero $ jugador} 
pagarAccionistas _ jugador = jugador {dinero = (subtract 100).dinero $ jugador}
