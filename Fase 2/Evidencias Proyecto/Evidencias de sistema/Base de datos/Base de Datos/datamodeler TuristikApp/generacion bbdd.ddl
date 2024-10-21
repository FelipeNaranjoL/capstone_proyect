-- Generado por Oracle SQL Developer Data Modeler 20.4.1.406.0906
--   en:        2024-10-06 03:04:33 CLST
--   sitio:      Oracle Database 21c
--   tipo:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE accesoqr (
    accesoqrid      INTEGER NOT NULL,
    fechaacceso     DATE NOT NULL,
    estadoaccesoqr  VARCHAR2(20) NOT NULL,
    usuariofk       NUMBER NOT NULL
);

ALTER TABLE accesoqr ADD CONSTRAINT accesoqr_pk PRIMARY KEY ( accesoqrid );

CREATE TABLE contenidositio (
    contenidoid       INTEGER NOT NULL,
    contenido         VARCHAR2(255) NOT NULL,
    sitioturisticofk  VARCHAR2(100) NOT NULL,
    encabezado        VARCHAR2(100) NOT NULL,
    masdetalle        VARCHAR2(255) NOT NULL
);

ALTER TABLE contenidositio ADD CONSTRAINT contenidositio_pk PRIMARY KEY ( contenidoid );

CREATE TABLE criterioevaluacion (
    criterioid     INTEGER NOT NULL,
    amabilidad     VARCHAR2(10) NOT NULL,
    camino         VARCHAR2(10) NOT NULL,
    costo          VARCHAR2(10) NOT NULL,
    recomendacion  VARCHAR2(10) NOT NULL,
    satisfaccion   INTEGER NOT NULL,
    transporte     VARCHAR2(10) NOT NULL,
    opinion        VARCHAR2(255) NOT NULL,
    evaluacionfk   VARCHAR2(100) NOT NULL
);

ALTER TABLE criterioevaluacion ADD CONSTRAINT criterioevaluacion_pk PRIMARY KEY ( criterioid );

CREATE TABLE evaluacion (
    evaluacionid       VARCHAR2(100) NOT NULL,
    evaluacion_id      NUMBER NOT NULL,
    sitioturisticoid   NUMBER,
    usuario_usuarioid  INTEGER NOT NULL
);

ALTER TABLE evaluacion ADD CONSTRAINT evaluacion_pkv1 PRIMARY KEY ( evaluacionid );

ALTER TABLE evaluacion ADD CONSTRAINT evaluacion_pk UNIQUE ( evaluacion_id );

CREATE TABLE imagensitio (
    imagensitioturistico_id  NUMBER NOT NULL,
    imagenid                 INTEGER NOT NULL,
    urlimagen                VARCHAR2(255) NOT NULL,
    ordenimagen              INTEGER NOT NULL,
    sitioturisticoid         NUMBER NOT NULL
);

ALTER TABLE imagensitio ADD CONSTRAINT imagensitio_pk PRIMARY KEY ( imagenid );

ALTER TABLE imagensitio ADD CONSTRAINT imagensitioturistico_pk UNIQUE ( imagensitioturistico_id );

CREATE TABLE sitioturistico (
    sitioturisticoid           VARCHAR2(100) NOT NULL,
    nombresitioturistico       VARCHAR2(150) NOT NULL,
    ubicacionsitioturistico    VARCHAR2(150) NOT NULL,
    descripcionsitioturistico  VARCHAR2(150) NOT NULL,
    sitioturistico_id          NUMBER NOT NULL
);

ALTER TABLE sitioturistico ADD CONSTRAINT sitioturistico_pkv1 PRIMARY KEY ( sitioturisticoid );

ALTER TABLE sitioturistico ADD CONSTRAINT sitioturistico_pk UNIQUE ( sitioturistico_id );

CREATE TABLE tour (
    tourid              INTEGER NOT NULL,
    nombretour          VARCHAR2(100) NOT NULL,
    descripciontour     CLOB,
    preciotour          INTEGER NOT NULL,
    duraciontour        INTEGER,
    disponibilidadtour  VARCHAR2(25) NOT NULL,
    sitioturisticofk    NUMBER NOT NULL,
    evaluacionfk        VARCHAR2(100) NOT NULL
);

