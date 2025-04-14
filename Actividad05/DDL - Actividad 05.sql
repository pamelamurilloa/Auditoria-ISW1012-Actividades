-- DROP SCHEMA actividad05;

CREATE SCHEMA actividad05 AUTHORIZATION postgres;

CREATE TABLE actividad05.clase (
    id     SMALLINT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    estado VARCHAR(10) NOT NULL
);

COMMENT ON COLUMN actividad05.clase.id IS
    'Id de la tabla';

COMMENT ON COLUMN actividad05.clase.nombre IS
    'Nombre de la clase de software';

COMMENT ON COLUMN actividad05.clase.estado IS
    'Estado de la clase de software. Puede tener los valores: Avtivo; Inactivo';

ALTER TABLE actividad05.clase ADD CONSTRAINT pk_clase PRIMARY KEY ( id );

CREATE TABLE actividad05.licencia (
    id                    SMALLINT NOT NULL,
    software_id           SMALLINT NOT NULL,
    maquina               VARCHAR(20) NOT NULL,
    fecha_primera_install DATE NOT NULL
);

COMMENT ON COLUMN actividad05.licencia.id IS
    'Id de la tabla';

COMMENT ON COLUMN actividad05.licencia.maquina IS
    'Maquina donde se usa o instala la licencia';

COMMENT ON COLUMN actividad05.licencia.fecha_primera_install IS
    'Fecha de primera instalación del software licenciado';

ALTER TABLE actividad05.licencia ADD CONSTRAINT pk_licencia PRIMARY KEY ( id );

CREATE TABLE actividad05.software (
    id                     SMALLINT NOT NULL,
    clase_id               SMALLINT NOT NULL,
    nombre                 VARCHAR(100) NOT NULL,
    obsoleto               VARCHAR(2) NOT NULL,
    requiere_licencia      VARCHAR(2) NOT NULL,
    "licencias adquiridas" SMALLINT NOT NULL,
    fecha_salida           DATE
);

COMMENT ON COLUMN actividad05.software.id IS
    'Id de la tabla';

COMMENT ON COLUMN actividad05.software.nombre IS
    'Nombre del software';

COMMENT ON COLUMN actividad05.software.obsoleto IS
    'Identifica si el software esta obsoleto. Puede tener Si; No';

COMMENT ON COLUMN actividad05.software.requiere_licencia IS
    'Determina si el software requiere licencia, Puede tener Si; No';

COMMENT ON COLUMN actividad05.software."licencias adquiridas" IS
    'Cantidad de licencias adquiridas';

COMMENT ON COLUMN actividad05.software.fecha_salida IS
    'Fecha de salida del software';

ALTER TABLE actividad05.software ADD CONSTRAINT pk_software PRIMARY KEY ( id );

ALTER TABLE actividad05.licencia
    ADD CONSTRAINT fk_licencia_software FOREIGN KEY ( software_id )
        REFERENCES actividad05.software ( id );

ALTER TABLE actividad05.software
    ADD CONSTRAINT fk_software_clase FOREIGN KEY ( clase_id )
        REFERENCES actividad05.clase ( id );