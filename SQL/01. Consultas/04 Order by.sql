SELECT colums FROM "nameTab" ORDER BY "Column1";
--Esto permite orde los resultados de la consulta siiguiendo como criterio los valores en column1

--se puede especificar el orden del ordenamiento usado las clusaulas ASC (ascendente) o DESC (descendente).
-- Por defecto, el orden es ASC (ascendente) si no se especifica ninguna cláusula de ordenamiento.

--Ejemplos: 

--Ordenamiento descendente en base a las Edades de los usuarios
SELECT * FROM "Usuarios" ORDER BY "Edad" DESC;

--Nota: el ordenamiento es podrible con datos de tipo texto, numérico y de fecha.
--para datos de tipo texto, el ordenamiento se realiza en orden alfabético.

--Ejemplos con otras cláusulas:

--Ordenamiento con el uso de WHERE
SELECT * FROM "Usuarios" WHERE "Edad" >=19 ORDER BY "ID usuario" DESC; 

--Ordenamiento con el uso de DISTINCT
SELECT DISTINCT "Edad" FROM "Usuarios" ORDER BY "Edad" DESC;
--nota: en este caso, el uso de DISTINCT puede hacer que falle con el ordenamiento
--debido a que si el reultado de la busqueda solo considera los valores de la columna "Edad"
--no se podra ordenar por otra columna que no este en el resultado.