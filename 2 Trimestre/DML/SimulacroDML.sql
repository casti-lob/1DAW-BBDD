alter session set "_oracle_script"=true;  
create user simulacroDML identified by simulacroDML;
GRANT CONNECT, RESOURCE, DBA TO simulacroDML;

CREATE TABLE PROFESOR
	(idprofesor		NUMBER(8),
	nif_p			VARCHAR2(11),
	nombre			VARCHAR2(100),
	especialidad	VARCHAR2(200),
	telefono		VARCHAR2(50),
	CONSTRAINT pk_profesor PRIMARY KEY (idprofesor)
	);
	
CREATE TABLE ASIGNATURA
	(codasignatura		VARCHAR2(100),
	nombre				VARCHAR2(200),
	idprofesor		NUMBER(8),
	CONSTRAINT pk_asignatura PRIMARY KEY (codasignatura),
	CONSTRAINT fk_asig_idprof FOREIGN KEY (idprofesor) REFERENCES PROFESOR(idprofesor)
	);
	
CREATE TABLE ALUMNO
	(nummatricula	NUMBER(8),
	nombre	VARCHAR2(100),
	fechanacimiento	DATE,
	telefono	VARCHAR2(50),
	CONSTRAINT pk_nummatricula PRIMARY KEY(nummatricula)
	);

CREATE TABLE RECIBE
	(nummatricula	NUMBER(8),
	codasignatura		VARCHAR2(100),
	cursoescolar	VARCHAR2(100),
	CONSTRAINT pk_recibe PRIMARY KEY(nummatricula,codasignatura,cursoescolar),
	CONSTRAINT fk_recibe_matri FOREIGN KEY (nummatricula)REFERENCES ALUMNO(nummatricula),
	CONSTRAINT fk_recibe_asig FOREIGN KEY (codasignatura)REFERENCES ASIGNATURA(codasignatura)
	);

--2
INSERT INTO PROFESOR 
VALUES(123,'AAA','Manuel','Mates','658856574');

INSERT INTO PROFESOR 
VALUES(321,'BBB','Jesus','Fisica','581235651');

INSERT INTO ASIGNATURA 
VALUES('aa11','Mates',123);

INSERT INTO ASIGNATURA 
VALUES('bb22','Mates chungas',123);

INSERT INTO ASIGNATURA 
VALUES('cc33','Lengua',NULL);

INSERT INTO ASIGNATURA 
VALUES('jj66','Fisica',321);



INSERT INTO ALUMNO
VALUES(1,'Juan',to_date('10/03/2001','dd/mm/yyyy'),'526987745');

INSERT INTO ALUMNO
VALUES(2,'Juan',to_date('10/03/1996','dd/mm/yyyy'),'526987745');

INSERT INTO ALUMNO
VALUES(3,'Juan',to_date('10/03/1997','dd/mm/yyyy'),'526987745');

INSERT INTO ALUMNO
VALUES(4,'Juan',to_date('10/03/2000','dd/mm/yyyy'),'526987745');

INSERT INTO ALUMNO
VALUES(5,'Juan',to_date('10/03/1200','dd/mm/yyyy'),'526987745');

INSERT INTO ALUMNO
VALUES(6,'Juan',to_date('10/03/1695','dd/mm/yyyy'),'526987745');

INSERT INTO ALUMNO
VALUES(7,'Juan',to_date('10/03/1496','dd/mm/yyyy'),'526987745');

INSERT INTO ALUMNO
VALUES(8,'Juan',to_date('10/03/2005','dd/mm/yyyy'),'526987745');

INSERT INTO ALUMNO
VALUES(9,'Juan',to_date('10/03/2001','dd/mm/yyyy'),'526987745');

INSERT INTO ALUMNO
VALUES(10,'Juan',to_date('10/03/2001','dd/mm/yyyy'),'526987745');


SELECT * FROM asignatura;
INSERT INTO recibe
VALUES (1,'aa11','1eso');
INSERT INTO recibe
VALUES (1,'bb22','1eso');

