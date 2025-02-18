CREATE SCHEMA actividad02 AUTHORIZATION  postgres;

CREATE TABLE actividad02.calificaciones( 
     id              INTEGER  NOT NULL , 
     id_evaluaciones INTEGER  NOT NULL , 
     id_estudiantes  INTEGER  NOT NULL , 
     nota            NUMERIC  NOT NULL 
    );

COMMENT ON COLUMN actividad02.calificaciones.id IS 'Id de la tabla';
COMMENT ON COLUMN actividad02.calificaciones.id_evaluaciones IS 'Id de la tabla de evaulaciones';
COMMENT ON COLUMN actividad02.calificaciones.id_estudiantes IS 'Id de la tabla de estudiantes';
COMMENT ON COLUMN actividad02.calificaciones.nota IS 'Nota obtenida en la calificación por el estudiante';

ALTER TABLE actividad02.calificaciones ADD CONSTRAINT calificaciones_nota_ck CHECK (nota >= 0 and nota <= 100);
ALTER TABLE actividad02.calificaciones ADD CONSTRAINT pk_calificaciones PRIMARY KEY ( id ) ;

CREATE TABLE actividad02.cursos ( 
     id     INTEGER  NOT NULL , 
     codigo VARCHAR (10)  NOT NULL , 
     nombre VARCHAR (100)  NOT NULL , 
     estado VARCHAR (1) DEFAULT 'A'  NOT NULL 
    );

COMMENT ON COLUMN actividad02.cursos.id IS 'Id de la tabla';
COMMENT ON COLUMN actividad02.cursos.codigo IS 'Código del curso' ;
COMMENT ON COLUMN actividad02.cursos.nombre IS 'Nombre del curso' ;
COMMENT ON COLUMN actividad02.cursos.estado IS 'Estado del curso. Puede tener loa valores: A = Activo; I =Inactivo' ;

ALTER TABLE actividad02.cursos ADD CONSTRAINT ck_curso_estados CHECK (estado in ('A','I'));
ALTER TABLE actividad02.cursos ADD CONSTRAINT cursos_pk PRIMARY KEY ( id ) ;
ALTER TABLE actividad02.cursos ADD CONSTRAINT uk_cursos UNIQUE ( codigo ) ;

CREATE TABLE actividad02.estudiantes( 
     id              INTEGER  NOT NULL , 
     id_personas     INTEGER  NOT NULL , 
     id_grupos       INTEGER  NOT NULL , 
     fecha_matricula DATE 
    );

COMMENT ON COLUMN actividad02.estudiantes.id IS 'Id de la tabla';
COMMENT ON COLUMN actividad02.estudiantes.id_personas IS 'Id de la tabla de personas';
COMMENT ON COLUMN actividad02.estudiantes.id_grupos IS 'Id de la tabla de grupos';
COMMENT ON COLUMN actividad02.estudiantes.fecha_matricula IS 'Fecha y Hora en la que matriculo';

ALTER TABLE actividad02.estudiantes ADD CONSTRAINT pk__estudiantes PRIMARY KEY ( id ) ;
ALTER TABLE actividad02.estudiantes ADD CONSTRAINT uk_estudiantes_id_grupos UNIQUE ( id_personas ) ;

CREATE TABLE actividad02.evaluaciones( 
     id         INTEGER  NOT NULL , 
     id_cursos  INTEGER  NOT NULL , 
     nombre     VARCHAR (50)  NOT NULL , 
     porcentaje NUMERIC DEFAULT 0  NOT NULL , 
     orden      INTEGER  NOT NULL , 
     cantidad   INTEGER  NOT NULL 
    ) ;

COMMENT ON COLUMN actividad02.evaluaciones.id IS 'Id de la tabla';
COMMENT ON COLUMN actividad02.evaluaciones.id_cursos IS 'Id de lka tabla de cursos';
COMMENT ON COLUMN actividad02.evaluaciones.nombre IS 'Nombre de la evaluación';
COMMENT ON COLUMN actividad02.evaluaciones.porcentaje IS 'Porcentaje que representa la evaluación' ;
COMMENT ON COLUMN actividad02.evaluaciones.orden IS 'Order de la evluacion en el curso';
COMMENT ON COLUMN actividad02.evaluaciones.cantidad IS 'Cantidad de calificaciones que se deben realizar al curso';

