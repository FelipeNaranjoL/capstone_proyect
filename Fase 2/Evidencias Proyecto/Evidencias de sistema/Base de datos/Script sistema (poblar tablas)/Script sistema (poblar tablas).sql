-- Primero eliminamos las Foreign Keys

-- Elimina las Foreign Keys de accesoqr
IF OBJECT_ID('fk_accesoqr_usuario', 'F') IS NOT NULL
    ALTER TABLE accesoqr DROP CONSTRAINT fk_accesoqr_usuario;

-- Elimina las Foreign Keys de contenidositio
IF OBJECT_ID('fk_contenidositio_sitioturistico', 'F') IS NOT NULL
    ALTER TABLE contenidositio DROP CONSTRAINT fk_contenidositio_sitioturistico;

-- Elimina las Foreign Keys de criterioevaluacion
IF OBJECT_ID('fk_criterioevaluacion_evaluacion', 'F') IS NOT NULL
    ALTER TABLE criterioevaluacion DROP CONSTRAINT fk_criterioevaluacion_evaluacion;

-- Elimina las Foreign Keys de evaluacion
IF OBJECT_ID('fk_evaluacion_sitioturistico', 'F') IS NOT NULL
    ALTER TABLE evaluacion DROP CONSTRAINT fk_evaluacion_sitioturistico;
IF OBJECT_ID('fk_evaluacion_usuario', 'F') IS NOT NULL
    ALTER TABLE evaluacion DROP CONSTRAINT fk_evaluacion_usuario;

-- Elimina las Foreign Keys de imagensitio
IF OBJECT_ID('fk_imagensitio_sitioturistico', 'F') IS NOT NULL
    ALTER TABLE imagensitio DROP CONSTRAINT fk_imagensitio_sitioturistico;

-- Elimina las Foreign Keys de tour
IF OBJECT_ID('fk_tour_evaluacion', 'F') IS NOT NULL
    ALTER TABLE tour DROP CONSTRAINT fk_tour_evaluacion;
IF OBJECT_ID('fk_tour_sitioturistico', 'F') IS NOT NULL
    ALTER TABLE tour DROP CONSTRAINT fk_tour_sitioturistico;

-- Luego eliminamos las tablas en el orden correcto

IF OBJECT_ID('accesoqr', 'U') IS NOT NULL DROP TABLE accesoqr;
IF OBJECT_ID('contenidositio', 'U') IS NOT NULL DROP TABLE contenidositio;
IF OBJECT_ID('criterioevaluacion', 'U') IS NOT NULL DROP TABLE criterioevaluacion;
IF OBJECT_ID('evaluacion', 'U') IS NOT NULL DROP TABLE evaluacion;
IF OBJECT_ID('imagensitio', 'U') IS NOT NULL DROP TABLE imagensitio;
IF OBJECT_ID('sitioturistico', 'U') IS NOT NULL DROP TABLE sitioturistico;
IF OBJECT_ID('tour', 'U') IS NOT NULL DROP TABLE tour;
IF OBJECT_ID('usuario', 'U') IS NOT NULL DROP TABLE usuario;

CREATE TABLE accesoqr (
    accesoqrid      INT NOT NULL PRIMARY KEY,
    fechaacceso     DATE NOT NULL,
    estadoaccesoqr  VARCHAR(20) NOT NULL,
    usuariofk       INT NOT NULL
);

CREATE TABLE contenidositio (
    contenidoid       INT NOT NULL PRIMARY KEY,
    contenido         VARCHAR(255) NOT NULL,
    sitioturisticofk  VARCHAR(100) NOT NULL,
    encabezado        VARCHAR(100) NOT NULL,
    masdetalle        VARCHAR(255) NOT NULL
);

CREATE TABLE criterioevaluacion (
    criterioid     INT NOT NULL PRIMARY KEY,
    amabilidad     VARCHAR(10) NOT NULL,
    camino         VARCHAR(10) NOT NULL,
    costo          VARCHAR(10) NOT NULL,
    recomendacion  VARCHAR(10) NOT NULL,
    satisfaccion   INT NOT NULL,
    transporte     VARCHAR(10) NOT NULL,
    opinion        VARCHAR(255) NOT NULL,
    evaluacionfk   VARCHAR(100) NOT NULL
);

CREATE TABLE evaluacion (
    evaluacionid       VARCHAR(100) NOT NULL PRIMARY KEY,
    evaluacion_id      INT NOT NULL UNIQUE,
    sitioturisticoid   INT,
    usuario_usuarioid  INT NOT NULL
);

CREATE TABLE imagensitio (
    imagensitioturistico_id  INT NOT NULL,
    imagenid                 INT NOT NULL PRIMARY KEY,
    urlimagen                VARCHAR(255) NOT NULL,
    ordenimagen              INT NOT NULL,
    sitioturisticoid         INT NOT NULL
);

