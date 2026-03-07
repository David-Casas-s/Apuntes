# SELECT

Como su nombre lo señala esta sentencia lo que hace es seleccionar las disntintas filas pertenecientes a una tabla de una base de datos, la sintaxis general de esta sentencia es la siguiente: 

```SQL
SELECT Column1 FROM Tab1;
```
Lo que se esta declarando aqui es que el SGBD debe mostrar la columna 1 que esta en la tabla 1; esta sentencia tambien puede presentar sus variaciones, ya que se puede mostrar más de una fila a la vez de la siguiente manera: 

```SQL
SELECT Column1, Column2 From Tab1;
```
En la anterior sentencia se esta realizando la selección de dos comulnas al mismo tiempo, a la hora de que el SGBD muestre el resultado, este aparecera en el orden en cual las filas fueron declaradas a la hora de la creacion de la tabla.

Asi como se pueden mostrar vaias filas de un tabla sin tener un limite de filas para mostrar, los SGBD tambien permiten mostrar todas las filas al tiempo, esto mediante la implementacion de la siguiente sentencia: 

```SQL
SELECT * From Tab1;
```
En dondo el signo * representa a todas la filas en la tabla seleccionada. 