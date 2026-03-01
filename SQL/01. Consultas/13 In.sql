--Sintaxis Basica:
SELECT * FROM nameTab WHERE column1 IN (value1, value2, ...);

--La clusula IN se utiliza para filtrar los registros que coinciden con cualquiera de los valores especificados en una lista.
--Esto es especialmente util cuando se desea comparar una columna con multiples valores sin tener que utilizar multiples condiciones OR.
--Seria similar a hacer: 
SELECT * FROM nameTab WHERE column1 = value1 OR column1 = value2 OR ...;