CREATE TABLE sitioturistico (
    sitioturisticoid           VARCHAR(100) NOT NULL PRIMARY KEY,
    nombresitioturistico       VARCHAR(150) NOT NULL,
    ubicacionsitioturistico    VARCHAR(150) NOT NULL,
    descripcionsitioturistico  VARCHAR(150) NOT NULL,
    sitioturistico_id          INT NOT NULL UNIQUE
);

CREATE TABLE tour (
    tourid              INT NOT NULL PRIMARY KEY,
    nombretour          VARCHAR(100) NOT NULL,
    descripciontour     TEXT, -- Reemplazo de CLOB por TEXT
    preciotour          INT NOT NULL,
    duraciontour        INT,
    disponibilidadtour  VARCHAR(25) NOT NULL,
    sitioturisticofk    INT NOT NULL,
    evaluacionfk        VARCHAR(100) NOT NULL
);

CREATE TABLE usuario (
    usuarioid                INT NOT NULL PRIMARY KEY,
    nombreusuario            VARCHAR(50) NOT NULL,
    apellidousuario          VARCHAR(50) NOT NULL,
    correousuario            VARCHAR(100) NOT NULL,
    idiomausuario            VARCHAR(50) NOT NULL,
    tipodiscapacidadusuario  VARCHAR(50),
    fecharegistro            DATE NOT NULL,
    contraseñausuario        VARCHAR(250) NOT NULL,
    direccionusuario         VARCHAR(255),
    telefonousuario          VARCHAR(20) NOT NULL,
    permisousuario           INT NOT NULL,
    usuario_id               INT NOT NULL UNIQUE
);

-- Relaciones Foreign Key
ALTER TABLE accesoqr
    ADD CONSTRAINT fk_accesoqr_usuario FOREIGN KEY (usuariofk)
        REFERENCES usuario (usuario_id);

ALTER TABLE contenidositio
    ADD CONSTRAINT fk_contenidositio_sitioturistico FOREIGN KEY (sitioturisticofk)
        REFERENCES sitioturistico (sitioturisticoid);

ALTER TABLE criterioevaluacion
    ADD CONSTRAINT fk_criterioevaluacion_evaluacion FOREIGN KEY (evaluacionfk)
        REFERENCES evaluacion (evaluacionid);

ALTER TABLE evaluacion
    ADD CONSTRAINT fk_evaluacion_sitioturistico FOREIGN KEY (sitioturisticoid)
        REFERENCES sitioturistico (sitioturistico_id);

ALTER TABLE evaluacion
    ADD CONSTRAINT fk_evaluacion_usuario FOREIGN KEY (usuario_usuarioid)
        REFERENCES usuario (usuarioid);

ALTER TABLE imagensitio
    ADD CONSTRAINT fk_imagensitio_sitioturistico FOREIGN KEY (sitioturisticoid)
        REFERENCES sitioturistico (sitioturistico_id);

ALTER TABLE tour
    ADD CONSTRAINT fk_tour_evaluacion FOREIGN KEY (evaluacionfk)
        REFERENCES evaluacion (evaluacionid);

ALTER TABLE tour
    ADD CONSTRAINT fk_tour_sitioturistico FOREIGN KEY (sitioturisticofk)
        REFERENCES sitioturistico (sitioturistico_id);


-- Población de la tabla usuario (10 registros)
INSERT INTO usuario (usuarioid, nombreusuario, apellidousuario, correousuario, idiomausuario, tipodiscapacidadusuario, fecharegistro, contraseñausuario, direccionusuario, telefonousuario, permisousuario, usuario_id) 
VALUES 
(1, 'Carlos', 'Pérez', 'cperez@gmail.com', 'Español', NULL, '2024-01-01', 'pass123', 'Calle 123', '123456789', 1, 1),
(2, 'Ana', 'López', 'alopez@gmail.com', 'Español', 'Auditiva', '2024-02-01', 'pass456', 'Calle 234', '987654321', 1, 2),
(3, 'Juan', 'Martínez', 'jmartinez@gmail.com', 'Inglés', NULL, '2024-03-01', 'pass789', 'Calle 345', '456789123', 1, 3),
(4, 'Maria', 'González', 'mgonzalez@gmail.com', 'Español', 'Visual', '2024-04-01', 'pass147', 'Calle 456', '654321987', 1, 4),
(5, 'Pedro', 'Ramírez', 'pramirez@gmail.com', 'Español', NULL, '2024-05-01', 'pass258', 'Calle 567', '789123456', 1, 5),
(6, 'Laura', 'Jiménez', 'ljimenez@gmail.com', 'Español', 'Motriz', '2024-06-01', 'pass369', 'Calle 678', '321987654', 1, 6),
(7, 'Sofía', 'Morales', 'smorales@gmail.com', 'Francés', NULL, '2024-07-01', 'pass741', 'Calle 789', '654789321', 1, 7),
(8, 'Luis', 'Vargas', 'lvargas@gmail.com', 'Español', NULL, '2024-08-01', 'pass852', 'Calle 890', '789321654', 1, 8),
(9, 'Miguel', 'Torres', 'mtorres@gmail.com', 'Español', 'Visual', '2024-09-01', 'pass963', 'Calle 901', '987654321', 1, 9),
(10, 'Valeria', 'Suárez', 'vsuarez@gmail.com', 'Inglés', NULL, '2024-10-01', 'pass1234', 'Calle 234', '456789123', 1, 10);

