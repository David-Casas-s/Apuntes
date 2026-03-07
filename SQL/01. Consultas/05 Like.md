# Sintaxis basica:

El operador LIKE se utiliza en una sentencia SQL para buscar un patron especifico en una columna de texto, esta se puede conparar con el metodo contains de java.

```SQL
SELECT column1 FROM nameTab WHERE someColumn LIKE 'pattern';
```
Esta tipo de sentencia se puede tomar como una adición al WHERE ya que se plantea una condición pattern el cual es un patron de texto en la columna declarada despues del WHERE.

Para esta sentencia exiten un caracter comodin el cual es el simbolo %, este caracterer especial se puede usar de 3 maneras distintas

**Caracter antes del patron:**
```SQL
SELECT * FROM "Usuarios" WHERE "Nombre" LIKE 'pattern%';
```

Este devuelve todos los registros donde se encuentre el patron antes del signo, es decir sin considerar lo que venga despues del patron.

![alt text](imagenes/LIKE_01.png)

**Caracter despues del patron:**

```SQL
SELECT * FROM "Usuarios" WHERE "Nombre" LIKE '%pattern';
```
Este devuelve todos los registros donde se encuentre el patron despues del signo, sin considerar lo que venga antes del patron.

![alt text](imagenes/LIKE_02.png)

**Caracter antes y despues del patron:**
SELECT * FROM "Usuarios" WHERE "Nombre" LIKE '%pattern%';
-- Este devuelve todos los registros lo que contenga el patron en cualquier posicion.

![alt text](imagenes/LIKE_03.png)