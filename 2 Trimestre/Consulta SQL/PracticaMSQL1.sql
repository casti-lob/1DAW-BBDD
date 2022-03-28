CREATE TABLE DEPART
	(dept_no integer(5),
	dnombre varchar(100),
	loc varchar(100),
	CONSTRAINT pk_depart PRIMARY KEY (dept_no)
	);
	
CREATE TABLE EMPLE
	(emp_no	integer(8),
	apellido varchar(100),
	oficio varchar(100),
	dir integer(8),
	fecha_alt date,
	salario integer(9),
	comision integer(9),
	dept_no integer(5),
	CONSTRAINT pk_emple PRIMARY KEY(emp_no),
	CONSTRAINT fk_emple FOREIGN KEY(dept_no) references DEPART(dept_no)
	);
	
insert into DEPART 
values(10,'CONTABILIDAD','SEVILLA');

insert into DEPART 
values(20,'INVESTIGACIÓN','MADRID');

insert into DEPART 
values(30,'VENTAS','BARCELONA');

insert into DEPART 
values(40,'PRODUCCIÓN','BILBAO');

INSERT into EMPLE 
VALUES(7369,'SÁNCHEZ','EMPLEADO',7902,'1980-12-17',104000,NULL,20);
INSERT into EMPLE 
VALUES(7499,'ARROYO','VENDEDOR',7998,'1980-02-20',208000,39000,30);
INSERT into EMPLE 
VALUES(7521,'SALA','VENDEDOR',7698,'1981-02-22',162500,162500,30);
INSERT into EMPLE 
VALUES(7369,'SÁNCHEZ','EMPLEADO',7902,'1980-12-17',104000,NULL,20);


















