--Sintaxis basica
SELECT "columna1" FROM "nameTab" LIMIT numero_filas;
--La clusula LIMIT se usa para especificar el numero maximo de filas que se mostrara en el resultado de una consulta SQL.

--Ejemplos:
SELECT * FROM "Usuarios" LIMIT 3;

--Al igual que con las sentencias anteriros, LIMIT puede combinarse con otras clausulas como WHERE, ORDER BY, etc.

--Ejemplos: 

--Usi de LIMIT junto con WHERE:
SELECT * FROM "Usuarios" WHERE "Edad" >= 18 LIMIT 5;