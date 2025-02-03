-- Actividad01 --
-- Yeustin Lewis y Murillo Pamela

-- Justificación de Hallazgos

-- 01 - Falta de Llave Primaria Válida en Código de Producto.
-- 		Regla de Integridad de Entidad - Llave Única.

WITH
	table_constraint_pk AS (
		SELECT *  FROM information_schema.table_constraints cnt
		WHERE cnt.constraint_type = 'PRIMARY KEY'
	)
		SELECT tbl.table_schema ESQUEMA,
			tbl.table_name NOMBRE_DE_TABLA,
			tbl.table_type TIPO_DE_TABLA, 
			cnt.constraint_name,
			cnt.constraint_type,
			CASE COALESCE(cnt.constraint_name, '1')
				WHEN '1' THEN 'No tiene una llave documentada'
				END VALIDACION_PK
		 FROM information_schema.tables tbl
		 	LEFT JOIN table_constraint_pk cnt
		 	ON cnt.table_schema = tbl.table_schema
		 	AND cnt.table_name = tbl.table_name
		WHERE tbl.table_schema = 'actividad01'
			AND tbl.table_type NOT IN ('VIEW')
			AND cnt.table_name IS NULL
		ORDER BY tbl.table_name;

-- 02 - Productos sin Nombre.
--		Regla de Integridad de Atributo - Restricción de Dominio.
WITH
	column_info AS (
	    SELECT * 
	    FROM information_schema.columns 
	    WHERE table_schema = 'actividad01' 
	    AND column_name = 'nombre'
	)
	SELECT 
	    tbl.table_schema AS ESQUEMA,
	    tbl.table_name AS NOMBRE_DE_TABLA, 
		col.column_name AS NOMBRE_DE_COLUMNA,
	    tbl.table_type AS TIPO_DE_TABLA,
	    col.is_nullable,
	    CASE COALESCE(col.is_nullable, '1')
	        WHEN 'YES' THEN 'Permite valores nulos'
	        ELSE 'No permite valores nulos'
	    END AS SE_PERMITEN_VACIOS
	FROM information_schema.tables tbl
	LEFT JOIN column_info col
	    ON col.table_schema = tbl.table_schema
	    AND col.table_name = tbl.table_name
	WHERE tbl.table_schema = 'actividad01'
		AND tbl.table_type NOT IN ('VIEW')
		AND col.is_nullable IS NOT NULL
	ORDER BY tbl.table_name;


-- 03 - Llave Foránea no Detectada en Detalle de Pedidos hacia Pedidos.
-- 		Regla de Integridad Referencial


-- 04 - Fechas Inconsistentes de creación
--		Regla de Integridad de Negocio
	SELECT 
	    tbl.table_schema AS ESQUEMA,
	    tbl.table_name AS NOMBRE_DE_TABLA,
	    tbl.table_type AS TIPO_DE_TABLA,
		STRING_AGG(cli.fecha_creacion::TEXT, ', ') FILTER (WHERE cli.fecha_creacion > NOW()) AS FECHAS_EN_EL_FUTURO,
	    CASE 
	        WHEN COUNT(cli.fecha_creacion) FILTER (WHERE cli.fecha_creacion > NOW()) > 0 
	        THEN 'Tiene fechas en el futuro'
	        ELSE 'No tiene fechas en el futuro'
	    END AS VALIDACION_FECHA_CREACION
	FROM information_schema.tables tbl
	LEFT JOIN information_schema.columns col
	    ON col.table_schema = tbl.table_schema
	    AND col.table_name = tbl.table_name
	    AND col.column_name = 'fecha_creacion'
	LEFT JOIN actividad01.cliente cli
	    ON tbl.table_name = 'cliente'
	    AND cli.fecha_creacion IS NOT NULL
	WHERE tbl.table_schema = 'actividad01'
		AND tbl.table_type NOT IN ('VIEW')
		AND col.column_name IS NOT NULL
	GROUP BY tbl.table_schema, tbl.table_name, tbl.table_type
	ORDER BY tbl.table_name;


-- 05 -