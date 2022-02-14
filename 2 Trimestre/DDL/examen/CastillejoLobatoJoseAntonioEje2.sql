alter session set "_oracle_script"=true;  
create user castillejoJoseAntonioEje2 identified by castillejoJoseAntonioEje2;
GRANT CONNECT, RESOURCE, DBA TO castillejoJoseAntonioEje2;

CREATE TABLE DEPARTAMENTO
	(id							NUMBER(10),
	nombre 						VARCHAR2(50),
	CONSTRAINT pk_departamento PRIMARY KEY (id)
	);

CREATE TABLE PROFESOR
	(id_profesor				NUMBER(10),
	id_departamento				NUMBER(10),
	CONSTRAINT pk_profesor PRIMARY KEY (id_profesor),
	CONSTRAINT fk_profesor_dept FOREIGN KEY(id_departamento) REFERENCES DEPARTAMENTO(id)
	);

CREATE TABLE GRADO
	(id 						NUMBER(10),
	nombre						VARCHAR2(100),
	CONSTRAINT pk_grado PRIMARY KEY (id)
	);
CREATE TABLE ASIGNATURA
	(id							NUMBER(10),
	nombre						VARCHAR2(100),
	creditos					NUMBER(5,2),
	tipo						VARCHAR2(100),
	curso						VARCHAR2(50),
	cuatrimestre				NUMBER(2),
	id_profesor					NUMBER(10),
	id_grado					NUMBER(10),
	CONSTRAINT pk_asignatura PRIMARY KEY(id),
	CONSTRAINT fk_asignatura_prof FOREIGN KEY (id_profesor) REFERENCES PROFESOR(id_profesor),
	CONSTRAINT fk_asignatura_grado FOREIGN KEY(id_grado) REFERENCES GRADO (id)
	);
CREATE TABLE PERSONA
	(id							NUMBER(10),
	nif							VARCHAR2(9),
	nombre						VARCHAR2(25),
	apellido1					VARCHAR2(50),
	apellido2					VARCHAR2(50),
	ciudad						VARCHAR2(25),
	direccion					VARCHAR2(50),
	telefono					VARCHAR2(9),
	fecha_nacimiento			DATE,
	sexo						VARCHAR2(1),
	tipo						VARCHAR2(200),
	CONSTRAINT pk_persona PRIMARY KEY(id)
	);

ALTER TABLE PROFESOR ADD CONSTRAINT fk_profesor_pers FOREIGN KEY(id_profesor) REFERENCES PERSONA(id);

CREATE TABLE CURSO_ESCOLAR 
	(id							NUMBER(10),
	anyo_inicio					DATE,
	anyo_fin					DATE,
	CONSTRAINT pk_curso_escolar PRIMARY KEY(id)
	);

CREATE TABLE ALUMNO_SE_MATRICULA_ASIGNATURA
	(id_alumno					NUMBER(10),
	id_asignatura				NUMBER(10),
	id_curso_escolar			NUMBER(10),
	CONSTRAINT pk_alumno PRIMARY KEY(id_alumno, id_asignatura, id_curso_escolar),
	CONSTRAINT fk_alumno_persona FOREIGN KEY(id_alumno)REFERENCES PERSONA(id),
	CONSTRAINT fk_alumno_asignatura FOREIGN KEY(id_asignatura) REFERENCES ASIGNATURA(id),
	CONSTRAINT fk_alumno_curso	FOREIGN KEY(id_curso_escolar)REFERENCES CURSO_ESCOLAR(id)
	);

ALTER TABLE PERSONA ADD CONSTRAINT ch_nombre CHECK(nombre=UPPER(NOMBRE));

ALTER TABLE PERSONA ADD edad NUMBER(3);

ALTER TABLE PERSONA ADD CONSTRAINT ch_edad CHECK(edad BETWEEN 7 AND 25 );

ALTER TABLE CURSO_ESCOLAR ADD CONSTRAINT ch_fecha_curso CHECK(anyo_inicio< anyo_fin);

ALTER TABLE ASIGNATURA ADD CONSTRAINT ch_cuatrimestre CHECK(cuatrimestre BETWEEN 1 AND 4);

ALTER TABLE ASIGNATURA ADD CONSTRAINT ch_tipo CHECK(tipo = INITCAP('L'));

ALTER TABLE PERSONA ADD CONSTRAINT ch_fecha_nacimiento CHECK(TO_CHAR(fecha_nacimiento,'YYYY')>'1981');

ALTER TABLE ASIGNATURA DROP COLUMN creditos;
/*
DROP TABLE DEPARTAMENTO CASCADE CONSTRAINT;
DROP TABLE PROFESOR CASCADE CONSTRAINT;
DROP TABLE PERSONA CASCADE CONSTRAINT;
DROP TABLE ASIGNATURA CASCADE CONSTRAINT;
DROP TABLE GRADO CASCADE CONSTRAINT;
DROP TABLE ALUMNO_SE_MATRICULA_ASIGNATURA CASCADE CONSTRAINT;
DROP TABLE CURSO_ESCOLAR CASCADE CONSTRAINT;
*/
