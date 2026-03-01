--Sintaxis Basica 
SELECT column1 FROM nameTab WHERE column IS NULL;

--La clusula IS NULL se usa para filtrar los registros que tienen valores nulos en una columna especifica.
--Esto se podria evistar con a la hora de crear la tabla utilizando la restriccion NOT NULL.

--Tambien existe la sentencia para los valores no nulos:
--Sintaxis Basica: 
SELECT column1 FROM nameTab WHERE column IS NOT NULL;

--Este como su nombre la indica mostrara todos los registros en donde la columna especificada tenga valores no nulos.