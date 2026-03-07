# Relacion entre SELECT logico y ejecución fisica:

**Select Logico:** El select logico se puede describir como la menera habitual en la cual se suele escribir una sentencia de SQL, por ejemlo la sentencia: 
```SQL
SELECT * FROM USUARIOS;
```
este principio del select logico aplica para cada una de las sentencias que se realizan en SQL, esto permite que el usuaio puede intereactuar con la base de datos sin la necesidad de entender que esta pasando internamente con los datos, es decir si se tiene por ejemplo: 
```SQL
SELECT "nombre" FROM USUARIOS WHERE "EDAD" > 18;
```
El usurio no es conciente de como el optimizador de consultas realiza la busqueda en la base de datos y no tiene la necesidad de saber que algoritmos esta usando el optimizador. 

**Ejecución fisica:** Este es el apartado de la base de datos de la cual no se entera el usuario a la hora de hacer una consulta mediante el uso de SGDB, esta parte se enccarga de implementar los algortimos correspondientes para que las distintas sentecias se cumplan, ya sean desde una simple busqueda hasta la eliminación de algo dentro de la base de datos, para ello el optimizador de conssultas utiliza distintas herramientas como lo pueden ser: el uso de indices en b-trees, joins, etc. 

La manera en la que funcionan los b-trees junto con los indices se asemeja la manera en la que se realiza una buqueda en un arbol binario, siendo esta estructura en donde los nuemeros se orenan de mayor a menor de izquierda a derecha. Al igual que como ocurre con los arboles la manera que tiene el optimizador para realizar una consulta es revisar nodo por nodo usando la comparación de si el nuemro que se busca es mayor o menor a alguno de los hijos del nodo en el que esta y repitiendo este proceso hasta llegar al nodo solicitado que es el nodo con el indice de la busqueda.

Un ejemplo de como puede verse afectado el optimizador con respecto a la busqueda puede ser el sigueinte; se hace la siguiente consulta: 

```SQL
SELECT * FROM "EMPLEADOS" WHERE "ID" = 100000;
```

Si el indice no existe el optimizador igualmente tendra que recorrer o no toda la tabla para poder llegar a la posición 100000, en cambio si se hace lo siguiente: 

```SQL
CREATE INDEX indx_id ON "EMPLEADO"("ID");
```

para este caso se crea un arbol interno accesible para el optimizador de menara que pueda realizar los saltos necesarios para alcanzar el valor buscado, reduciendo muchos los costos computacionales y temporales.

# Orden logico:

Se define como orden logico el debido proceso que realiza un SGBD a la hora de recibir una sentencia, para ello se tiene una lista de prioridades para cada uno de los elementos de la sentencia los cuales son los siguientes: 

**1.FROM:** Esta sentencia permite identificar que tabla de la base de datos se va a tocar, es la más escencial pues determina como se haran los JOINS para tocar los datos adecuados. 

**2.WHERE:** Esta sentencia actua como filtro con el fin de excluir las filas que no cumplan con la condición planteada haciando asi más aficienete los procesos internos que puedan acarrear las demás sentenacias.

**3.GROUP BY:** Esta sentencia agrupa las filas que ya han pasado el filtro en grupos. 

**4.HAVING:** Esta sentencia es muy similar a WHERE solo que esta trabaja con grupos enteros (conjuntos de filas), miesntras que con WHERE se trabajan con las filas de una sola tabla.

**5.SELECT:** Como su nombre lo indica esta sentencia permite seleccionar las filas posteriormente filtradas o agrupadas; con el fin de realizar el calculo de funciones de agregado. 

**6.ORDER BY:** Esta sentencia lo que hace es organizar segun un critero establecido las filas que fueron posteriormente filtradas y seleccionadas. 

**7.LIMT:** Esta sentencia hace que no se muestres todas las filas que puedan cumplir con el SELECT propuesto.

Con el siguiente ejemplo se intentara mostar porque es importante saber reconocer la gerarquie entre las sentencias: 

```SQL
SELECT "Precio" * 0.15 AS "IMPUESTOS"
FROM "PRODUCTOS"
WHERE "Impuestos" > 100;
```

La sentencia anterior dara error, puesto que la "Columna" impuestos a la cual hace referencai el WHERE no existe aun cuando el WHERE se ejecuta a nivel interno, ya que esta se define despues al sefun una función de gragado del SELECT. La manera correcta de ejecutar la sentencia seria: 

```SQL
SELECT "Precio" * 0.15 AS "IMPUESTOS"
FROM "PRODUCTOS"
WHERE ("Precio"*0.15) > 100;

Prueba de edicion desde gtihub
```
