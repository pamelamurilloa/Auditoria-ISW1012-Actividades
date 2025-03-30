
CREATE SCHEMA proyecto AUTHORIZATION postgres;

CREATE TABLE proyecto.proyecto (
    id     SMALLINT NOT NULL,
    codigo VARCHAR(10) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    estado VARCHAR(30) NOT NULL
);

COMMENT ON COLUMN proyecto.proyecto.id IS
    'Id de la tabla';

COMMENT ON COLUMN proyecto.proyecto.codigo IS
    'Codigo del proyecto';

COMMENT ON COLUMN proyecto.proyecto.nombre IS
    'Nombre del proyecto';

COMMENT ON COLUMN proyecto.proyecto.estado IS
    'Estado del proyecto';

ALTER TABLE proyecto.proyecto ADD CONSTRAINT proyecto_pk PRIMARY KEY ( id );

CREATE TABLE proyecto.ticket (
    id             SMALLINT NOT NULL,
    servicio       VARCHAR(100) NOT NULL,
    asunto         VARCHAR(100) NOT NULL,
    responsable    VARCHAR(10) NOT NULL,
    fecha_creacion DATE NOT NULL
);

COMMENT ON COLUMN proyecto.ticket.id IS
    'Id de la tabla';

COMMENT ON COLUMN proyecto.ticket.servicio IS
    'Servicio al que esta asocisdo el ticket';

COMMENT ON COLUMN proyecto.ticket.asunto IS
    'Asunto del ticket';

COMMENT ON COLUMN proyecto.ticket.responsable IS
    'Usuario responsable del ticket';

COMMENT ON COLUMN proyecto.ticket.fecha_creacion IS
    'Fecha de creacion del ticket';

ALTER TABLE proyecto.ticket ADD CONSTRAINT ticket_pk PRIMARY KEY ( id );

CREATE TABLE proyecto.usuario (
    usuario  VARCHAR(10) NOT NULL,
    nombre   VARCHAR(50) NOT NULL,
    apellido VARCHAR(100) NOT NULL
);

COMMENT ON COLUMN proyecto.usuario.usuario IS
    'Código de usuario';

COMMENT ON COLUMN proyecto.usuario.nombre IS
    'nombre del usuario';

COMMENT ON COLUMN proyecto.usuario.apellido IS
    'Apellidos del usuario';

ALTER TABLE proyecto.usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( usuario );

ALTER TABLE proyecto.ticket
    ADD CONSTRAINT ticket_usuario_fk FOREIGN KEY ( responsable )
        REFERENCES proyecto.usuario ( usuario );
