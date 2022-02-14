alter session set "_oracle_script"=true;  
create user coches identified by coches;
GRANT CONNECT, RESOURCE, DBA TO coches;

CREATE TABLE VEHICULOS
	(matricula			VARCHAR2(7),
	marca				VARCHAR2(10) NOT NULL,
	modelo				VARCHAR2(10) NOT NULL,
	fecha_compra		DATE ,
	precio_por_dia		number(5,2) ,
	CONSTRAINT precio_dia CHECK (precio_por_dia>=0),
	CONSTRAINT fechaVehiculos CHECK(EXTRACT(YEAR FROM fecha_compra)>=2001),
	CONSTRAINT pk_vehiculos PRIMARY KEY(matricula)
	
	);
	
CREATE TABLE CLIENTES
	(dni 				VARCHAR2(9),
	nombre				VARCHAR2(30) NOT NULL,
	nacionalidad		VARCHAR2(30),
	fecha_nacimiento	DATE,
	direccion			VARCHAR2(50),
	CONSTRAINT pk_clientes PRIMARY KEY(dni)
	);
	
CREATE  TABLE ALQUILERES
	(matricula 			VARCHAR2(7) NOT NULL,
	dni					VARCHAR2(10) NOT NULL,
	fecha_hora			DATE,
	num_dias			NUMBER(2) NOT NULL,
	kilometros			NUMBER(4) DEFAULT 0,
	CONSTRAINT pk_alquileres PRIMARY KEY(fecha_hora,dni,matricula),
	CONSTRAINT fk_vehiculos FOREIGN KEY(matricula) REFERENCES VEHICULOS(matricula),
	CONSTRAINT fk_clientes FOREIGN KEY(dni) REFERENCES CLIENTES(dni)
	
	);



	