-- Población de la tabla sitioturistico (10 registros)
INSERT INTO sitioturistico (sitioturisticoid, nombresitioturistico, ubicacionsitioturistico, descripcionsitioturistico, sitioturistico_id)
VALUES 
('ST01', 'Parque Nacional', 'Ciudad A', 'Un hermoso parque con muchas actividades al aire libre.', 1),
('ST02', 'Museo de Arte', 'Ciudad B', 'Exposición permanente de arte contemporáneo.', 2),
('ST03', 'Catedral Metropolitana', 'Ciudad C', 'Una catedral con arquitectura impresionante.', 3),
('ST04', 'Zoológico Central', 'Ciudad D', 'Una visita guiada por el zoológico con animales exóticos.', 4),
('ST05', 'Centro Histórico', 'Ciudad E', 'El centro histórico de la ciudad con monumentos y plazas.', 5),
('ST06', 'Jardín Botánico', 'Ciudad F', 'Un recorrido por el jardín botánico.', 6),
('ST07', 'Playa Bonita', 'Ciudad G', 'Una playa paradisiaca con arena blanca.', 7),
('ST08', 'Parque de Diversiones', 'Ciudad H', 'Parque de diversiones para toda la familia.', 8),
('ST09', 'Museo de Ciencias', 'Ciudad I', 'Exposición de avances científicos.', 9),
('ST10', 'Estadio Nacional', 'Ciudad J', 'Estadio con capacidad para 50,000 personas.', 10);

-- Población de la tabla evaluacion (10 registros)
INSERT INTO evaluacion (evaluacionid, evaluacion_id, sitioturisticoid, usuario_usuarioid)
VALUES 
('EV01', 1, 1, 1),
('EV02', 2, 2, 2),
('EV03', 3, 3, 3),
('EV04', 4, 4, 4),
('EV05', 5, 5, 5),
('EV06', 6, 6, 6),
('EV07', 7, 7, 7),
('EV08', 8, 8, 8),
('EV09', 9, 9, 9),
('EV10', 10, 10, 10);

-- Población de la tabla criterioevaluacion (10 registros)
INSERT INTO criterioevaluacion (criterioid, amabilidad, camino, costo, recomendacion, satisfaccion, transporte, opinion, evaluacionfk)
VALUES
(1, 'Alta', 'Bueno', 'Medio', 'Sí', 5, 'Público', 'Muy satisfecho con la visita.', 'EV01'),
(2, 'Media', 'Malo', 'Alto', 'No', 3, 'Privado', 'No muy satisfecho.', 'EV02'),
(3, 'Alta', 'Bueno', 'Medio', 'Sí', 4, 'Público', 'Satisfecho en general.', 'EV03'),
(4, 'Baja', 'Regular', 'Alto', 'No', 2, 'Público', 'No recomendaría el lugar.', 'EV04'),
(5, 'Alta', 'Excelente', 'Medio', 'Sí', 5, 'Público', 'Muy buena experiencia.', 'EV05'),
(6, 'Media', 'Bueno', 'Medio', 'Sí', 4, 'Público', 'Satisfecho con algunos detalles.', 'EV06'),
(7, 'Alta', 'Bueno', 'Bajo', 'Sí', 5, 'Privado', 'Excelente lugar.', 'EV07'),
(8, 'Baja', 'Malo', 'Alto', 'No', 1, 'Público', 'Mala experiencia.', 'EV08'),
(9, 'Alta', 'Excelente', 'Medio', 'Sí', 5, 'Público', 'Maravillosa experiencia.', 'EV09'),
(10, 'Media', 'Bueno', 'Medio', 'Sí', 4, 'Público', 'Buena experiencia en general.', 'EV10');

