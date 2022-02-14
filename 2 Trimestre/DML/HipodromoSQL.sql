

CREATE TABLE CABALLOS
	(cod_caballo		VARCHAR2(4),
	nombre			VARCHAR(20) NOT NULL,
	peso			NUMBER(3),
	fecha_nacimiento	DATETIME,
	propietario			VARCHAR(25),
	nacionalidad		VARCHAR(20),
	CONSTRAINT pk_caballos PRIMARY KEY(cod_caballo),
	CONSTRAINT ch_peso CHECK(peso BETWEEN 240 AND 300),
	CONSTRAINT ch_fecha CHECK(YEAR(fecha_nacimiento>'2000')),
	CONSTRAINT ch_nacionalidad CHECK(nacionalidad= UPPER(nacionalidad))
	);
CREATE TABLE CARRERAS
	(cod_carrera		VARCHAR(4),
	fecha_hora			DATETIME,
	importe_premio		NUMBER(6),
	apuesta_limite		NUMBER(5,2),
	CONSTRAINT pk_carrera PRIMARY KEY(cod_carrera),
	CONSTRAINT ch_hora CHECK(TIME(fecha_hora>'09:00:00') AND TIME(fecha_hora<='14:30')),
	CONSTRAINT ch_apuesta_limite CHECK(apuesta_limite<2000)
	);
CREATE TABLE PARTICIPACIONES
	(cod_caballo		VARCHAR(4),
	cod_carrera			VARCHAR(4),
	dorsal				NUMBER(2)NOT NULL,
	jockey				VARCHAR(10)NOT NULL,
	posicionFinal		NUMBER(2),
	CONSTRAINT pk_participaciones PRIMARY KEY(cod_caballo,cod_carrera),
	CONSTRAINT fk_participaciones_caballo FOREIGN KEY(cod_caballo)REFERENCES CABALLOS(cod_caballo),
	CONSTRAINT fk_participacioness_carrera FOREIGN KEY(cod_carrera)REFERENCES CARRERAS(cod_carrera),
	CONSTRAINT ch_posicion_final CHECK(posicionFinal>0)
	);
CREATE TABLE CLIENTES 
	(dni		VARCHAR(10),
	nombre		VARCHAR(20),
	nacionalidad	VARCHAR(20),
	CONSTRAINT pk_clientes PRIMARY KEY(dni),
	CONSTRAINT ch_nacionalidad_cliente CHECK(nacionalidad=UPPER(nacionalidad))
	);

CREATE TABLE APUESTAS
	(dni_cliente VARCHAR(10),
	cod_caballo	VARCHAR(4),
	cod_carrera	VARCHAR(4),
	importe		NUMBER(6) DEFAULT 300 NOT NULL,
	tantoporuno	NUMBER(4,2),
	CONSTRAINT pk_apuestas PRIMARY KEY(dni_cliente,cod_caballo,cod_carrera),
	CONSTRAINT fk_apuestas_clientes FOREIGN KEY(dni_cliente) REFERENCES CLIENTES(dni) ON DELETE CASCADE,
	CONSTRAINT fk_apuestas_caballo FOREIGN KEY(cod_caballo) REFERENCES CABALLOS(cod_caballo) ON DELETE CASCADE,
	CONSTRAINT fk_apuestas_carrera FOREIGN KEY(cod_carrera) REFERENCES CARRERAS(cod_carrera) ON DELETE CASCADE,
	CONSTRAINT ch_tantoporuno CHECK(tantoporuno>1)
	);

--2
INSERT INTO CLIENTES(dni,nacionalidad)
VALUES('28821641L','ESCOCES');

INSERT INTO CABALLOS(cod_caballo,peso,nombre)
VALUES ('EEE4',300,'Titan');

INSERT INTO CARRERAS(cod_carrera,fecha_hora,importe_premio)
VALUES('aab',DATETIME('01-06-2000 10:15:00'));

INSERT INTO APUESTAS(dni_cliente,cod_caballo,cod_carrera,tantoporuno)
values('28821641L','EEE4','aab',30.1);

--3
INSERT INTO CABALLOS(cod_caballo,nombre)
VALUES ('EEE5','Segundon');

INSERT INTO CABALLOS(cod_caballo,nombre)
VALUES ('EEE6','Ganador');

INSERT INTO PARTICIPACIONES(cod_caballo,cod_carrera,dorsal,jockey)
VALUES('EEE5','aab',12,'Lucas');

INSERT INTO PARTICIPACIONES(cod_caballo,cod_carrera,dorsal,jockey)
VALUES('EEE6','aab',1,'Manuel');

--4
INSERT INTO CARRERAS(cod_carrera,importe_premio,apuesta_limite)
VALUES('aa2',2500,200);

INSERT INTO CARRERAS(cod_carrera,importe_premio,apuesta_limite)
VALUES('aa3',5000,300);

--5
ALTER TABLE CABALLOS DROP COLUMN propietario;

--6
ALTER TABLE PARTICIPACIONES ADD CONSTRAINT ch_jockey CHECK(jockey= initcap(jockey));

ALTER TABLE CARRERAS ADD CONSTRAINT ch_fecha CHECK(date(fecha_hora >'10-03-2000') AND date(fecha_hora> '10-11-2000'));

ALTER TABLE CABALLOS ADD CONSTRAINT ch_nacionalidad2 CHECK(nacionalidad IN('ESPAÑOLA','BRITANICA','ARABE'));

--6 EN LA TABLA CARRERAS NO HAY CABALLOS
DELETE FROM CARRERAS
WHERE 

--7 La tabla debe de estar vacia para poder agregar not null 
DELETE FROM CLIENTES;
ALTER TABLE CLIENTES ADD cod VARCHAR(4) UNIQUE NOT NULL;

--8
UPDATE PARTICIPACIONES
SET cod_carrera='C66'
WHERE cod_carrera='aab';

UPDATE CARRERAS
SET cod_carrera='C66'
WHERE cod_carrera='aab';

--9
ALTER TABLE APUESTAS ADD premio NUMBER(6,2);

--10
DROP TABLE APUESTAS CASCADE CONSTRAINT;
DROP TABLE CABALLOS CASCADE CONSTRAINT;
DROP TABLE CARRERAS CASCADE CONSTRAINT;
DROP TABLE CLIENTES CASCADE CONSTRAINT;
DROP TABLE PARTICIPACIONES CASCADE CONSTRAINT;





