--1. Obtener las diferentes nacionalidades de películas que existen en la base dedatos.
SELECT DISTINCT p.NACIONALIDAD 
FROM PELICULA p ;

--2. Mostrar el código de la película, la fecha de estreno y la recaudación de laspelículas ordenadas por su recaudación de mayor a menor estrenadas antes del 22de septiembre de 1997
SELECT p.CIP ,p.FECHA_ESTRENO , p.RECAUDACION 
FROM PROYECCION p 
WHERE FECHA_ESTRENO < TO_date('22-09-1997','dd-mm-yyyy')
ORDER BY p.RECAUDACION DESC ;

/*
3. Mostrar el código de las películas, la recaudación y el número de espectadores
cuyo número de espectadores sea mayor que 3000 o cuya recaudación sea mayor o
igual que 2000000, ordenadas de mayor a menor número de espectadores.
*/

SELECT DISTINCT p.CIP , p.RECAUDACION , p.ESPECTADORES 
FROM PROYECCION p 
WHERE p.ESPECTADORES >3000
OR p.RECAUDACION >=2000000
ORDER BY p.ESPECTADORES DESC ;

/*
4. Obtener el nombre de los cines que contengan la cadena "ar" en mayúsculas o
minúsculas en su dirección.
*/
SELECT c.CINE 
FROM CINE c 
WHERE LOWER( c.DIRECCION_CINE) LIKE '%ar%';

/*
5. Mostrar los cines y su aforo total cuyo aforo total sea mayor que 600 ordenados
por su aforo total de forma descendente.
*/

SELECT s.CINE ,SUM(s.AFORO) AS aforoTotal 
FROM SALA s 
GROUP BY s.CINE 
HAVING SUM(s.AFORO)>600
ORDER BY SUM(s.AFORO) DESC;

--6. Obtener el título de las películas estrenadas en la primera quincena de cualquiermes.
SELECT DISTINCT p.TITULO_P 
FROM PELICULA p ,PROYECCION p2 
WHERE p.CIP = p2.CIP 
AND EXTRACT(DAY FROM p2.FECHA_ESTRENO) <= 15;

/*
7. Muestra la nacionalidad de las películas junto con la media del presupuesto por
cada nacionalidad teniendo en cuenta los valores nulos y teniendo en cuenta sólo
aquellas películas cuyo presupuesto es mayor que 500;
*/

SELECT p.NACIONALIDAD , AVG(NVL(p.PRESUPUESTO,0)) 
FROM PELICULA p 
WHERE p.PRESUPUESTO >500
GROUP BY p.NACIONALIDAD;
/*
8. Obtener el nombre y el sexo de todos los personajes cuyo nombre termine en 'n',
's' o 'e' y no tengan sexo asignado
*/

SELECT p.NOMBRE_PERSONA , p.SEXO_PERSONA 
FROM PERSONAJE p 
WHERE (LOWER(p.NOMBRE_PERSONA)LIKE '%n'
OR  LOWER(p.NOMBRE_PERSONA)LIKE '%s'
OR  LOWER(p.NOMBRE_PERSONA)LIKE '%n') 
AND p.SEXO_PERSONA IS NULL ;

--9 Mostrar el nombre de las películas que el número total de días que se hanestrenado sea mayor de 50
SELECT p.TITULO_P 
FROM PELICULA p , PROYECCION p2 
WHERE p.CIP = p2.CIP 
GROUP BY p.TITULO_P 
HAVING SUM(p2.DIAS_ESTRENO)>50 ;

/*
 * 10. Mostrar el nombre del cine, junto con su dirección y la ciudad en la que está,
junto con la sala y el aforo de la sala, y el nombre de las películas que se han
proyectado en esa sala. Los datos deben salir ordenados por el nombre del cine, la
sala del cine y por último el nombre de la película (puedes usar el nombre en
versión original o en español como quieras)
 */
SELECT c.CINE ,c.DIRECCION_CINE ,c.CIUDAD_CINE ,s.SALA ,s.AFORO, p2.TITULO_P 
FROM CINE c ,SALA s ,PROYECCION p ,PELICULA p2 
WHERE c.CINE = s.CINE 
AND s.SALA = p.SALA 
AND s.CINE = p.CINE 
AND p.CIP = p2.CIP 
ORDER BY c.CINE , s.SALA , p2.TITULO_P ;

/*
 * 11. Realizar una consulta que muestre por cada uno de los posibles trabajos(tareas)
que se pueden realizar en nuestra base de datos, el número de personas que han
realizado dicho trabajo.
Ten en cuenta que si una persona ha realizado dos veces el mismo trabajo sólo
deberá salir una vez.
 */
