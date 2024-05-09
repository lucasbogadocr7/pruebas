--gith
esMulDe :: Integral a => a -> a -> Bool
esMulDe num1 num2 = num1 `mod` num2 == 0

--9
promedios :: Fractional a =>[[a]] -> [a]
promedios listagorda = map promedio listagorda

promedio :: Fractional a => [a] -> a
promedio lista = (sum lista) / fromIntegral (length lista)

doblesLista :: Num a => [a] -> [a]
doblesLista lista = map (\numero -> numero * 2) lista

