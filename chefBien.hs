import Text.Show.Functions()
--PARCIAL HASKELL CHEFFF (who let me cook)

--PARTE A
data Persona = UnaPersona {
    nombre :: String,
    trucos :: [Truco],
    especial :: Plato
} deriving (Show)

data Plato = UnPlato {
    dificultad :: Float,
    ingr :: [Ingrediente]
} deriving (Show)

type Ingrediente = (Float, String)
type Truco = Plato -> Plato 

modificarIng :: ([Ingrediente] -> [Ingrediente]) -> Plato -> Plato
modificarIng f plat = plat {ingr = f.ingr $ plat}

modificarDifi :: (Float -> Float) -> Plato -> Plato
modificarDifi f plat = plat {dificultad = f.dificultad $ plat}

endulzar :: Ingrediente -> Truco
endulzar azucar plato = modificarIng (azucar:) plato

salar :: Ingrediente -> Truco
salar sal plato = modificarIng (sal:) plato

darSabor :: Ingrediente -> Ingrediente -> Truco
darSabor azucar sal plato = (endulzar azucar).(salar sal)$plato

duplicarPorcion :: Truco
duplicarPorcion plato = modificarIng (map ((\(e1, e2) -> (2*e1, e2)))) plato

simplificar :: Truco
simplificar plato 
    | platoBardo plato = (modificarDifi (const 5.0)).modificarIng (filter (\tupla -> (>=10).fst $ tupla))$plato
    | otherwise = plato


platoBardo :: Plato -> Bool
platoBardo plato = ((>5).length.ingr $ plato)  && ((>7).dificultad $ plato)


type Carac = Plato -> Bool

--repito logica en si tiene o no ingredientes

tieneIngrediente :: (Ingrediente -> Bool) ->Plato -> Bool
tieneIngrediente f plato = any((\tupla -> f tupla)).ingr $ plato 

esVeganoo :: Carac
esVeganoo plato = not((any (\tupla -> elem (snd tupla) listaNoVegana)).ingr $ plato)

esVeganoBien :: Carac
esVeganoBien plato = not (tieneIngrediente (\tupla -> elem (snd tupla) listaNoVegana) plato )

listaNoVegana :: [String]
listaNoVegana = ["huevos", "carne", "leche", "queso", "manteca", "crema"]

esSinTacc :: Carac
esSinTacc plato = not((any (\tupla -> (snd tupla) == "harina")).ingr $ plato)

esSinTaccBien :: Carac
esSinTaccBien plato = not(tieneIngrediente (\tupla -> (snd tupla) == "harina") plato)

esComplejo :: Carac
esComplejo plato = platoBardo plato

noAptoHip :: Carac
noAptoHip plato = not ((any (\tupla -> (fst tupla) >2 && (snd tupla) == "sal")).ingr $ plato)

noAptoHipBien :: Carac
noAptoHipBien plato = not(tieneIngrediente (\tupla -> (fst tupla) >2 && (snd tupla) == "sal") plato)

--PARTE B

pepe :: Persona
pepe = UnaPersona "pepito" [(darSabor (5, "azucar")(2, "sal")), simplificar, duplicarPorcion] platoPepe

platoPepe :: Plato
platoPepe = undefined

--PARTE C

cocinar :: Persona -> Persona
cocinar tipo = tipo {especial = foldr(\truko plato -> truko plato) (especial tipo) (trucos tipo)}  

esMejorQue :: Plato -> Plato -> Bool
esMejorQue p1 p2 = (dificultadEntreDos p1 p2) && (sumaDePesosEntreDos p1 p2)

dificultadEntreDos :: Plato -> Plato -> Bool
dificultadEntreDos p1 p2 = (>dificultad p2).dificultad $ p1

sumaDePesosEntreDos :: Plato -> Plato -> Bool
sumaDePesosEntreDos p1 p2 = sumaPesoo p1 < sumaPesoo p2 

--suma de peso simple
sumaPeso :: Plato -> Float
sumaPeso plato = sum ((map fst).ingr $ plato)

--suma de peso con foldr
sumaPesoo :: Plato -> Float
sumaPesoo plato = foldr (+) (fst.head.ingr $ plato) (map fst (ingr plato))

participanteEstrella :: [Persona] -> Persona
participanteEstrella lista = foldr tieneMejorPlato (head lista) (lista)

tieneMejorPlato :: Persona -> Persona -> Persona
tieneMejorPlato p1 p2
    | esMejorQue (especial.cocinar $ p1)(especial.cocinar $ p2) = p1
    | otherwise = p2

--PERSONAS

-- Josep
jose :: Persona
jose = UnaPersona {
    nombre = "Josep",
    trucos = [darSabor (5, "azúcar") (2, "sal"), simplificar, duplicarPorcion],
    especial = platoEspecialJose
}

platoEspecialJose :: Plato
platoEspecialJose = UnPlato {
    dificultad = 8.0,
    ingr = [(100, "harina"), (200, "azúcar"), (50, "leche"), (30, "huevos"), (20, "manteca"), (10, "sal"), (15, "levadura")]
}

-- Ana García
ana :: Persona
ana = UnaPersona {
    nombre = "Ana García",
    trucos = [salar (3, "sal"), endulzar (10, "miel")],
    especial = platoEspecialAna
}

platoEspecialAna :: Plato
platoEspecialAna = UnPlato {
    dificultad = 6.0,
    ingr = [(200, "arroz"), (100, "pollo"), (50, "pimiento"), (30, "tomate"), (10, "aceite")]
}

-- Juan Pérez
juan :: Persona
juan = UnaPersona {
    nombre = "Juan Pérez",
    trucos = [duplicarPorcion, simplificar],
    especial = platoEspecialJuan
}

platoEspecialJuan :: Plato
platoEspecialJuan = UnPlato {
    dificultad = 9.0,
    ingr = [(150, "pasta"), (75, "queso"), (50, "jamón"), (25, "aceitunas"), (20, "aceite"), (15, "sal")]
}


--PARTE D

platinum :: Plato
platinum = UnPlato 10 listaMisteriosa

listaMisteriosa :: [Ingrediente]
listaMisteriosa = map (\unNum -> (unNum, "ingr" ++ show unNum)) [1..]

