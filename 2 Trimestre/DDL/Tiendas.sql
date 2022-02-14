alter session set "_oracle_script"=true;  
create user tiendas identified by tiendas;
GRANT CONNECT, RESOURCE, DBA TO tiendas;

CREATE TABLE TIENDAS
	(nif				VARCHAR2(10),
	nombre				VARCHAR2(20),
	direccion			VARCHAR2(20),
	poblacion			VARCHAR2(20),
	provincia			VARCHAR2(20),
	codpostal			NUMBER(5),
	CONSTRAINT pk_tiendas PRIMARY KEY(nif),
	CONSTRAINT ch_provincia CHECK(provincia = UPPER(PROVINCIA))
	);

CREATE TABLE FABRICANTES
	(cod_fabricante		NUMBER(3),
	nombre				VARCHAR2(15),
	pais				VARCHAR2(15),
	CONSTRAINT pk_fabricantes PRIMARY KEY (cod_fabricante),
	CONSTRAINT ch_nombre CHECK(nombre=UPPER(nombre)),
	CONSTRAINT ch_pais CHECK(pais=UPPER(pais))
	);

CREATE TABLE ARTICULOS
	(articulo			VARCHAR2(20),
	cod_fabricante		NUMBER(3),
	peso				NUMBER(3),
	categoria			VARCHAR2(10),
	precio_venta		NUMBER(4,2),
	precio_costo		NUMBER(4,2),
	existencias			NUMBER (5),
	CONSTRAINT pk_articulos PRIMARY KEY (articulo,cod_fabricante,peso,categoria),
	CONSTRAINT fk_articulos_cod_fabr FOREIGN KEY (cod_fabricante) REFERENCES FABRICANTES(cod_fabricante),
	CONSTRAINT ch_precio_venta CHECK(precio_venta >0),
	CONSTRAINT ch_precio_costo CHECK(precio_costo>0),
	CONSTRAINT ch_peso CHECK(peso>0)
	);

CREATE TABLE PEDIDOS
	(nif				VARCHAR2(10),
	articulo			VARCHAR(20),
	cod_fabricante		NUMBER(3),
	peso				NUMBER(3),
	categoria			VARCHAR2(10),
	fecha_pedido		DATE,
	unidades_pedidias	NUMBER(4),
	CONSTRAINT pk_pedido PRIMARY KEY(nif, articulo,cod_fabricante,peso,categoria,fecha_pedido),
	CONSTRAINT fk_pedido_fabricante FOREIGN KEY(cod_fabricante) REFERENCES FABRICANTES(cod_fabricante) ON DELETE CASCADE,
	CONSTRAINT fk_pedido_pedidos_articulos FOREIGN KEY(articulo, cod_fabricante,peso,categoria) REFERENCES ARTICULOS(articulo, cod_fabricante,peso,categoria) ON DELETE CASCADE,
	CONSTRAINT fk_pedido_nif FOREIGN KEY(nif) REFERENCES TIENDAS (nif),
	CONSTRAINT ch_unidades_pedidas CHECK(unidades_pedidias >0)
	);

CREATE TABLE VENTAS
	(nif				VARCHAR2(10),
	articulo			VARCHAR2(20),
	cod_fabricante 		NUMBER(3),
	peso				NUMBER(3),
	categoria			VARCHAR2(10),
	fecha_venta			DATE DEFAULT SYSDATE,
	unidades_vendidas	NUMBER(4),
	CONSTRAINT pk_ventas PRIMARY KEY (nif,articulo,cod_fabricante,peso,categoria,fecha_venta),
	CONSTRAINT fk_ventas_fabricante FOREIGN KEY(cod_fabricante) REFERENCES FABRICANTES(cod_fabricante)ON DELETE CASCADE,
	CONSTRAINT fk_ventas_articulos FOREIGN KEY(articulo,cod_fabricante,peso,categoria) REFERENCES ARTICULOS(articulo,cod_fabricante,peso,categoria)ON DELETE CASCADE,
	CONSTRAINT ch_unidades_vendidas CHECK (unidades_vendidas>0),
	CONSTRAINT fk_ventas_nif FOREIGN KEY(nif) REFERENCES TIENDAS (nif)
	);

ALTER TABLE PEDIDOS MODIFY unidades_pedidias NUMBER(6);
ALTER TABLE VENTAS MODIFY unidades_vendidas NUMBER(6);
ALTER TABLE PEDIDOS ADD pvp NUMBER(6,2);
ALTER TABLE VENTAS ADD pvp NUMBER(6,2);
ALTER TABLE FABRICANTES DROP COLUMN pais;
ALTER TABLE VENTAS ADD CONSTRAINT ch_ud_vend CHECK(unidades_vendidas >=100);
ALTER TABLE VENTAS DROP CONSTRAINT ch_ud_vend;
/*
DROP TABLE ARTICULOS CASCADE CONSTRAINT;
DROP TABLE FABRICANTES CASCADE CONSTRAINT;
DROP TABLE PEDIDOS CASCADE CONSTRAINT;
DROP TABLE TIENDAS CASCADE CONSTRAINT;
DROP TABLE VENTAS CASCADE CONSTRAINT;
