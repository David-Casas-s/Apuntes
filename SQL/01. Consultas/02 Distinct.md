# DISTINCT

Esta sentencia de SQL tiene como función mostrar resultados unicos de una columna a la hora de hacer una consulta, su sintaxisa general es la siguiente: 

```SQL
SELECT DISTINCT "Column1" FROM "nameTab";
````
En donde al momento de realizar la consulta se buscara que en la comulna 1 de laa tabla 1 no se presenten valores repedios, como ocurre en el siguiente ejemplo: 

![alt text](imagenes/SELECT_03.png)

En este caso se aprecia que para los registros 3 y 4 se repiten los apelledios a la hora de relazar la siguiente sentencia se observara que solo se mostrara un solo apellido

![alt text](imagenes/DISTINCT_01.png)
