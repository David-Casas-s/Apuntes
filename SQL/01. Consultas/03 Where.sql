SELECT "Column1" FROM "nameTab" WHERE "someColumn" = "someValue";
--La cláusula WHERE se utiliza para filtrar los resultados de una consulta SQL según una condición específica.
--Donde someColumen puede ser cualquier columna de la tabla nameTab
-- por lo cual someValue puede ser cualquier tipo de dato, siempre y cunado coincida con el tipo de dato de someColumn
--Y se podria usar cualquier de los operadores de comparación como =, <>, >, <, >=, <= 

--EJemplos: 

--WHERE con el uso de DISTINCT
SELECT DISTINCT "Edad" FROM "Usuarios" WHERE "Edad" = 21;

--WHERE con otros operadores de comparación
SELECT DISTINCT * FROM "Usuarios" WHERE "Edad" >= 19;
