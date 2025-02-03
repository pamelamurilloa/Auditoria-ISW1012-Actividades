-- Actividad01 --
-- Yeustin Lewis y Murillo Pamela

-- Justificación de Hallazgos

-- 01 - Falta de Llave Primaria Válida en Código de Producto.
-- 		Regla de Integridad de Entidad - Llave Única.

WITH
	table_constraint_pk AS (
		SELECT *  FROM information_schema.table_constraints cnt
		WHERE cnt.constraint_type = 'PRIMARY KEY')
		SELECT tbl.table_schema ESQUEMA, tbl.table_name NOMBRE_DE_TABLA, tbl.table_type TIPO_DE_TABLA, 
		cnt.constraint_name, cnt.constraint_type,
		CASE COALESCE(cnt.constraint_name, '1') WHEN '1' THEN 'No tiene una llave documentada' END VALIDACION_PK
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


-- 03 - Llave Foránea no Detectada en Detalle de Pedidos hacia Pedidos.
-- 		Regla de Integridad Referencial


-- 04 - Fechas Inconsistentes en nacimientos
--		Regla de Integridad de Dominio


-- 05 -