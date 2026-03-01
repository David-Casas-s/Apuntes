--Sintaxis basica:
SELECT column1,
       CASE 
           WHEN condition1 THEN result1
           WHEN condition2 THEN result2
           ELSE result3
       END AS alias_name
FROM nameTab;
--Su funcionamineto es similar a una estructura condicional IF y ELSE de los demás lenguajes de programacion.

--Ejemplo:
SELECT *,
    CASE
	    WHEN "Edad" > 18 THEN 'Es mayor de EDAD'
	    ELSE 'ES menor EDAD'
	    END AS "Mayotia de EDAD"
FROM "Usuarios"
