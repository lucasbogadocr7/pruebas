import Text.Show.Functions()

--PADRINOS MAGICOS

data Chico = UnChico {
    nombre :: String,
    edad :: Float,
    habilidades :: [Habilidad],
    deseos :: [Deseo]
} deriving (Show)

type Habilidad = String
type Deseo = Chico -> Chico

--CONCEDIENDO DESEOS 

modificarHab :: ([Habilidad]->[Habilidad]) -> Chico -> Chico
modificarHab f boy = boy {habilidades = f.habilidades $ boy}

aprenderHab :: [Habilidad] -> Deseo
aprenderHab listaNueva boy = modificarHab (++ listaNueva) boy

serGrosoEnNFS :: Deseo
serGrosoEnNFS boy = modificarHab (++ listaNFS) boy

listaNFS :: [Habilidad]
listaNFS = map (\unNum -> "Need For Speed" ++ show unNum) [1..]

serMayor :: Deseo
serMayor boy = boy {edad = (const 18).edad $ boy}

type Padrino = Chico -> Chico

modificarEdad :: (Float -> Float) -> Chico -> Chico
modificarEdad f boy = boy {edad = f.edad $ boy}

modificarDeseo :: ([Deseo] -> [Deseo])->Chico -> Chico
modificarDeseo f boy = boy {deseos = f.deseos $ boy}

cumplirDeseo :: Chico -> Chico
cumplirDeseo boy = foldr (\deseo chico -> deseo chico) boy (deseos boy)

wanda :: Padrino
wanda boy = cumplirDeseo.(modificarDeseo (take 1)).(modificarEdad (+1)) $ boy

cosmo :: Padrino
cosmo boy = cumplirDeseo.(modificarDeseo (\lista -> [])).(modificarEdad (/2)) $ boy

muffin :: Padrino
muffin boy = cumplirDeseo boy

--BUSQUEDA DE PAREJA
--condiciones
tieneHabilidad :: Habilidad -> Condicion
tieneHabilidad hab chico = (elem hab).habilidades $ chico

esSuperMaduro :: Condicion
esSuperMaduro chico = (mayor chico) && (tieneHabilidad "manejar" chico)

mayor :: Condicion
mayor chico = (>18).edad $ chico

data Chica = UnaChica {
    nombree :: String,
    condicion :: Condicion
} deriving (Show)
type Condicion = Chico -> Bool


quienConquista :: Chica -> [Chico] -> Chico
quienConquista chica [x] = x
quienConquista chica (x:xs) 
    | (condicion chica) x = x
    | otherwise = quienConquista chica xs



--    

-- Lista de chicos
juan :: Chico
juan = UnChico {
    nombre = "Juan",
    edad = 17,
    habilidades = ["cocinar", "manejar", "enamorar"],
    deseos = [serGrosoEnNFS, serMayor]
}

pedro :: Chico
pedro = UnChico {
    nombre = "Pedro",
    edad = 22,
    habilidades = ["programar", "tocar la guitarra"],
    deseos = [serGrosoEnNFS, serMayor]
}

luis :: Chico
luis = UnChico {
    nombre = "Luis",
    edad = 19,
    habilidades = ["diseñar", "pintar"],
    deseos = [serGrosoEnNFS, serMayor]
}

carlos :: Chico
carlos = UnChico {
    nombre = "Carlos",
    edad = 21,
    habilidades = ["fotografía", "escalar", "matar"],
    deseos = [serGrosoEnNFS, serMayor]
}

-- Lista de chicos
chicos :: [Chico]
chicos = [juan, pedro, luis, carlos]

infractores :: [Chico] -> [String]
infractores lista = map (deseoProhibido) lista

deseoProhibido :: Chico -> String
deseoProhibido chico 
    | any (esProhibida) (habilidades.cumplirDeseo $ chico) = nombre chico
    | otherwise = ""

esProhibida :: Habilidad -> Bool
esProhibida "enamorar" = True
esProhibida "matar" = True
esProhibida "dominar el mundo" = True
esProhibida _ = False





