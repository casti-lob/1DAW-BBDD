CREATE TABLE PROFESOR
	(idprofesor		INT(8),
	nif_p			VARCHAR(11),
	nombre			VARCHAR(100),
	especialidad	VARCHAR(200),
	telefono		VARCHAR(50),
	CONSTRAINT pk_profesor PRIMARY KEY (idprofesor)
	);
	
CREATE TABLE ASIGNATURA
	(codasignatura		VARCHAR(100),
	nombre				VARCHAR(200),
	idprofesor		INT(8),
	CONSTRAINT pk_asignatura PRIMARY KEY (codasignatura),
	CONSTRAINT fk_asig_idprof FOREIGN KEY (idprofesor) REFERENCES PROFESOR(idprofesor)
	);
	
CREATE TABLE ALUMNO
	(nummatricula	INT(8),
	nombre	VARCHAR(100),
	fechanacimiento	DATE,
	telefono	VARCHAR(50),
	CONSTRAINT pk_nummatricula PRIMARY KEY(nummatricula)
	);

CREATE TABLE RECIBE
	(nummatricula	INT(8),
	codasignatura		VARCHAR(100),
	cursoescolar	VARCHAR(100),
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
VALUES(1,'Juan','2001-03-10','526987745');

INSERT INTO ALUMNO
VALUES(2,'Juan','1996-10-03','526987745');

INSERT INTO ALUMNO
VALUES(3,'Juan','1997-03-10','526987745');

INSERT INTO ALUMNO
VALUES(4,'Juan','2000-03-10','526987745');

INSERT INTO ALUMNO
VALUES(5,'Juan','1200-03-10','526987745');

INSERT INTO ALUMNO
VALUES(6,'Juan','1695-03-10','526987745');

INSERT INTO ALUMNO
VALUES(7,'Juan','1496-03-10','526987745');

INSERT INTO ALUMNO
VALUES(8,'Juan','2005-03-10','526987745');

INSERT INTO ALUMNO
VALUES(9,'Juan','2001-03-10','526987745');

INSERT INTO ALUMNO
VALUES(10,'Juan','2001-03-10','526987745');


SELECT * FROM ASIGNATURA;
INSERT INTO RECIBE
VALUES (1,'aa11','1eso');
INSERT INTO RECIBE
VALUES (1,'bb22','1eso');

INSERT INTO RECIBE
VALUES (2,'jj66','1eso');
INSERT INTO RECIBE
VALUES (2,'cc33','1eso');

INSERT INTO RECIBE
VALUES (3,'bb22','1eso');
INSERT INTO RECIBE
VALUES (3,'jj66','1eso');

INSERT INTO RECIBE
VALUES (4,'bb22','1eso');
INSERT INTO RECIBE
VALUES (4,'jj66','1eso');

INSERT INTO RECIBE
VALUES (5,'bb22','1eso');
INSERT INTO RECIBE
VALUES (5,'aa11','1eso');

INSERT INTO RECIBE
VALUES (6,'aa11','1eso');
INSERT INTO RECIBE
VALUES (6,'jj66','1eso');

INSERT INTO RECIBE
VALUES (7,'bb22','1eso');
INSERT INTO RECIBE
VALUES (7,'cc33','1eso');

INSERT INTO RECIBE
VALUES (8,'bb22','1eso');
INSERT INTO RECIBE
VALUES (8,'aa11','1eso');

INSERT INTO RECIBE
VALUES (9,'bb22','1eso');
INSERT INTO RECIBE
VALUES (9,'cc33','1eso');

INSERT INTO RECIBE
VALUES (10,'bb22','1eso');
INSERT INTO RECIBE
VALUES (10,'jj66','1eso');



--3 no deja introducir el 2º alumna ya que la primary key esta repetida
INSERT INTO ALUMNO
VALUES (11,'Antonia','1992-12-01','545699655');

INSERT INTO ALUMNO
VALUES (11,'Antonia','1992-12-01','545699655');

--4
INSERT INTO ALUMNO(nummatricula,nombre,fechanacimiento)
VALUES (12,'Manue','1992-12-01');

INSERT INTO ALUMNO(nummatricula,nombre,fechanacimiento)
VALUES (13,'Manue','1992-12-01');

INSERT INTO ALUMNO(nummatricula,nombre,fechanacimiento)
VALUES (14,'Manue','1992-12-01');


--5
UPDATE  ALUMNO
SET telefono='954998877'
WHERE TELEFONO IS NULL;



--6
UPDATE ALUMNO
SET fechanacimiento = '1981-07-22'
WHERE extract(YEAR FROM fechanacimiento) > 2000;



--7
SELECT * FROM PROFESOR WHERE telefono IS NOT NULL AND upper(nif_p) LIKE 'A%';

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
ALTER TABLE RECIBE DROP CONSTRAINT fk_recibe_asig ;
ALTER TABLE RECIBE add	CONSTRAINT fk_recibe_asig FOREIGN KEY (codasignatura)REFERENCES ASIGNATURA(codasignatura)ON DELETE CASCADE;
DELETE FROM ASIGNATURA;

--11 si se pueden borrar ya que en las anteriores operaciones se han borrado los datos de asignatura y por tanto la pk de profesor no esta enlazada con otra tabla
DELETE FROM PROFESOR;

--12
UPDATE ALUMNO
SET nombre = upper(nombre);

--13
CREATE TABLE ALUMNO_BACKUP
	(nummatricula	INT(8),
	nombre	VARCHAR(100),
	fechanacimiento	DATE,
	telefono	VARCHAR(50),
	CONSTRAINT pk_nummatricula_backup PRIMARY KEY(nummatricula)
	);
INSERT INTO ALUMNO_BACKUP
SELECT * FROM ALUMNO;


