ALTER TABLE tour ADD CONSTRAINT tour_pk PRIMARY KEY ( tourid );

CREATE TABLE usuario (
    usuarioid                INTEGER NOT NULL,
    nombreusuario            VARCHAR2(50) NOT NULL,
    apellidousuario          VARCHAR2(50) NOT NULL,
    correousuario            VARCHAR2(100) NOT NULL,
    idiomausuario            VARCHAR2(50) NOT NULL,
    tipodiscapacidadusuario  VARCHAR2(50),
    fecharegistro            DATE NOT NULL,
    contraseñausuario        VARCHAR2(250) NOT NULL,
    direccionusuario         VARCHAR2(255),
    telefonousuario          VARCHAR2(20) NOT NULL,
    permisousuario           NUMBER NOT NULL,
    usuario_id               NUMBER NOT NULL
);

ALTER TABLE usuario ADD CONSTRAINT usuario_pkv1 PRIMARY KEY ( usuarioid );

ALTER TABLE usuario ADD CONSTRAINT usuario_pk UNIQUE ( usuario_id );

ALTER TABLE accesoqr
    ADD CONSTRAINT accesoqr_usuario_fk FOREIGN KEY ( usuariofk )
        REFERENCES usuario ( usuario_id );

ALTER TABLE contenidositio
    ADD CONSTRAINT contenidos_sitioturistico_fk FOREIGN KEY ( sitioturisticofk )
        REFERENCES sitioturistico ( sitioturisticoid );

ALTER TABLE criterioevaluacion
    ADD CONSTRAINT criterioe_evaluacion_fk FOREIGN KEY ( evaluacionfk )
        REFERENCES evaluacion ( evaluacionid );

ALTER TABLE evaluacion
    ADD CONSTRAINT evaluacion_sitioturistico_fk FOREIGN KEY ( sitioturisticoid )
        REFERENCES sitioturistico ( sitioturistico_id );

ALTER TABLE evaluacion
    ADD CONSTRAINT evaluacion_usuario_fk FOREIGN KEY ( usuario_usuarioid )
        REFERENCES usuario ( usuarioid );

ALTER TABLE imagensitio
    ADD CONSTRAINT imagensitio_sitioturistico_fk FOREIGN KEY ( sitioturisticoid )
        REFERENCES sitioturistico ( sitioturistico_id );

ALTER TABLE tour
    ADD CONSTRAINT tour_evaluacion_fk FOREIGN KEY ( evaluacionfk )
        REFERENCES evaluacion ( evaluacionid );

ALTER TABLE tour
    ADD CONSTRAINT tour_sitioturistico_fk FOREIGN KEY ( sitioturisticofk )
        REFERENCES sitioturistico ( sitioturistico_id );

CREATE SEQUENCE evaluacion_evaluacion_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER evaluacion_evaluacion_id_trg BEFORE
    INSERT ON evaluacion
    FOR EACH ROW
    WHEN ( new.evaluacion_id IS NULL )
BEGIN
    :new.evaluacion_id := evaluacion_evaluacion_id_seq.nextval;
END;
/

CREATE SEQUENCE imagensitio_imagensitioturisti START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER imagensitio_imagensitioturisti BEFORE
    INSERT ON imagensitio
    FOR EACH ROW
    WHEN ( new.imagensitioturistico_id IS NULL )
BEGIN
    :new.imagensitioturistico_id := imagensitio_imagensitioturisti.nextval;
END;
/

CREATE SEQUENCE sitioturistico_sitioturistico_ START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER sitioturistico_sitioturistico_ BEFORE
    INSERT ON sitioturistico
    FOR EACH ROW
    WHEN ( new.sitioturistico_id IS NULL )
BEGIN
    :new.sitioturistico_id := sitioturistico_sitioturistico_.nextval;
END;
/

CREATE SEQUENCE usuario_usuario_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER usuario_usuario_id_trg BEFORE
    INSERT ON usuario
    FOR EACH ROW
    WHEN ( new.usuario_id IS NULL )
BEGIN
    :new.usuario_id := usuario_usuario_id_seq.nextval;
END;
/



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             8
-- CREATE INDEX                             0
-- ALTER TABLE                             20
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           4
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          4
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
