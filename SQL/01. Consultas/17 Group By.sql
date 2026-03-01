--Sintaxis basica:
SELECT column1, COUNT(column2) FROM nameTab GROUP BY column1;

--Esta funcion se utiliza para agrupar filas que tienen los mismos valores en columnas especificas en una consulta SQL.
--Las columnas referenciadas despues del select que no estan dentro de una funcion de agregacion (como COUNT, SUM, AVG, etc.) deben estar incluidas en la clausula GROUP BY.

--Ejemplos: 
SELECT "Nombre" FROM "Usuarios" GROUP BY "Nombre";
/*La Consulata anterior agrupara a todos los registro en donde los nombres sean iguales
Si hay doos nombres iguales se agruparan en una sola fila del resultado
si se quiere saber cuantos registros hay de cada nombre, se peude hacer la siguiente consulta:*/
SELECT "Nombre", COUNT("Nombre") FROM "Usuarios" GROUP BY "Nombre";

--Otro ejemplo puede darse con la siguiente consulta:
SELECT MAX("Edad") AS "EDADES MAXIMAS" FROM "Usuarios" GROUP BY "Edad" ORDER BY "EDADES MAXIMAS";
--Esa consulta agrupra todas la edades Maximas una por una, haciendo que asi se muestren todas las existentes sin contar repeticiones.
