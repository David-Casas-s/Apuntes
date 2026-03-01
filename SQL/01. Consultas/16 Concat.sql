--Sintaxis basica:
SELECT CONCAT(column1, column2, ...) FROM nameTab;

-- Sirve para concatenar columnas a la hora de mostrar el reusltado de una consulta SQL.
--Es simimlar a la funcion unir celdas de Excel, solo que aqui se muestra el resultado en una consulta SQL.

--Para la expresar espacios entre los valores concatenados, se puede utilizar la funcion CONCAT con espacios en blanco como:
SELECT CONCAT(column1, ' ', column2, ' ', column3) FROM nameTab;

--NOTA IMPORTANTE: La funcion CONCAT no presenta un nombre de columna en el resultado de la consulta.
--Para asignar un nombre a la columna resultado de la concatenacion, se puede utilizar la funcion ALIAS como:
SELECT CONCAT(column1, ' ', column2) AS 'Alias' FROM nameTab