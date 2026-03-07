    --Sintaxis basica:
    SELECT column1 FROM nameTab WHERE someColumn LIKE pattern;

    --El operador LIKE se utiliza en una sentencia SQL para buscar un patron especifico en una columna de texto, esta se puede conparar con el metodo contains de java.

    --Para esta sentencia exiten un caracter comodin:
    --El simbolo %: representa cero, uno o varios caracteres.

    --Carctar antes del patron:
    SELECT * FROM "Usuarios" WHERE "Nombre" LIKE 'pattern%';
    -- Este devuelve todos los registros donde se encuentre el patron sin considerar lo que venga despues del patron.

    --Caracter despues del patron:
    SELECT * FROM "Usuarios" WHERE "Nombre" LIKE '%pattern';
    -- Este devuelve todos los registros donde se encuentre el patron sin considerar lo que venga antes del patron.

    --Caracter antes y despues del patron:
    SELECT * FROM "Usuarios" WHERE "Nombre" LIKE '%pattern%';
    -- Este devuelve todos los registros lo que contenga el patron en cualquier posicion.