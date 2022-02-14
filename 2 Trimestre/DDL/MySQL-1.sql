/*ejercicio1*/
CREATE TABLE departamento
	(codigo			INT(10),
	nombre 			VARCHAR(100),
	presupuesto		DOUBLE,
	CONSTRAINT pk_departamento PRIMARY KEY (codigo)
	);
	
CREATE TABLE empleado	
	(codigo			INT(10),
	nif				VARCHAR(9),
	nombre			VARCHAR(100),
	apellido1		VARCHAR(100),
	apellido2		VARCHAR(100),
	codigo_departamento		INT(10),
	CONSTRAINT pk_empleado PRIMARY KEY (codigo),
	CONSTRAINT fk_empleado_departamento FOREIGN KEY (codigo_departamento) REFERENCES departamento(codigo)
	);
	






/*ejercicio2*/

CREATE TABLE COMERCIAL 
	(id				INT(10),
	nombre			VARCHAR(100),
	apellido1		VARCHAR(100),
	apellido2		VARCHAR(100),
	ciudad			VARCHAR(100),
	comision		FLOAT,
	CONSTRAINT pk_comercial PRIMARY KEY(id)
	);

CREATE TABLE CLIENTE
	(id 			INT(10),
	nombre			VARCHAR(100),
	apellido1		VARCHAR(100),
	apellido2		VARCHAR(100),
	ciudad			VARCHAR(100),
	categoria		INT(10),
	CONSTRAINT pk_cliente PRIMARY KEY (id)
	);


CREATE TABLE PEDIDO
	(id				INT(10),
	cantidad 		DOUBLE,
	fecha			DATE,
	id_cliente		INT(10),
	id_comercial	INT(10),
	CONSTRAINT pk_pedido PRIMARY KEY(id),
	CONSTRAINT fk_pedido_cliente FOREIGN KEY(id_cliente) REFERENCES CLIENTE(id),
	CONSTRAINT fk_pedido_comercial FOREIGN KEY(id_comercial) REFERENCES COMERCIAL(id)
	
	);












/*Ejercico3*/
CREATE TABLE DEPARTAMENTO
	(id			INT(10),
	nombre		VARCHAR(50),
	CONSTRAINT pk_departamento PRIMARY KEY(id)
	);

CREATE TABLE GRADO 
	(id 		INT(10),
	nombre		VARCHAR(100),
	CONSTRAINT pk_grado	PRIMARY KEY (id)
	);

CREATE TABLE CURSO_ESCOLAR	
	(id			INT(10),
	anyo_inicio		YEAR(4),
	anyo_fin		YEAR(4),
	CONSTRAINT pk_curso_escolar PRIMARY KEY (id)
	);

CREATE TABLE PROFESOR
	(id_profesor		INT(10),
	id_departamento		INT(10),
	CONSTRAINT pk_profesor PRIMARY KEY(id_profesor)
	);

CREATE TABLE ASIGNATURA
	(id				INT(10),
	nombre			VARCHAR(100),
	creditos		FLOAT,
	tipo			ENUM('normal','anormal'),
	curso			TINYINT(3),
	cuatrimestre	TINYINT(3),
	id_profesor		INT(10),
	id_grado		INT(10),
	CONSTRAINT pk_asignatura PRIMARY KEY(id),
	CONSTRAINT fk_grado FOREIGN KEY(id_grado) REFERENCES GRADO (id),
	CONSTRAINT fk_asignatura_profesor FOREIGN KEY(id_profesor) REFERENCES PROFESOR(id_profesor)
	
	);

CREATE TABLE PERSONA
	(id				INT(10),
	nif				VARCHAR(9),
	nombre			VARCHAR(25),
	apellido1		VARCHAR(50),
	apellido2		VARCHAR(50),
	ciudad			VARCHAR(25),
	direccion		VARCHAR(50),
	telefono		VARCHAR(9),
	fecha_nacimiento	DATE,
	sexo		ENUM('H','M'),
	tipo		ENUM('normal', 'preanormal'),
	CONSTRAINT pk_persona PRIMARY KEY(id)
	);

CREATE TABLE ALUMNO_SE_MATRICULA_ASIGNATURA
	(id_alumno		INT(10),
	id_asignatura	INT(10),
	id_curso_escolar	INT(10),
	CONSTRAINT pk_alumno PRIMARY KEY(id_alumno, id_asignatura,id_curso_escolar),
	CONSTRAINT fk_alumno_persona FOREIGN KEY (id_alumno) REFERENCES persona(id),
	CONSTRAINT fk_alumno asignatur FOREIGN KEY(id_asignatura) REFERENCES asignatura(id),
	);





























