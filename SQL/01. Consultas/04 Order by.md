# ORDER BY

Esta sentencia permite prentar los resultados de una consulta en función de alguna de las columnas de la tabla, su sentencia basica es: 

```SQL
SELECT colums FROM "nameTab" ORDER BY "Column1";
```
En este ejemplo la Column1 es una de las columnas pertenecientes a nameTab, cabe aclarar que no hace falta que la columna que se usa como criterio pertenezca al conjunto de columnas que se declaran depues del SELECT. 

El motivo por los cuales se recomienda el uso de esta sentencia, es porque al usar funciones de edición de la tabla que se veran más adelante (ver apartado de Edición) esto ocacionara que la tabla se presente desorganizada como ocurre acontinuación:

![alt text](imagenes/SELECT_03.png)

En este caso se puede observar que en la columna ID usuario los valores de los ID se encuntran desorganizados, para evitar esto a la hora de realizar una consulta se puede escribir el query de la siguiente manera: 

![alt text](imagenes/ORDER%20BY_01.png)

En este caso se puede observar que cada uno de los reultados de las consultas estan ordenados segun el ID de cada usuario, ahora cabe señalar que la sentencia ORDER BY puede variar el modo de ordenamiento.

La manera en la que se puede definir el ordenamiento de manera descendente es la siguiente:

```SQL
SELECT colums FROM "nameTab" ORDER BY "Column1" DESC;
```
Ejemplo practico:

![alt text](imagenes/ORDER%20BY_02.png)

y de manera Ascendente, (aunque por default se ordena de esta manera, como se oberva en la segunda imagen):

```SQL
SELECT colums FROM "nameTab" ORDER BY "Column1" ASC;
```

Por ultimo cabe mensionar que no es necesario que la columna que se usa en el ORDER BY no debe ser obligatoriamente numerica, tambien puede ser de tipo texto, siendo que en ese caso se ordenaria de manera alfabetica ya sea ASC o DESC, como el siguiente ejemplo: 

![alt text](imagenes/ORDER%20BY_03.png)