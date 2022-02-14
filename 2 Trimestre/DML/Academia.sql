alter session set "_oracle_script"=true;  
create user academia identified by academia;
GRANT CONNECT, RESOURCE, DBA TO academia;

CREATE TABLE PROFESORES
	(nombre			VARCHAR2(100),
	apellido1		VARCHAR2(200),
	apellido2		VARCHAR2(200),
	dni				VARCHAR2(10),
	direccion		VARCHAR2(200),
	titulo			VARCHAR2(200),
	gana			NUMBER(10,2),
	CONSTRAINT pk_profesores PRIMARY KEY(dni)
	);

CREATE TABLE CURSO
	(nombre_curso	VARCHAR2(200) UNIQUE,
	cod_curso		NUMBER(10),
	dni_profesor	varchar2(10),
	maximo_alumnos	NUMBER(10),
	fecha_inicio	DATE,
	fecha_fin		DATE,
	num_horas		NUMBER(10),
	CONSTRAINT pk_curso PRIMARY KEY(cod_curso),
	CONSTRAINT fk_curso FOREIGN KEY(dni_profesor) REFERENCES PROFESORES(dni)
	
	);

CREATE TABLE ALUMNO 
	(nombre			VARCHAR2(100),
	apellido1		VARCHAR2(200),
	apellido2		VARCHAR2(200),
	dni				VARCHAR2(10),
	direccion		VARCHAR2(200),
	sexo			VARCHAR2(1),
	fecha_nacimiento DATE,
	curso			NUMBER(10),
	CONSTRAINT pk_alumno PRIMARY KEY (dni),
	CONSTRAINT fk_alumno FOREIGN KEY(curso) REFERENCES CURSO (cod_curso),
	CONSTRAINT ch_sexo CHECK(sexo IN ('H','M'))
	);

--2
INSERT INTO PROFESORES
VALUES ('Juan','Arch','López','32432455','Puerta Negra, 4','Ing. Informática',7500);

INSERT INTO PROFESORES
VALUES ('María','Oliva','Rubio','43215643','Juan Alfonso 32','Lda. Fil. Inglesa',5400);

INSERT INTO CURSO
VALUES('Inglés Básico',1,'43215643',15,to_date('01/11/00','dd/mm/yy'),to_date('22-DIC-00','dd-month-yy'),120);

INSERT INTO CURSO(nombre_curso,cod_curso,dni_profesor,fecha_inicio,num_horas)
VALUES('Administración Linux',2	,'32432455',TO_DATE('01-SEP-00','dd-month-yy'),80);

--3
--Da fallo por la restriccion ya que sexo solo puede ser H o M y tiene el mismo dni por lo que hay conflicot en la pk 
INSERT INTO ALUMNO (nombre,apellido1,apellido2,dni,sexo,curso)
VALUES('Sergio','Navas','Retal','123525','H',1);


--4 Ya exixte el mismo dni y da conflicto con la pk
INSERT INTO PROFESORES
VALUES('Juan','Arch','López','32432465','Puerta Negra, 4','Ing. Informática', null)

--5
INSERT INTO ALUMNO(nombre,apellido1,apellido2,dni,direccion,sexo)
VALUES('María','Jaén','Sevilla','789678','Martos, 5','M');

--6
UPDATE ALUMNO
SET fecha_nacimiento = TO_DATE('23-DEC-1976','DD-MONTH-YYYY')
WHERE dni= 2567567;

--7 No se puede cambiar al curso 5 ya que este no existe
UPDATE ALUMNO
SET curso = 2
WHERE dni=2567567;

--8
DELETE PROFESORES
WHERE upper (nombre)= 'LAURA' AND UPPER (apellido1)= 'JIMÉNEZ';

--9 No se puede a priori ya que el curso esta relacionado con alumnos por lo que debemos de actualizarlo

UPDATE ALUMNO
SET curso = NULL
WHERE curso=1;

DELETE CURSO 
WHERE cod_curso = 1;

--10
ALTER TABLE CURSO ADD numero_alumnos  NUMBER(10);

--11
UPDATE ALUMNO
SET fecha_nacimiento = TO_DATE('01/01/2012','dd/mm/yyyy')
WHERE fecha_nacimiento IS NULL;

--12
ALTER TABLE ALUMNO DROP COLUMN sexo;

--13
UPDATE PROFESORES
SET gana = nvl(gana,0)*1.20
WHERE titulo like '%Infor%';


 
--14
UPDATE ALUMNO
SET dni='1234567'
WHERE apellido1='Arch';

--15
UPDATE PROFESORES
SET dni = '7654321'
WHERE titulo = '%Infor%';

--16
UPDATE ALUMNO 
SET sexo='F'
WHERE apellido1='Jaén';