INSERT INTO recibe
VALUES (2,'jj66','1eso');
INSERT INTO recibe
VALUES (2,'cc33','1eso');

INSERT INTO recibe
VALUES (3,'bb22','1eso');
INSERT INTO recibe
VALUES (3,'jj66','1eso');

INSERT INTO recibe
VALUES (4,'bb22','1eso');
INSERT INTO recibe
VALUES (4,'jj66','1eso');

INSERT INTO recibe
VALUES (5,'bb22','1eso');
INSERT INTO recibe
VALUES (5,'aa11','1eso');

INSERT INTO recibe
VALUES (6,'aa11','1eso');
INSERT INTO recibe
VALUES (6,'jj66','1eso');

INSERT INTO recibe
VALUES (7,'bb22','1eso');
INSERT INTO recibe
VALUES (7,'cc33','1eso');

INSERT INTO recibe
VALUES (8,'bb22','1eso');
INSERT INTO recibe
VALUES (8,'aa11','1eso');

INSERT INTO recibe
VALUES (9,'bb22','1eso');
INSERT INTO recibe
VALUES (9,'cc33','1eso');

INSERT INTO recibe
VALUES (10,'bb22','1eso');
INSERT INTO recibe
VALUES (10,'jj66','1eso');



--3 no deja introducir el 2º alumna ya que la primary key esta repetida
INSERT INTO ALUMNO
VALUES (11,'Antonia',to_date('01/12/1992','DD/MM/YYYY'),'545699655');

INSERT INTO ALUMNO
VALUES (11,'Antonia',to_date('01/12/1992','DD/MM/YYYY'),'545699655');

--4
INSERT INTO ALUMNO(nummatricula,nombre,fechanacimiento)
VALUES (12,'Manue',to_date('01/12/1992','DD/MM/YYYY'));

INSERT INTO ALUMNO(nummatricula,nombre,fechanacimiento)
VALUES (13,'Manue',to_date('01/12/1992','DD/MM/YYYY'));

INSERT INTO ALUMNO(nummatricula,nombre,fechanacimiento)
VALUES (14,'Manue',to_date('01/12/1992','DD/MM/YYYY'));


--5
UPDATE  ALUMNO
SET telefono='954998877'
WHERE TELEFONO IS NULL;


--6
UPDATE ALUMNO
SET fechanacimiento = to_date('22/07/1981','dd/mm/yyyy')
WHERE extract(YEAR FROM fechanacimiento) > 2000;



--7
SELECT * FROM profesor WHERE telefono IS NOT NULL AND upper(nif_p) LIKE 'A%';

UPDATE PROFESOR
SET especialidad = 'Informática'
WHERE telefono IS NOT NULL AND upper(nif_p) LIKE 'A%';

--8
DELETE FROM RECIBE 
WHERE codasignatura = 'cc33';

--9
DELETE FROM ASIGNATURA 
WHERE codasignatura ='cc33';

--10 No se puede borrar las asignaturas ya que la pk esta asociada con otra tabla 
DELETE FROM ASIGNATURA;
--De esta forma se soluciona
ALTER TABLE RECIBE drop CONSTRAINT fk_recibe_asig ;
ALTER TABLE RECIBE add	CONSTRAINT fk_recibe_asig FOREIGN KEY (codasignatura)REFERENCES ASIGNATURA(codasignatura)ON DELETE CASCADE;
DELETE FROM ASIGNATURA;

--11 si se pueden borrar ya que en las anteriores operaciones se han borrado los datos de asignatura y por tanto la pk de profesor no esta enlazada con otra tabla
DELETE FROM PROFESOR;

--12
UPDATE alumno
SET nombre = upper(nombre);

--13
CREATE TABLE ALUMNO_BACKUP
	(nummatricula	NUMBER(8),
	nombre	VARCHAR2(100),
	fechanacimiento	DATE,
	telefono	VARCHAR2(50),
	CONSTRAINT pk_nummatricula_backup PRIMARY KEY(nummatricula)
	);
INSERT INTO ALUMNO_BACKUP
SELECT * FROM ALUMNO;


















