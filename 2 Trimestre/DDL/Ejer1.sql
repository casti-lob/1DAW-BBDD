 

/* Comentario*/
CREATE TABLE tema 
	(cod_tema		NUMBER(4),
	denominacion 	VARCHAR2(50),
	cod_tema_padre	NUMBER(4),
	CONSTRAINT ck_cod_tema_padre CHECK (cod_tema_padre > cod_tema),
	CONSTRAINT PK_tema PRIMARY KEY (cod_tema)
	);
	
CREATE  TABLE EDITORIAL
	(cod_editorial		NUMBER(4),
	denominacion		VARCHAR2(50),
	CONSTRAINT pk_editorial PRIMARY KEY (cod_editorial)
	);
	
CREATE TABLE AUTOR
	(cod_autor			NUMBER(4),
	nombre				VARCHAR2(50),
	f_nacimiento		DATE,
	CONSTRAINT pk_autor PRIMARY KEY (cod_autor)
	);
	
CREATE TABLE LIBRO
	(cod_libro			NUMBER(4),
	titulo				VARCHAR2(50),
	f_creacion			DATE,
	cod_tema			NUMBER(4),
	autor_principal		NUMBER(4),
	CONSTRAINT pk_libro PRIMARY KEY (cod_libro),
	CONSTRAINT fk_libro_tema FOREIGN KEY (cod_tema) REFERENCES TEMA(cod_tema),
	CONSTRAINT fk_libro_autor FOREIGN KEY (autor_principal) REFERENCES AUTOR(cod_autor)
	);
	
CREATE TABLE LIBRO_AUTOR
	(cod_libro			NUMBER(4),
	cod_autor			NUMBER(4),
	orden				NUMBER(1),
	CONSTRAINT ck_orden CHECK(orden >=1 AND orden <=5),
	CONSTRAINT pk_libro_autor PRIMARY KEY (cod_libro, cod_autor),
	CONSTRAINT fk_libro_libro_autor FOREIGN KEY (cod_libro) REFERENCES LIBRO (cod_libro),
	CONSTRAINT fk_autor_libro_autor FOREIGN KEY (cod_autor) REFERENCES AUTOR (cod_autor)
	);
	
CREATE TABLE PUBLICACIONES
	(cod_editorial		NUMBER(4),
	cod_libro			NUMBER(4),
	precio				NUMBER(4,2) NOT NULL,
	f_publicacion		DATE DEFAULT SYSDATE,
	CONSTRAINT ck_precio CHECK(precio>0),
	CONSTRAINT pk_publicaciones PRIMARY KEY (cod_editorial,cod_libro),
	CONSTRAINT fk_libro_publicaciones FOREIGN KEY (cod_libro) REFERENCES LIBRO (cod_libro),
	CONSTRAINT fk_editorial_publicaciones FOREIGN KEY (cod_editorial) REFERENCES EDITORIAL(cod_editorial) ON DELETE CASCADE
	);
	
ALTER TABLE TEMA
ADD (CONSTRAINT fk_tema_tema FOREIGN KEY(cod_tema_padre)REFERENCES TEMA (cod_tema)ON DELETE CASCADE);

ALTER TABLE AUTOR
ADD
( libro_principal 		NUMBER(4),
CONSTRAINT fk_autor_libro FOREIGN KEY(libro_principal) REFERENCES LIBRO(cod_libro));
-- Si se pueden crear el mismo libro ya que no tiene una fk de codigo de libro--
-- Deberiamos crear un ALTER TABLE EDITORIAL ADD(CONSTRAINT fk_editorial_libro FOREIGN KEY(cod_libro) REFERENCES LIBRO(cod_libro));--
DROP TABLE TEMA CASCADE CONSTRAINTS;
DROP TABLE EDITORIAL CASCADE CONSTRAINTS;
DROP TABLE AUTOR CASCADE CONSTRAINTS;
DROP TABLE LIBRO CASCADE CONSTRAINTS;
DROP TABLE LIBRO_AUTOR CASCADE CONSTRAINTS;
DROP TABLE PUBLICACIONES CASCADE CONSTRAINTS;




