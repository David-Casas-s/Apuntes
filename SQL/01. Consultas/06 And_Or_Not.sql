--Sintaxis basica: 
SELECT "columna1" FROM "nameTab" WHERE NOT "column" = 'valor';
--La clusula NOT se usa para negar una condicion en una consulta SQL.

--la senticia NOT puede compañarse junto con la CLAUSULA LIKE, AND y OR para crear condiciones mas complejas.

--Ejemplos:

--Uso de NOT con una condicion simple: 


--Uso de NOT junto con la CLAUSULA LIKE: 
SELECT * FROM "Usuarios" WHERE NOT "Email" LIKE  '%gmail%';

--Uso de NOT junto con la CLAUSULA AND:
SELECT * FROM "Usuarios" WHERE NOT "Email" LIKE  '%gmail%' AND "Edad" >=21;

--Uso de NOT junto con la CLAUSULA OR:
SELECT * FROM "Usuarios" WHERE NOT "Email" LIKE  '%gmail%' OR "Edad" >=21;