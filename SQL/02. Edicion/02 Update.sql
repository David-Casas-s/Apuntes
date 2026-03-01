--Sintaxis basica:
UPDATE nameTab SET column1 = value1 WHERE condition;

--Este scrip permite actualizar o modificar datos existentes en una tabla especifica de una base de datos.
--En otras palabras permite cambiar el valor de una o varias columnas en una o varias filas que cumplan con una condicion especifica.

--NOTA IMPORTANTE: Si no se especifica una condicion (WHERE), todos los registros en la columna señalada seran actualizados con el nuevo valor.
--Despues dehacer un UPDATE es recomendable hacer un SELECT para verificar que los cambios se hayan realizado correctamente.
--Es posible que al hacer el select se muestre la cosulta de manera desordenada, para evitar esto se puede usar la clausula ORDER BY.


--Ejemplo:
UPDATE "Usuarios" SET "Email" = 'david@gmail.com' WHERE "Email" LIKE '%davidfcasass22%';
SELECT * FROM "Usuarios" ORDER BY "ID usuario";