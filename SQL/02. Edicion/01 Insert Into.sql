--Sintaxis basica:
INSERT INTO nameTab(column1, column2) VALUES(value1, value2);

--Este cimando o script permite insertar datos en una tabla especifica de una base de datos.
--En otras palabras permite crear una nueva fila o registro en la tabla.

--Nota para los datos de tipo serial o autoincrementables no es necesario especificar un valor, ya que la base de datos se encargara de asignar el siguiente valor disponible automaticamente.
--Nota 2: Para las columnas de tipo texto y fes cha, los valores deben ir entre comillas simples (' ').

--Ejemplo: 
INSERT INTO "Usuarios"("Nombre", "Apellido", "Edad", "Email")
VALUES ('Fernand', 'Casas', 20, 'fc@gmail.com');