alter session set "_oracle_script"=true;  
create user jardineria identified by jardineria;
GRANT CONNECT, RESOURCE, DBA TO jardineria;

CREATE TABLE GAMA_PRODUCTO 
	(gama		VARCHAR2(50),
	descripcion_texto	VARCHAR(200),
	descripcion_html	VARCHAR2(200),
	imagen		VARCHAR2(256),
	CONSTRAINT pk_GAMA_PRODUCTO PRIMARY KEY (gama)
	);
	
CREATE TABLE PRODUCTO
	(codigo_producto	VARCHAR2(15),
	nombre	VARCHAR2(70),
	gama	VARCHAR2(50),
	dimensiones	VARCHAR2(25),
	proveedor	VARCHAR2(50),
	descripcion	VARCHAR2(200),
	cantidad_en_stock	NUMBER(6),
	precio_venta	NUMBER(15,2),
	precio_proveedor	NUMBER(15,2),
	CONSTRAINT pk_producto PRIMARY KEY (codigo_producto),
	CONSTRAINT fk_producto_gama FOREIGN KEY (gama) REFERENCES GAMA_PRODUCTO (gama)
	);
	
CREATE TABLE OFICINA
	(codigo_oficina 	VARCHAR2(10),
	ciudad 		VARCHAR2(30),
	pais 		VARCHAR2(50),
	region		VARCHAR2(50),
	codigo_postal		VARCHAR2(10),
	telefono		VARCHAR2(20),
	linea_direccion1		VARCHAR2(50),
	linea_direccion2		VARCHAR2(50),
	CONSTRAINT pk_oficina PRIMARY KEY (codigo_oficina)
	);

CREATE TABLE EMPLEADO
	(codigo_empleado		NUMBER(11),
	nombre		VARCHAR2(50),
	apellido1		VARCHAR2(50),
	apellido2		VARCHAR2(50),
	extension		VARCHAR2(10),
	email		VARCHAR2(100),
	codigo_oficina		VARCHAR2(10),
	codigo_jefe		NUMBER(11),
	puesto		VARCHAR2(50),
	CONSTRAINT pk_empleado PRIMARY KEY (codigo_empleado),
	CONSTRAINT fk_empleado_codigo_oficina FOREIGN KEY (codigo_oficina) REFERENCES OFICINA (codigo_oficina),
	CONSTRAINT fk_empleado_codigo_jefe FOREIGN KEY (codigo_jefe) REFERENCES EMPLEADO (codigo_empleado)
	);
	
CREATE TABLE CLIENTE 
	(codigo_cliente		NUMBER(11),
	nombre_cliente		VARCHAR2(50),
	nombre_contacto		VARCHAR2(30),
	apellido_contacto		VARCHAR2(30),
	telefono		VARCHAR2(15),
	fax		VARCHAR2(15),
	linea_direccion1		VARCHAR2(50),
	linea_direccion2		VARCHAR2(50),
	ciudad		VARCHAR2(50),
	region		VARCHAR2(50),
	pais		VARCHAR2(50),
	codigo_postal		VARCHAR2(10),
	codigo_empleado_rep_ventas		NUMBER(11),
	limite_credito		NUMBER(15,2),
	CONSTRAINT pk_cliente PRIMARY KEY (codigo_cliente),
	CONSTRAINT fk_cliente_cod_empl FOREIGN KEY (codigo_empleado_rep_ventas) REFERENCES EMPLEADO (codigo_empleado)
	);

CREATE TABLE PAGO 
	(codigo_cliente		NUMBER(11),
	forma_pago		VARCHAR2(40),
	id_transaccion		VARCHAR2(50),
	fecha_pago		DATE,
	total		NUMBER(15,2),
	CONSTRAINT pk_pago PRIMARY KEY (id_transaccion),
	CONSTRAINT fk_pago_cod_cliente FOREIGN KEY (codigo_cliente) REFERENCES CLIENTE (codigo_cliente)
	);

CREATE TABLE PEDIDO
	(codigo_pedido		NUMBER(11),
	fecha_pedido		DATE,
	fecha_esperada		DATE,
	fecha_entrega		DATE,
	estado		VARCHAR2(15),
	comentarios		VARCHAR2(200),
	codigo_cliente		NUMBER(11),
	CONSTRAINT pk_pedido PRIMARY KEY (codigo_pedido),
	CONSTRAINT fk_pedido_cod_cliente FOREIGN KEY (codigo_cliente) REFERENCES CLIENTE (codigo_cliente)
	);

CREATE TABLE DETALLE_PEDIDO 
	(codigo_pedido		NUMBER(11),
	codigo_producto		VARCHAR2(15),
	cantidad		NUMBER(11),
	precio_unidad		NUMBER(15,2),
	numero_linea		NUMBER(6),
	CONSTRAINT pk_detalle_pedido PRIMARY KEY (codigo_pedido,codigo_producto),
	CONSTRAINT fk_detalle_pedido_cod_pedido FOREIGN KEY(codigo_pedido) REFERENCES PEDIDO (codigo_pedido),
	CONSTRAINT fk_detalle_pedido_cod_producto FOREIGN KEY (codigo_producto) REFERENCES PRODUCTO (codigo_producto)
	);





