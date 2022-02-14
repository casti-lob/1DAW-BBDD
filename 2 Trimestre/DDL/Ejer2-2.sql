alter session set "_oracle_script"=true;  
create user ddlEjr2_2 identified by ddlEjr2_2;
GRANT CONNECT, RESOURCE, DBA TO ddlEjr2_2;

CREATE TABLE EQUIPO
	(codEquipo					VARCHAR2(4),
	nombre						VARCHAR2(30) NOT NULL,
	localidad					VARCHAR2(15),
	CONSTRAINT pkEquipo	PRIMARY KEY (codEquipo)
	);
	
CREATE TABLE JUGADOR
	(codJugador					VARCHAR2(4),
	nombre						VARCHAR2(30) NOT NULL,
	fechaNacimiento				DATE,
	demarcacion					VARCHAR2(10),
	codEquipo					VARCHAR2(4),
	CONSTRAINT PKjugador PRIMARY KEY (codJugador),
	CONSTRAINT FKjugador_equipo FOREIGN KEY (codEquipo) REFERENCES EQUIPO (codEquipo),
	CONSTRAINT ck_demarcacion CHECK(demarcacion = 'Portero' OR demarcacion ='Defensa' OR demarcacion ='Medio' OR demarcacion = 'Delanteros')
	);
	
CREATE TABLE PARTIDO
	(codPartido					VARCHAR2(4),
	codEquipoLocal				VARCHAR2(4),
	codEquipoVisitante			VARCHAR2(4),
	fecha						DATE,
	competicion					VARCHAR2(4),
	jornada						VARCHAR2(20),
	CONSTRAINT PK_partido PRIMARY KEY (codPartido),
	CONSTRAINT fk_partido_equipoL FOREIGN KEY (codEquipoLocal) REFERENCES EQUIPO(codEquipo),
	CONSTRAINT fk_partido_equipoV FOREIGN KEY (codEquipoVisitante) REFERENCES EQUIPO(codEquipo),
	CONSTRAINT ck_fecha CHECK(EXTRACT(MONTH FROM fecha) !=7 AND EXTRACT(MONTH FROM fecha) !=8),
	CONSTRAINT ck_competicion CHECK(competicion ='Copa' OR competicion='Liga')
	
	);
CREATE TABLE INCIDENCIA
	( numIncidencia				VARCHAR2(6),
	codPartido					VARCHAR2(4),
	codJugador					VARCHAR2(4),
	minuto						NUMBER(2),
	tipo 						VARCHAR2(20) NOT NULL,
	CONSTRAINT pk_incidencia PRIMARY KEY (numIncidencia),
	CONSTRAINT fk_incidencia_partido FOREIGN KEY(codPartido) REFERENCES PARTIDO(codPartido),
	CONSTRAINT fk_incidencia_jugador FOREIGN KEY (codJugador) REFERENCES JUGADOR(codJugador),
	CONSTRAINT ch_minuto CHECK(minuto BETWEEN 1 AND 99)
	
	);

ALTER TABLE EQUIPO ADD golesMarcador NUMBER(3);

ALTER TABLE jugador ADD CONSTRAINT ck_jugador CHECK (INITCAP(nombre)=nombre);
ALTER TABLE equipo ADD CONSTRAINT ck_nombre CHECK (regexp_like(nombre'^[0-9]{1}'));
--modify para modificar una columna

SELECT * FROM dictionary

SELECT * FROM USER_CONSTRAINTS 