ALTER TABLE actividad02.evaluaciones ADD CONSTRAINT ck_evaluaciones_porcentaje CHECK (porcentaje > 0 and porcentaje <= 100);
ALTER TABLE actividad02.evaluaciones ADD CONSTRAINT ck_evaluaciones_orden CHECK (orden > 0);
ALTER TABLE actividad02.evaluaciones ADD CONSTRAINT ck_evaluaciones_cantidad CHECK (cantidad > 0);
ALTER TABLE actividad02.evaluaciones  ADD CONSTRAINT pk_evaluaciones PRIMARY KEY ( id ) ;
ALTER TABLE actividad02.evaluaciones ADD CONSTRAINT uk_evaluaciones_cursos_orden UNIQUE ( id_cursos , orden ) ;

CREATE TABLE actividad02.grupos( 
     id     INTEGER  NOT NULL , 
     numero INTEGER  NOT NULL , 
     nombre VARCHAR (20)  NOT NULL 
    ) ;

COMMENT ON COLUMN actividad02.grupos.id IS 'Id de la tabla' ;
COMMENT ON COLUMN actividad02.grupos.numero IS 'Número de grupo' ;
COMMENT ON COLUMN actividad02.grupos.nombre IS 'Nombre del grupo' ;

ALTER TABLE actividad02.grupos  ADD CONSTRAINT ck_grupos_numero CHECK (numero > 0);
ALTER TABLE actividad02.grupos ADD CONSTRAINT pk_grupos PRIMARY KEY ( id ) ;
ALTER TABLE actividad02.grupos ADD CONSTRAINT uk_grupos_numero UNIQUE ( numero ) ;

CREATE TABLE actividad02.personas( 
     id       INTEGER  NOT NULL , 
     cedula   VARCHAR (20)  NOT NULL , 
     nombre   VARCHAR (100)  NOT NULL , 
     telefono INTEGER , 
     email    VARCHAR (100)  NOT NULL 
    ) ;

COMMENT ON COLUMN actividad02.personas.id IS 'Id de la tabla';
COMMENT ON COLUMN actividad02.personas.cedula IS 'Número de identificación  de Costa Rica' ;
COMMENT ON COLUMN actividad02.personas.nombre IS 'Nombre completo (nombre y apellidos) de la persona' ;
COMMENT ON COLUMN actividad02.personas.telefono IS 'Número de teléfono' ;
COMMENT ON COLUMN actividad02.personas.email IS 'Dirección de correo electrónico institucional' ;

ALTER TABLE actividad02.personas ADD CONSTRAINT pk_persona PRIMARY KEY ( id ) ;
ALTER TABLE actividad02.personas ADD CONSTRAINT uk_cedula_personas UNIQUE ( cedula ) ;

ALTER TABLE actividad02.calificaciones 
    ADD CONSTRAINT fk_calificacionesestudiantes 
    FOREIGN KEY ( id_estudiantes) REFERENCES actividad02.estudiantes (id);

ALTER TABLE actividad02.calificaciones 
    ADD CONSTRAINT fk_calificaciones_evaluaciones 
    FOREIGN KEY(id_evaluaciones) REFERENCES actividad02.evaluaciones(id);

/*ALTER TABLE actividad02.estudiantes 
    ADD CONSTRAINT fk_estudiantes_grupos 
    FOREIGN KEY(id_grupos) REFERENCES actividad02.grupos(id);*/

ALTER TABLE actividad02.estudiantes 
    ADD CONSTRAINT estudiantes_personas_fk 
    FOREIGN KEY (id_personas) REFERENCES actividad02.personas(id);

ALTER TABLE actividad02.evaluaciones 
    ADD CONSTRAINT fk_evaluacion_cursos 
    FOREIGN KEY(id_cursos) REFERENCES actividad02.cursos(id);