SELECT t.TAREA , COUNT(DISTINCT t2.NOMBRE_PERSONA) AS numero_trabajadores
FROM TAREA t , TRABAJO t2 
WHERE t.TAREA = t2.TAREA 
GROUP BY t.TAREA ;

/*
 * 12. Mostrar todos los datos de las películas estrenadas entre el 20 de septiembre de
1995 y el 15 de diciembre de 1995. Si la película se ha estrenado dos o más veces
en esas fechas sólo debe salir una vez
 */
SELECT DISTINCT p.*
FROM PELICULA p , PROYECCION p2 
WHERE p.CIP = p2.CIP 
AND p2.FECHA_ESTRENO BETWEEN  TO_date('20-09-1995','dd-mm-yyyy') AND p2.FECHA_ESTRENO TO_date('15-12-1995','dd-mm-yyyy') ;

--13. Mostrar el nombre de los cines y la ciudad en la que se han proyectado 22 o más películas distintas en todas sus salas.
SELECT c.CINE , c.CIUDAD_CINE 
FROM CINE c , SALA s , PROYECCION p 
WHERE c.CINE = s.CINE 
AND s.CINE = p.CINE 
AND s.SALA = p.SALA 
GROUP BY c.CINE , c.CIUDAD_CINE 
HAVING COUNT(DISTINCT p.CIP) >=22;

/*
 * 14. Obtener el nombre de la película y el presupuesto de todas las películas
americanas estrenadas en un cine de Córdoba, sabiendo que Córdoba está escrito
sin tilde en la base de datos y puede estar en mayúsculas o minúsculas.
 */
SELECT DISTINCT  p.TITULO_P , p.PRESUPUESTO 
FROM PELICULA p , PROYECCION p2 , SALA s , CINE c 
WHERE p.CIP = p2.CIP 
AND p2.CINE = s.CINE 
AND p2.SALA = s.SALA 
AND s.CINE = c.CINE 
AND LOWER(p.NACIONALIDAD)LIKE 'ee.uu'
AND LOWER(c.CIUDAD_CINE)LIKE 'cordoba' ;

/*
 * 15. Obtener el título y la recaudación total obtenida por películas que contengan en
su TITULO_P la cadena 'vi' en minúsculas o el número 7.
 */
SELECT p.TITULO_P , sum(nvl(p2.RECAUDACION,0)) 
FROM PELICULA p , PROYECCION p2 
WHERE p.CIP = p2.CIP
AND (p.TITULO_P LIKE '%vi%'
OR p.TITULO_P LIKE '%7%')
GROUP BY p.TITULO_P ;

/*
 * 16. Obtener el presupuesto máximo y el presupuesto mínimo para las películas.
Deberás utilizar los alias necesarios.
 */
SELECT MAX(p.PRESUPUESTO) AS presumuesto_max, MIN(p.PRESUPUESTO) AS presupuesto_min  
FROM PELICULA p ;

--17Explica en qué consiste el OUTER JOIN e indica un ejemplo justificándolo e incluyendo la sentencia correspondiente.
/*
 * Consiste en que si queremos calcular un campo que está referenciado por otro campo
 * que es nulo, no hay forma de referenciarlo, por lo que debemos de utilizar un OUTER JOIN
 * poniéndole al campo nulo un (+) para que nos lo pueda referenciar
 * 
 * Por ejemplo tenemos una tabla departamentos y otra trabajos realizados y queremos contar el
 * número de trabajos realizados por departamento lo que nos saldría la siguiente sentencia
 * 
 * select d.nombre, sum(t.cantidadtrabajos)
 * from departamento d, trabajos t
 * where d.id(+) = t.id_dept
 * group by d.nombre;
 * 
 */

/*
 * 18. Se desea obtener un listado de todas las proyecciones, adicionalmente deberá
aparecer en el listado otra columna que se llame fecha_estimada y cuyos valores a
mostrar sean la fecha de estreno con un incremento de 2 meses
 */
SELECT p.*, ADD_MONTHS(FECHA_ESTRENO,2) AS fecha_estimada
FROM PROYECCION p ;

/*
 * 19. Mostrar todos los datos de películas junto con los datos de sus proyecciones. En
este listado deben aparecer tanto las películas que tienes proyecciones como las
que no tienen proyección.
 */
SELECT  p.*, p2.*
FROM PELICULA p , PROYECCION p2 
WHERE p.CIP = p2.CIP(+);

/*
 * 20. Muestra el número de personajes que trabajan por cada película junto a su título
principal ordenados por nombre de película (titulo_p) de forma ascendente.
 */
SELECT COUNT(t.NOMBRE_PERSONA)AS n_personajes, p.TITULO_P  
FROM PELICULA p , TRABAJO t 
WHERE p.CIP = t.CIP 
GROUP BY p.TITULO_P 
ORDER BY p.TITULO_P DESC;






































