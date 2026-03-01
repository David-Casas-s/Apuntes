--Sintaxis basica:
SELECT column1, IFNULL(column2, default_value) AS alias_name ;

--Esta funcion permitira identificar los valores nulos en la column2 y si es nulo, retornara el valor por defecto (default_value) en su lugar.
--Debido a que esta cambia el nombre de la columna, se utiliza el alias (alias_name) para referenciarla posteriormente.

--ESTE CASO SOLO FUNCIONA EN MYSQL

--Para postgreSQL se utiliza la funcion COALESCE
--Sintaxis basica: 
SELECT column1, COALESCE(column2, default_value) AS alias_name FROM nameTab;