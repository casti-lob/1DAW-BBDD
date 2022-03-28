/*
 * 
1 Mostrar el identificador de los alumnos 
matriculados en cualquier asignatura 
excepto la '150212' y la '130113'.

*/

SELECT DISTINCT aa.IDALUMNO 
FROM ALUMNO_ASIGNATURA aa 
WHERE aa.IDASIGNATURA  in
						( 
						SELECT aa.IDASIGNATURA 
						FROM ALUMNO_ASIGNATURA aa 
						WHERE aa.IDASIGNATURA !='150212'
						AND aa.IDASIGNATURA !='130113'
						);

					
--modo 2
SELECT aa.IDALUMNO  
FROM ALUMNO_ASIGNATURA aa 
WHERE aa.IDASIGNATURA !='150212'
AND aa.IDASIGNATURA !='130113';

/*
 * 2 Mostrar el nombre de las asignaturas 
 * que tienen más créditos que 
 * "Seguridad Vial". 
 * 
 */
SELECT a.NOMBRE 
FROM ASIGNATURA a 
WHERE a.CREDITOS >
					(
					SELECT a.CREDITOS 
					FROM ASIGNATURA a
					WHERE LOWER(a.NOMBRE) LIKE 'seguridad vial' 
					
					);
				

				
/*
 * 3 Obtener el Id de los alumnos 
 * matriculados en las asignaturas 
 * "150212" y "130113" a la vez. 
 * 
 */

SELECT DISTINCT aa.IDALUMNO 
FROM ALUMNO_ASIGNATURA aa 
WHERE aa.IDASIGNATURA = all
						(SELECT aa.IDASIGNATURA 
						FROM ALUMNO_ASIGNATURA aa2
						WHERE aa.IDASIGNATURA = '150212'
						
						)
AND aa.IDASIGNATURA = all
						(SELECT aa.IDASIGNATURA 
						FROM ALUMNO_ASIGNATURA aa2
						WHERE aa.IDASIGNATURA = '130113'				
						);
					
--Modo 2
SELECT aa.IDALUMNO 
FROM ALUMNO_ASIGNATURA aa , ALUMNO_ASIGNATURA aa2 
WHERE aa.IDALUMNO =aa2.IDALUMNO 
AND aa.IDASIGNATURA= '150212'
AND aa.IDASIGNATURA ='130113'	;	

/*
 * 4 Mostrar el Id de los alumnos matriculados en las asignatura
 *  "150212" ó "130113", en una o en otra pero no en ambas a 
 * la vez. 
 * 
 */

SELECT DISTINCT aa.IDALUMNO 
FROM ALUMNO_ASIGNATURA aa 
WHERE aa.IDASIGNATURA = all
						(SELECT aa.IDASIGNATURA 
						FROM ALUMNO_ASIGNATURA aa
						WHERE aa.IDASIGNATURA = '150212'
						
						)
OR  aa.IDASIGNATURA = all
						(SELECT aa.IDASIGNATURA 
						FROM ALUMNO_ASIGNATURA aa
						WHERE aa.IDASIGNATURA = '130113'				
						)

--Modo 2
SELECT DISTINCT aa.IDALUMNO 
FROM ALUMNO_ASIGNATURA aa
WHERE aa.IDASIGNATURA ='130113'
OR aa.IDASIGNATURA = '150212';
						
/*
 * 5 Mostrar el nombre de las asignaturas de la titulación 
 * "130110" cuyos costes básicos sobrepasen el coste básico 
 * promedio por asignatura en esa titulación.
 * 
 */
SELECT a.NOMBRE 
FROM ASIGNATURA a
WHERE a.IDTITULACION  ='130110'
AND a.COSTEBASICO > 
					(SELECT AVG(nvl(a.COSTEBASICO,0)) 
					FROM ASIGNATURA a
					WHERE a.IDTITULACION  ='130110'

					);

	

/*
 * 6 Mostrar el identificador de los alumnos matriculados en 
 * cualquier asignatura excepto la "150212" y la "130113”
 */
