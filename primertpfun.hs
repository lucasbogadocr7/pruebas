import Text.Show.Functions()

data Ciudad = UnaCiudad {
    nombre :: String,
    anioDeFundacion :: Float,
    atraccionesPrincipales :: [Atraccion],
    costoDeVida :: Float
} deriving (Show, Eq)

type Atraccion = String

atracciones :: Ciudad -> [Atraccion]
atracciones (UnaCiudad _ _ lista _) = lista

--PUNTO 1: VALOR DE UNA CIUDAD

valorCiudad :: Ciudad -> Float
valorCiudad ciudad
    | (anioDeFundacion ciudad) < 1800 = ((*5).(subtract (anioDeFundacion ciudad))) 1800
    | null (atracciones ciudad) = (*2).costoDeVida $ ciudad 
    | otherwise = (*3).costoDeVida $ ciudad





--PUNTO 2: CARACTERÍSTICAS DE LAS CIUDADES

--AT.COPADAS

isVowel :: Char -> Bool
isVowel caracter = caracter `elem` "aeiouAEIOU"

tieneAtraccionCopada :: (Ciudad -> Bool)
tieneAtraccionCopada = (\ ciudad -> any isVowel (map head.atracciones $ ciudad))

--nuevaLista :: Ciudad -> [Char]
--nuevaLista ciudad = map head.atracciones $ ciudad --lista de primeros caracteres


--CIUDAD SOBRIA

ciudadSobria :: Ciudad -> Int -> Bool
ciudadSobria (UnaCiudad _ _ []_) _ = False
ciudadSobria (UnaCiudad _ _ lista _) x = all ((>x).length) lista


--CIUDAD CON NOMBRE RARO

ciudadRara :: Ciudad -> Bool
ciudadRara ciudad = (<5).length.nombre $ ciudad


--CIUDADES
baradero :: Ciudad
baradero = UnaCiudad "Baradero" 1615 ["Parque del este", "Museo Alejandro Barbich"] 150

nullish :: Ciudad
nullish = UnaCiudad "Nullish" 1800 [] 140

caleta :: Ciudad
caleta = UnaCiudad "Caleta Olivia" 1901 ["El Gorosito", "Faro Costanera"] 120



--PUNTO 3 VERSION BUENA (T)
modifVida :: (Float -> Float) -> Ciudad -> Ciudad
modifVida fun ciudad = ciudad {costoDeVida = fun.costoDeVida $ ciudad}

sumarAtraccion :: Atraccion -> Ciudad -> Ciudad
sumarAtraccion "Balneario GB" ciudad = (agregarAtraccion "Balneario GB").modifVida(aumentarCostoDeVida 20) $ ciudad

agregarAtraccion :: Atraccion -> Ciudad -> Ciudad
agregarAtraccion atr ciudad = ciudad {atraccionesPrincipales = (atr:).atraccionesPrincipales $ ciudad}

aumentarCostoDeVida :: Float -> Float -> Float
aumentarCostoDeVida porcentaje costo = costo * (1 + porcentaje / 100)

azul :: Ciudad
azul = UnaCiudad "Azul" 1832 ["teatro español", "Parque Sarmiento", "Costanera"] 190

crisis :: Ciudad -> Float -> Ciudad
crisis ciudad por = quitarAtraccion.modifVida (restarCostoDeVida por) $ ciudad

restarCostoDeVida :: Float -> Float -> Float
restarCostoDeVida porcentaje costo = costo * (1 - porcentaje / 100)

quitarAtraccion :: Ciudad -> Ciudad
quitarAtraccion ciudad = ciudad {atraccionesPrincipales = (drop 1).atraccionesPrincipales $ ciudad}

reevaluacion :: Int -> Ciudad -> Ciudad
reevaluacion n ciudad
    |ciudadSobria ciudad n = modifVida (aumentarCostoDeVida 10) ciudad 
    |otherwise = modifVida (restarCostoDeVida 3) ciudad


--PUNTO 3 (VERSION DESCARTADA)

--modificarVida :: (Float -> Float) -> Float -> Float
--modificarVida fun vida = fun vida

--sumarAtraccion :: Atraccion -> Float -> Ciudad -> Ciudad
--sumarAtraccion "Balneario Municipal GB" porcentaje ciudad = ciudad {costoDeVida = modificarVida (+(costoDeVida ciudad)).(porcentajeVida porcentaje) $ (costoDeVida ciudad),
--atraccionesPrincipales = "Balneario Municipal GB" : atraccionesPrincipales ciudad}

--porcentajeVida ::  Float -> Float -> Float
--porcentajeVida unPorc vida = (vida * unPorc) / 100

--(/100).(*vida)$unPorc

--crisis :: Ciudad -> Float -> Ciudad
--crisis ciudad porc = ciudad {costoDeVida = modificarVida (subtract (((porcentajeVida porc).costoDeVida)ciudad)).costoDeVida $ ciudad,
--atraccionesPrincipales = quitarAtraccion.atraccionesPrincipales $ ciudad}

--quitarAtraccion :: [Atraccion] -> [Atraccion]
--quitarAtraccion lista = drop 1 lista

--reevaluacion :: Int -> Ciudad -> Ciudad
--reevaluacion n ciudad
  --  |ciudadSobria ciudad n = ciudad {costoDeVida = modificarVida (+ (((porcentajeVida 10.0 ).costoDeVida)ciudad)).costoDeVida $ ciudad}
  --  |otherwise = ciudad {costoDeVida = modificarVida (subtract 3).costoDeVida $ ciudad}
