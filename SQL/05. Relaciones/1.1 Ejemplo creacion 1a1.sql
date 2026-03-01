CREATE TABLE "Cedula de Ciudadania"(
    "Numero lista de Cedulas" SERIAL,
    PRIMARY KEY ("Numero lista de Cedulas"),
    "Numero de Cedual" INT NOT NULL UNIQUE,
    "Fecha de expedicion" DATE NOT NULL, 
    "Lugar de Expedicion" text NOT NULL,
    "ID usuario" int NOT NULL UNIQUE,
    FOREIGN KEY("ID usuario") REFERENCES "Usuarios"("ID usuario")
)

--En el ejemplo anterior se enidencia la creacion de una tabla llamada "Cedula de Ciudadania" que tiene una relacion uno a uno con la tabla "Usuarios" a traves del campo "ID usuario". 
--Cada cedula de ciudadania esta asociada a un unico usuario y viceversa.

--A la hora de crear una llave foranea, es necesario que se crea un columna que reciba a la clave primaria de la tabla a la que se esta haciendo referencia.
--En este caso, la columna "ID usuario" en la tabla "Cedula de Ciudadania" hace referencia a la columna "ID usuario" en la tabla "Usuarios".