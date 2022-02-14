
alter session set "_oracle_script"=true;  
create user Ejercicio1_RA2 identified by Ejercicio1_RA2;
GRANT CONNECT, RESOURCE, DBA TO Ejercicio1_RA2;
--Apartado A
CREATE TABLE FAMILIA 
	( nombre		VARCHAR2(100),
	caracteristicas	VARCHAR2(200),
	CONSTRAINT pk_familia PRIMARY KEY (nombre)
	);
	
CREATE TABLE GENERO
	(nombre			VARCHAR2(100),
	caracteristicas VARCHAR2(200),
	nombre_familia	VARCHAR2(100),
	CONSTRAINT pk_genero PRIMARY KEY (nombre),
	CONSTRAINT fk_genero_familia FOREIGN KEY(nombre_familia) REFERENCES FAMILIA(nombre)
	);
	
CREATE TABLE ESPECIE
	(nombre			VARCHAR2(100),
	caracteristicas VARCHAR2(200),
	nombre_genero	VARCHAR2(100),
	CONSTRAINT pk_especie PRIMARY KEY (nombre),
	CONSTRAINT fk_especie_genero FOREIGN KEY(nombre_genero) REFERENCES GENERO(nombre)
	);
	
CREATE TABLE ZONA
	(nombre			VARCHAR2(100),
	localidad		VARCHAR2(100),
	extension		NUMBER(7,2),
	protegida		VARCHAR2(2),
	CONSTRAINT pk_zona PRIMARY KEY(nombre),
	CONSTRAINT ch_protegida CHECK(protegida IN('SI','NO'))
	);
	
CREATE TABLE PERSONA
	(dni			VARCHAR2(10),
	nombre			VARCHAR2(100),
	direccion		VARCHAR2(200),
	telefono		VARCHAR2(12),
	usuario			VARCHAR2(100) UNIQUE,
	CONSTRAINT pk_persona PRIMARY KEY(dni)
	);

CREATE TABLE COLECCION
	(precio			NUMBER(6,2),
	fecha_inicio	DATE,
	n_ejemplares	NUMBER(7),
	dni				VARCHAR2(10),
	CONSTRAINT pk_coleccion PRIMARY KEY(dni,precio),
	CONSTRAINT fk_coleccion_persona FOREIGN KEY(dni) REFERENCES PERSONA(dni),
	CONSTRAINT ch_n_ejemplares CHECK(n_ejemplares BETWEEN 1 AND 150)
	);

CREATE TABLE EJEMPLAR_MARIPOSA
	(fecha_captura	DATE,
	hora_captura	NUMBER(2,2),
	nombre_comun	VARCHAR2(200),
	precio_ejemplar	NUMBER(6,2),
	fecha_coleccion	DATE,
	dni				VARCHAR2(10),
	precio			NUMBER(6,2),
	nombre_zona		VARCHAR2(100),
	nombre_especie 	VARCHAR2(100),
	CONSTRAINT pk_ejem_mariposa PRIMARY KEY(fecha_captura,hora_captura, dni,nombre_zona,nombre_especie ),
	CONSTRAINT fk_mariposa_colecc FOREIGN KEY(precio,dni) REFERENCES COLECCION(precio,dni),
	CONSTRAINT fk_mariposa_persona FOREIGN KEY(dni) REFERENCES PERSONA(dni),
	CONSTRAINT fk_mariposa_especie FOREIGN KEY(nombre_especie)REFERENCES ESPECIE(nombre),
	CONSTRAINT fk_mariposa_zona FOREIGN KEY(nombre_zona)REFERENCES ZONA(nombre),
	CONSTRAINT ch_precio CHECK(precio >0)
	
	);

--ApartadoB
ALTER TABLE PERSONA ADD  apellidos VARCHAR2(200);

ALTER TABLE ZONA ADD CONSTRAINT ch_extension CHECK(extension BETWEEN 100 AND 1500);

ALTER TABLE EJEMPLAR_MARIPOSA DISABLE CONSTRAINT ch_precio;

--ApartadoC
CREATE INDEX id_nombre_apellido ON PERSONA(nombre,apellidos);

CREATE INDEX id_fecha_captura ON EJEMPLAR_MARIPOSA(fecha_captura);

--ApartadoD no funciona
CREATE USER usuario1 IDENTIFIED BY usuario1;
CREATE ROLE rol_usuario ;
GRANT CREATE SESSION TO Usuarios;
GRANT SELECT ON PERSONA,EJEMPLAR_MARIPOSA,COLECCION TO PUBLIC ;

CREATE ROLE Empleados NOT IDENTIFIED;
GRANT CREATE SESSION TO Empleados;
GRANT SELECT,INSERT,UPDATE ON PERSONA,EJEMPLAR_MARIPOSA,COLECCION, ZONA TO Empleados ;

CREATE ROLE Administrador NOT IDENTIFIED;
GRANT CREATE SESSION TO Usuarios;
GRANT SELECT ON PERSONA,EJEMPLAR_MARIPOSA,COLECCION TO PUBLIC ;

--ApartadoE
DROP ROLE Usuario;
DROP ROLE Empleados;
DROP ROLE Administrador;

DROP INDEX id_nombre_apellido;
DROP INDEX id_fecha_captura;

DROP TABLE COLECCION CASCADE CONSTRAINT;
DROP TABLE EJEMPLAR_MARIPOSA CASCADE CONSTRAINT;
DROP TABLE ESPECIE CASCADE CONSTRAINT;
DROP TABLE FAMILIA CASCADE CONSTRAINT;
DROP TABLE GENERO CASCADE CONSTRAINT;
DROP TABLE PERSONA CASCADE CONSTRAINT;
DROP TABLE ZONA CASCADE CONSTRAINT;



