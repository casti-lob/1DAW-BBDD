

CREATE TABLE PROFESOR
	(dni		VARCHAR2(20),
	nombre		VARCHAR2(100)UNIQUE,
	direccion	VARCHAR2(200),
	titulacion	VARCHAR2(100),
	sueldo		NUMBER(5,2) NOT NULL,
	CONSTRAINT pk_profesor PRIMARY KEY(dni)
	);

CREATE TABLE CURSO
	(codigo 	VARCHAR2(20),
	nombre		VARCHAR2(50)UNIQUE,
	fecha_inicio	DATE,
	fecha_final		DATE,
	n_maximo		NUMBER(4),
	n_horas			NUMBER(4) NOT NULL,
	dni				VARCHAR2(20),
	CONSTRAINT pk_curso PRIMARY KEY(codigo),
	CONSTRAINT fk_curso_dni FOREIGN KEY (dni) REFERENCES PROFESOR (dni) ON DELETE CASCADE,
	CONSTRAINT ch_fecha_inicio CHECK (to_char(fecha_inicio,'mm/dd')>'09/09'AND to_char(fecha_final,'mm/dd')<'06/25')
	);
	
CREATE TABLE ALUMNO
	(codigo		VARCHAR2(20),
	codigo_curso	VARCHAR2(20),
	nombre		VARCHAR2(100),
	apellido	VARCHAR2(100),
	direccion	VARCHAR2(200),
	sexo	VARCHAR2(1),
	fecha_nacimiento	DATE,
	CONSTRAINT pk_alumno PRIMARY KEY(codigo),
	CONSTRAINT fk_alumno_codigo_curso FOREIGN KEY (codigo_curso)REFERENCES CURSO(codigo) ON DELETE CASCADE,
	CONSTRAINT ch_sexo CHECK(sexo = UPPER(sexo) AND (sexo='M' AND sexo='H'))
	);
	