SELECT DISTINCT aa.IDALUMNO 
FROM ALUMNO_ASIGNATURA aa 
WHERE aa.IDASIGNATURA in
						(SELECT  aa.IDASIGNATURA 
						FROM ALUMNO_ASIGNATURA aa
						WHERE aa.IDASIGNATURA != '150212'
						AND aa.IDASIGNATURA !='130113'
						);
--Modo 2
SELECT aa.IDALUMNO  
FROM ALUMNO_ASIGNATURA aa 
WHERE aa.IDASIGNATURA !='150212'
AND aa.IDASIGNATURA !='130113';
/*
 * 7 Mostrar el Id de los alumnos matriculados en la 
 * asignatura "150212" pero no en la "130113". 
 * 
 */
SELECT aa.IDALUMNO 
FROM ALUMNO_ASIGNATURA aa 
WHERE aa.IDASIGNATURA = ALL
							(SELECT aa.IDASIGNATURA  
							FROM ALUMNO_ASIGNATURA aa
							WHERE aa.IDASIGNATURA = '150212'
							AND aa.IDASIGNATURA !='130113'
							);
--Modo 2
SELECT aa.IDALUMNO 
FROM ALUMNO_ASIGNATURA aa  
WHERE aa.IDASIGNATURA ='150212'
AND aa.IDASIGNATURA !='130113';

/*
 * 8 Mostrar el nombre de las asignaturas que tienen más 
 * créditos que "Seguridad Vial". 
 */
SELECT a.NOMBRE 
FROM ASIGNATURA a 
WHERE a.CREDITOS >
					(
					SELECT a.CREDITOS 
					FROM ASIGNATURA a
					WHERE LOWER(a.NOMBRE) LIKE 'seguridad vial' 
					
					);

				
				
/*
 * 9 Mostrar las personas que no son ni profesores ni alumnos.
 * 
 */
SELECT p.*
FROM PERSONA p 
WHERE p.DNI NOT IN (SELECT a.DNI 
					FROM ALUMNO a 
					)
AND p.DNI NOT IN ( SELECT p2.DNI 
					FROM PROFESOR p2 
					);

--MOdo 2
SELECT p.*
FROM PERSONA p , PROFESOR p2 , ALUMNO a 
WHERE p.DNI = p2.DNI (+)
AND p.DNI = a.DNI (+)
AND p2.DNI IS NULL
AND a.DNI IS NULL;
				
/*
 * 10 Mostrar el nombre de las asignaturas que tengan 
 * más créditos. 
 */
SELECT a.NOMBRE 
FROM ASIGNATURA a 
WHERE a.CREDITOS =
					( SELECT MAX(a.CREDITOS) 
					FROM ASIGNATURA a
					);
				
				

/*
 * 11 Lista de asignaturas en las que no se ha 
 * matriculado nadie. 
 */
SELECT a.NOMBRE 
FROM ALUMNO_ASIGNATURA aa, ASIGNATURA a
WHERE aa.IDASIGNATURA = a.IDASIGNATURA 
AND aa.IDALUMNO NOT IN 
						(SELECT aa.IDALUMNO 
						FROM ALUMNO_ASIGNATURA aa  
						);


/*
 * 12 Ciudades en las que vive algún profesor y también 
 * algún alumno. 
 */
SELECT DISTINCT p.CIUDAD 
FROM PERSONA p 
WHERE p.CIUDAD  IN 
			(SELECT p2.CIUDAD 
			FROM PROFESOR p, PERSONA p2
			WHERE  p.DNI = p2.DNI 
			)
and p.CIUDAD  IN 
			(SELECT p.CIUDAD 
			FROM ALUMNO a, PERSONA p
			WHERE p.DNI = a.DNI 
			);	



INSERT INTO PERSONA 
VALUES ('70',NULL,NULL,dublin,NULL,NULL,NULL,NULL,null);

INSERT INTO PROFESOR 
VALUES('99','70');

