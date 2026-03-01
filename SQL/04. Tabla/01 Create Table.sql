--Sintaxis Basica:
CREATE TABLE nombre_tabla (
    nombre_columna1 tipo_dato restricciones,
    nombre_columna2 tipo_dato restricciones,
    ...
    nombre_columnaN tipo_dato restricciones
);

--con este comanda se crea una tabla, en la cual se especifican el nombre de sus columnas, el tipo de dato que almacenaran y las restricciones que tendran dichas columnas. 

--acontinuacion se hablara de las restricciones que puedne tener las columnas de una tabla:

-- para especificar cualquier restriccion en una columna, se debe escribir despues del tipo de dato de la columna de la siguiente manera:

nombre_columna tipo_dato RESTRICCION1 RESTRICCION2 ... RESTRICCIONN

--Las restricciones mas comunes son:

--1. NOT NULL: Esta restriccion indica que la columna no puede tener valores nulos.
--Ejemplo:
CREATE TABLE empleados (
    id INT NOT NULL,
);

--sirve para que sea oblegatorio ingresar un valor en la columna con la restrccion no pues estar vacia
--en este caso, el campo id no puede quedar vacio al momento de insertar un nuevo registro en la tabla empleados.

--2. UNIQUE: Esta restriccion asegura que todos los valores en la columna sean unicos.
--Ejemplo:
CREATE TABLE empleados (
    email VARCHAR(100) UNIQUE,
);
--este garantiza que el campo que posee la restriccion no puede estar repetido en ningun registro de la tabla.
--en este caso no habria empleados con el mismo correo electronico. 

--3. PRIMARY KEY: Esta restriccion identifica de manera unica cada fila en la tabla.
--Ejemplo:
CREATE TABLE empleados (
    id SERIAL,
    PRIMARY KEY (id)
);
--La llave primaria exige y garantiza que el campo sea unico y no pueda ser nulo
--en este caso, el campo id es la llave primaria de la tabla empleados.
--además de servir como identificador unico de cada registro, tambien ayuda a establecer relaciones entre tablas en una base de datos relacional.

--4. Check: Esta restriccion asegura que los valores en la columna cumplan con una condicion especifica.
--Ejemplo: 
CREATE TABLE "Personas3"(
"Edad" int,
CHECK("Edad"<18)
);
--esta restriccion valida que los valores ingresados en la columna Edad sean menores a 18.

--5. DEFAULT: Esta restriccion establece un valor predeterminado para la columna si no se proporciona ningun valor al insertar un nuevo registro.
--Ejemplo: 
CREATE TABLE "Personas4"(
"Edad" int DEFAULT 18
)
--en este caso, si no se especifica un valor para la columna Edad al insertar un nuevo registro, se asignara automaticamente el valor 18.
--esto es util para asegurar que una columna tenga un valor predeterminado en caso de que no se proporcione uno.

--5. AUTO INCREMENT: Esta restriccion se utiliza para columnas numericas que deben incrementarse automaticamente con cada nuevo registro insertado.
--este no se vera a fondo porque para eso se utiliza el tipo de dato SERIAL en postgresql.