--Sintaxis basica:
SELECT SUM(column1) FROM nameTab HAVING condition;

--LA funcion having se usa para poner condiciones a los resultados agrupados por la clausula GROUP BY.
--No solo unicamente se puede usar con GROUP BY, sino que tambien con otras funciones como sum, count, avg, etc.
--La diferencia entre WHERE y HAVING es que WHERE filtra los registros antes de cualquier agrupacion, mientras que HAVING filtra los resultados despues de que se han agrupado.

--Ejemplo:
SELECT COUNT("Nombre") FROM "Usuarios" HAVING COUNT("Nombre")>5

--Esa buqueda solo mostra el reultado de buscar todos los nombres registrados en la tabla usuarios, pero solo si hay mas de 5 nombres registrados.