--Apartado1
INSERT INTO PERSONA
VALUES('28821641L','Jose Antonio','Castillejo Lobato','Sevilla','ParqueFlores',2,'954556654',TO_DATE('13/06/1996','dd/mm/yyyy'),1);


INSERT INTO ALUMNO
VALUES('A141414','28821641L');

INSERT INTO ALUMNO_ASIGNATURA
VALUES('A141414','160002',1);

--Apartado2
ALTER TABLE PROFESOR DROP CONSTRAINT SYS_C0011413; 

DELETE FROM PERSONA
WHERE DNI='25252525A';

UPDATE PROFESOR
SET dni =  '77222122K'
WHERE idprofesor ='P117';

INSERT INTO PERSONA
VALUES('77222122K',' MARTA','LÓPEZ  MARTOS','SEVILLA','CALLE  TARFIA',9,'615891432',TO_DATE('22/07/1981','DD/MM/YYYY'),0);
ALTER TABLE PROFESOR ADD CONSTRAINT SYS_C0011413 FOREIGN KEY (dni)REFERENCES PERSONA(dni);

--Apartado3
CREATE TABLE ALUMNOS_MUYREPETIDORES 
	(idasignatura VARCHAR2(6),
	idalumno VARCHAR2(7),
	nombre VARCHAR2(30),
	apellido VARCHAR2(30),
	telefono VARCHAR2(9),
	CONSTRAINT pk_ALUMNOS_MUYREPETIDORES PRIMARY KEY(idalumno,idasignatura),
	CONSTRAINT fk_muyrepe_idasig FOREIGN KEY(idasignatura) REFERENCES ASIGNATURA(idasignatura),
	CONSTRAINT fk_muyrepe_alum FOREIGN KEY(idalumno) REFERENCES ALUMNO (idalumno)
	);

INSERT INTO ALUMNOS_MUYREPETIDORES(idasignatura,idalumno)
SELECT idasignatura, idalumno FROM ASIGNATURA,ALUMNO;


--Apartado 4
ALTER TABLE ALUMNOS_MUYREPETIDORES  ADD observaciones VARCHAR2(200);

UPDATE ALUMNOS_MUYREPETIDORES 
SET observaciones ='Se encuantra en seguimiento'
WHERE TELEFONO LIKE '%20%' AND IDALUMNO IN
	(SELECT IDALUMNO FROM PERSONA p, ALUMNO a
	WHERE ciudad like'Sevilla' AND p.dni= a.dni);

--Apartado 5
DELETE ALUMNOS_MUYREPETIDORES
WHERE IDALUMNO IN
	(SELECT IDALUMNO FROM PERSONA p, ALUMNO a
	WHERE to_char(fecha_nacimiento,'MM/YYYY')= '11/1971');

--Apartado 6 
CREATE TABLE RESUMEN_TITULACIONES
	(NOMBRE_TITULACIÓN VARCHAR2(20),
	NUMEROASIGNATURAS VARCHAR2(6),
	CONSTRAINT pk_RESUMEN_TITULACIONES PRIMARY KEY(NOMBRE_TITULACIÓN),
	CONSTRAINT fk_resum_titu FOREIGN KEY(NUMEROASIGNATURAS) REFERENCES ASIGNATURA(idasignatura)
	);

INSERT INTO RESUMEN_TITULACIONES
SELECT nombre,idasignatura FROM ASIGNATURA;

--Apartado 7

--7.1
/*
 * Si si se encuantra en la misma sesión y se cierra el programa y la sesion
 * 	no podra ver los datos ya que no se ha realizado un commit y por tango los datos no quedan guardados
 */

--7.2
/*
 * Solo se podra consultar la tabla mientras este en el mismo equipo y en la misma sesión
 * ya que en el momento que cambie de equipo o de sesion se borraran los datos ya que no se 
 * ha realizado ningún commit
 */

--7.3
/*
 * Se puede volver hacia un punto siempre si se ha realizado un savepoint mediante la operacion rollback si no se ha realizado
 * el savepoint el rollback nos traslada al ultimo commit realizado 

--7.4
/*
 * Si no estamos seguros si los datos son correctos se realiza un savepoint para poder volver hacia el punto y luego
 * comprobado si es correcto se realiza un commit, si se esta seguro desde el principio se utiliza la operación commit
 */

--7.5
/*
 * Se puede utilizar la operación rollback que si tenemos un savepoint nos trasladaremos al punto de guardado o si no nos trasladaremos
 * hacia el ultimo commit realizado
 */

--7.6
/*
 * Consiste en un punto de guardado para poder volver hacia ese punto si queremos
 * Por ejemplo
 * 
 * CREATE TABLE ALUMNOS_MUYREPETIDORES 
	(idasignatura VARCHAR2(6),
	idalumno VARCHAR2(7),
	nombre VARCHAR2(30),
	apellido VARCHAR2(30),
	telefono VARCHAR2(9),
	CONSTRAINT pk_ALUMNOS_MUYREPETIDORES PRIMARY KEY(idalumno,idasignatura)
	);
	
 * SAVEPOINT tablainicio
 * 
 * Insert into ALUMNOS_MUYREPETIDORES (idasignatura,idalumno)
 * values('ddd','r');
 * 
 * Si nos equivocamos podemos volver al punto anterior de la siguiente manera
 * ROLLBACK tablainicio;
 * 
 * Insert into ALUMNOS_MUYREPETIDORES (idasignatura,idalumno)
 * values('ddd','r');
 * 
 *   Insert into ALUMNOS_MUYREPETIDORES (idasignatura,idalumno)
 * values('ddd','r');
 * SAVEPOINT datos
 *   Insert into ALUMNOS_MUYREPETIDORES (idasignatura,idalumno)
 * values('ddd','r');
 * 
 * Para volver atras tenemos dos opciones
 * 
 * ROLLBACK tablainicio; para volver al punto inicio o
 * ROLLBACK datos; para volver al punto datos
 * 
 */


