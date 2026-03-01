--Este comando permite editar la estructura de una tabla existente en una base de datos.

--Sintaxis básica:
ALTER TABLE nombre_de_la_tabla acción;

--Ejemplos:
--Para los siguientes ejemplos, supongamos que tenemos la siguiente tabla: 

CREATE TABLE "Personas3"(
    "ID" SERIAL,
    "Name" text NOT NULL,
    "email" text,
    "age" int,
    PRIMARY KEY("ID"),
    CHECK("age"<=18)
)
--1. ADD: Agregar una nueva columna a la tabla.
ALTER TABLE "Personas3"
ADD "surname" text;

--2.RENAME COLUMN: Cambiar el nombre de una columna existente.
ALTER TABLE "Personas3"
RENAME COLUMN "email" TO "email_address";

--3. MODIFY: Cambiar el tipo de datos de una columna existente.
ALTER TABLE "Personas3"
MODIFY COLUMN "age" float;
--NOTA: Esta es la version par mySQL . En PostgreSQL se utiliza ALTER COLUMN seguido de TYPE

--Version PostgreSQL:
ALTER TABLE "Personas3"
ALTER COLUMN "age" TYPE float;

--4. DROP COLUMN: Eliminar una columna existente de la tabla.
ALTER TABLE "Personas3"
DROP COLUMN "surname";