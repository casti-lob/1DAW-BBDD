alter session set "_oracle_script"=true;  
create user castillejoJoseAntonioEje1 identified by castillejoJoseAntonioEje1;
GRANT CONNECT, RESOURCE, DBA TO castillejoJoseAntonioEje1;

CREATE TABLE T_ESTRACTO
	(estrato				NUMBER(5),
	descripcion				VARCHAR2(50),
	totalusuarios			NUMBER(5) DEFAULT 0,
	CONSTRAINT pk_t_estracto PRIMARY KEY (estrato),
	CONSTRAINT ch_estrato CHECK(estrato>39),
	CONSTRAINT ch_totalusuario CHECK(totalusuarios>0)
	);

CREATE TABLE T_CARGOS
	(idcargo				VARCHAR2(2),
	descripcioncargo		VARCHAR2(50),
	CONSTRAINT pk_cargos PRIMARY KEY(idcargo),
	CONSTRAINT ch_idcargo CHECK(idcargo IN ('FC','RC','RF','CO'))
	);

CREATE TABLE T_SERVICIOS
	(servicio 				VARCHAR2(3),
	nservicio				NUMBER(4),
	descripcionservicio		VARCHAR2(200)NOT NULL,
	cupousuarios			NUMBER(6),
	nusuarios				NUMBER(10) DEFAULT 0,
	testrato				NUMBER(5),
	importefijo				NUMBER(8,2),
	valorconsumo			NUMBER(10,2),
	CONSTRAINT pk_servicios PRIMARY KEY (servicio, nservicio),
	CONSTRAINT fk_servicio_testrato FOREIGN KEY(testrato) REFERENCES T_ESTRACTO(estrato),
	CONSTRAINT ch_nusuarios CHECK(nusuarios >=0)
	);

CREATE TABLE T_MOVIMIENTOS
	(id_cliente				NUMBER(5),
	fechaimporte			DATE DEFAULT SYSDATE,
	fechamovimiento			DATE,
	cargo_aplicado			VARCHAR2(2),
	servicio				VARCHAR2(3),
	nservicio				NUMBER(4),
	consumo					NUMBER(10,2)NOT NULL,
	importafac				NUMBER(10,2)NOT NULL,
	importerec				NUMBER(10,2)NOT NULL,
	impmorterefa			NUMBER(10,2)NOT NULL,
	importeconv				NUMBER(10,2)NOT NULL,
	CONSTRAINT pk_movimientos PRIMARY KEY(id_cliente),
	CONSTRAINT fk_movimientos_cargo FOREIGN KEY(cargo_aplicado)REFERENCES T_CARGOS(idcargo),
	CONSTRAINT fk_movimientos_servi FOREIGN KEY(servicio,nservicio)REFERENCES T_SERVICIOS(servicio,nservicio)
	);

CREATE TABLE T_MAESTRO
	(suscripcion			NUMBER(5),
	alta					DATE,
	nombre					VARCHAR2(20)NOT NULL,
	direccion				VARCHAR2(20),
	barrio					VARCHAR2(16),
	saldoactual				NUMBER(10,2),
	estrato					NUMBER(5),
	mail					VARCHAR2(80) UNIQUE,
	fechaalta				DATE DEFAULT SYSDATE,
	CONSTRAINT pk_maestro PRIMARY KEY(suscripcion),
	CONSTRAINT fk_maestro_suscripcion FOREIGN KEY(suscripcion) REFERENCES T_MOVIMIENTOS(id_cliente),
	CONSTRAINT fk_maestro_estrato FOREIGN KEY(estrato) REFERENCES T_ESTRACTO (estrato),
	CONSTRAINT ch_fechaalta CHECK(TO_CHAR(fechaalta, 'dd/mm/yyyy')>'01/01/1990')
	);

ALTER TABLE T_MAESTRO ADD dni	VARCHAR2(10) UNIQUE;
ALTER TABLE T_MAESTRO DROP COLUMN BARRIO;
ALTER TABLE T_ESTRACTO MODIFY descripcion VARCHAR2(10);
/*
DROP TABLE T_MAESTRO;
DROP TABLE T_ESTRACTO CASCADE CONSTRAINT;
DROP TABLE T_CARGOS;
DROP TABLE T_SERVICIOS CASCADE CONSTRAINT;
DROP TABLE T_MOVIMIENTOS ;
*/
	