-- Población de la tabla accesoqr (10 registros)
INSERT INTO accesoqr (accesoqrid, fechaacceso, estadoaccesoqr, usuariofk)
VALUES 
(1, '2024-01-01', 'Activo', 1),
(2, '2024-01-05', 'Inactivo', 2),
(3, '2024-02-01', 'Activo', 3),
(4, '2024-02-10', 'Activo', 4),
(5, '2024-03-01', 'Inactivo', 5),
(6, '2024-03-15', 'Activo', 6),
(7, '2024-04-01', 'Activo', 7),
(8, '2024-04-10', 'Inactivo', 8),
(9, '2024-05-01', 'Activo', 9),
(10, '2024-05-15', 'Activo', 10);

-- Población de la tabla tour (10 registros)
INSERT INTO tour (tourid, nombretour, descripciontour, preciotour, duraciontour, disponibilidadtour, sitioturisticofk, evaluacionfk)
VALUES 
(1, 'Tour Aventura', 'Un tour lleno de emociones.', 50000, 120, 'Disponible', 1, 'EV01'),
(2, 'Tour Cultural', 'Descubre la historia de la ciudad.', 30000, 90, 'No disponible', 2, 'EV02'),
(3, 'Tour Ecológico', 'Un recorrido por la naturaleza.', 40000, 180, 'Disponible', 3, 'EV03'),
(4, 'Tour Gastronómico', 'Prueba la mejor comida local.', 35000, 150, 'Disponible', 4, 'EV04'),
(5, 'Tour Histórico', 'Conoce los lugares más emblemáticos.', 25000, 60, 'No disponible', 5, 'EV05'),
(6, 'Tour Aventura Extrema', 'Emociones garantizadas.', 60000, 180, 'Disponible', 6, 'EV06'),
(7, 'Tour de Museos', 'Un recorrido por los mejores museos.', 20000, 90, 'No disponible', 7, 'EV07'),
(8, 'Tour Nocturno', 'Descubre la ciudad de noche.', 30000, 120, 'Disponible', 8, 'EV08'),
(9, 'Tour de Aventura Acuática', 'Explora los deportes acuáticos.', 55000, 180, 'Disponible', 9, 'EV09'),
(10, 'Tour de Compras', 'Un tour para los amantes de las compras.', 25000, 60, 'Disponible', 10, 'EV10');


-- Población de la tabla imagensitio (10 registros)
INSERT INTO imagensitio (imagensitioturistico_id, imagenid, urlimagen, ordenimagen, sitioturisticoid)
VALUES 
(1, 1, 'https://sitioturistico1.com/imagen1.jpg', 1, 1),
(2, 2, 'https://sitioturistico2.com/imagen2.jpg', 2, 2),
(3, 3, 'https://sitioturistico3.com/imagen3.jpg', 1, 3),
(4, 4, 'https://sitioturistico4.com/imagen4.jpg', 2, 4),
(5, 5, 'https://sitioturistico5.com/imagen5.jpg', 1, 5),
(6, 6, 'https://sitioturistico6.com/imagen6.jpg', 2, 6),
(7, 7, 'https://sitioturistico7.com/imagen7.jpg', 1, 7),
(8, 8, 'https://sitioturistico8.com/imagen8.jpg', 2, 8),
(9, 9, 'https://sitioturistico9.com/imagen9.jpg', 1, 9),
(10, 10, 'https://sitioturistico10.com/imagen10.jpg', 2, 10);

-- Población de la tabla contenidositio (10 registros)
INSERT INTO contenidositio (contenidoid, contenido, sitioturisticofk, encabezado, masdetalle)
VALUES 
(1, 'Historia del sitio turístico 1.', 'ST01', 'Historia', 'Detalles adicionales sobre la historia del sitio turístico 1.'),
(2, 'Historia del sitio turístico 2.', 'ST02', 'Historia', 'Detalles adicionales sobre la historia del sitio turístico 2.'),
(3, 'Historia del sitio turístico 3.', 'ST03', 'Historia', 'Detalles adicionales sobre la historia del sitio turístico 3.'),
(4, 'Historia del sitio turístico 4.', 'ST04', 'Historia', 'Detalles adicionales sobre la historia del sitio turístico 4.'),
(5, 'Historia del sitio turístico 5.', 'ST05', 'Historia', 'Detalles adicionales sobre la historia del sitio turístico 5.'),
(6, 'Historia del sitio turístico 6.', 'ST06', 'Historia', 'Detalles adicionales sobre la historia del sitio turístico 6.'),
(7, 'Historia del sitio turístico 7.', 'ST07', 'Historia', 'Detalles adicionales sobre la historia del sitio turístico 7.'),
(8, 'Historia del sitio turístico 8.', 'ST08', 'Historia', 'Detalles adicionales sobre la historia del sitio turístico 8.'),
(9, 'Historia del sitio turístico 9.', 'ST09', 'Historia', 'Detalles adicionales sobre la historia del sitio turístico 9.'),
(10, 'Historia del sitio turístico 10.', 'ST10', 'Historia', 'Detalles adicionales sobre la historia del sitio turístico 10.');

