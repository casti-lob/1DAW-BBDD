alter session set "_oracle_script"=true;  
create user TiendaDml identified by TiendaDml;
GRANT CONNECT, RESOURCE, DBA TO TiendaDml;
	
CREATE TABLE FABRICANTE
	(codigo			NUMBER(10),
	nombre			VARCHAR(100),
	CONSTRAINT pk_fabricante PRIMARY KEY(codigo)
	);
	
CREATE TABLE PRODUCTO
	(codigo 		NUMBER(10),
	nombre			VARCHAR(100),
	precio			NUMBER(10,2),
	codigo_fabricante	NUMBER(10),
	CONSTRAINT pk_producto PRIMARY KEY (codigo),
	CONSTRAINT fk_producto_fabricante FOREIGN KEY(codigo_fabricante) REFERENCES FABRICANTE(codigo)
	);
	
--Insert tabla fabricante

INSERT INTO FABRICANTE
VALUES (1,'Asus');

INSERT INTO FABRICANTE
VALUES (2,'Lenovo');

INSERT INTO FABRICANTE
VALUES (3,'Hewlett-Packard');

INSERT INTO FABRICANTE
VALUES (4,'Samsung');

INSERT INTO FABRICANTE
VALUES (5,'Seagate');

INSERT INTO FABRICANTE
VALUES (6,'Crucial');

INSERT INTO FABRICANTE
VALUES (7,'Gigabyte');

INSERT INTO FABRICANTE
VALUES (8,'Huawei');

INSERT INTO FABRICANTE
VALUES (9,'Xiaomi');

--Insert tabla producto

INSERT INTO PRODUCTO
VALUES (1, 'Disco duro SATA3 1TB', 86.99, 5);

INSERT INTO PRODUCTO
VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);

INSERT INTO PRODUCTO
VALUES(3, 'Disco SSD 1 TB', 150.99, 4);

INSERT INTO PRODUCTO
VALUES(4, 'GeForce GTX 1050Ti', 185, 7);

INSERT INTO PRODUCTO
VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);

INSERT INTO PRODUCTO
VALUES(6, 'Monitor 24 LED Full HD', 202, 1);

INSERT INTO PRODUCTO
VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);

INSERT INTO PRODUCTO
VALUES(8, 'Portátil Yoga 520', 559, 2);

INSERT INTO PRODUCTO
VALUES(9, 'Portátil Ideapd 320', 444, 2);

INSERT INTO PRODUCTO
VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);

INSERT INTO PRODUCTO
VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

--Requisitos adicionales
--1
INSERT INTO FABRICANTE
VALUES(10,'AMD');

--2 No se puede ya que requiere la primary key
INSERT INTO FABRICANTE(nombre)
VALUES('Paco');

--3
INSERT INTO PRODUCTO(codigo,nombre,precio,codigo_fabricante)
VALUES(12,'Procesador',240,10);

--4 No se puede ya que se requiere de la primary key
INSERT INTO PRODUCTO(nombre,precio,codigo_fabricante)
VALUES('Paco',500,10);

--5 Para que no pierda integridad hay que realizar lo siguiente
ALTER TABLE PRODUCTO DROP CONSTRAINT fk_producto_fabricante;
ALTER TABLE PRODUCTO ADD CONSTRAINT fk_producto_fabricante FOREIGN KEY(codigo_fabricante) REFERENCES FABRICANTE(codigo) ON UPDATE CASCADE  ;

DELETE FABRICANTE
WHERE codigo=1;

--6
DELETE FABRICANTE
WHERE codigo=9;

--7 no se preguntar
UPDATE Fabricante
SET codigo= 20
WHERE codigo=2; 

UPDATE PRODUCTO
SET codigo_fabricante =20
WHERE codigo_fabricante =2;




--8 
UPDATE Fabricante
SET codigo= 30
WHERE codigo=8;


--9
UPDATE PRODUCTO
SET precio = precio+5;

DELETE PRODUCTO
WHERE nombre= upper('%IMPRESORA%') AND precio <200;





