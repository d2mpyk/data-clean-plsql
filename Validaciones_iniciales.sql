-- Consultas para homologación de Bases de Datos
-- Validación de inicio de la carga
-- Validación de nombres vacios o nulos
UPDATE < BASE >
SET
    NOMBRE = NULL
WHERE
    (
        NOMBRE = 'null'
        OR NOMBRE = 'NULL'
        OR NOMBRE = ''
        OR NOMBRE = ' '
        OR NOMBRE IS NULL
    );

-- Normaliza nombres tipo juan____perez
UPDATE < BASE > 
SET
    NOMBRE = REGEXP_REPLACE (NOMBRE, '_+', '_');

-- Separa nombre, apellido, apellido2
UPDATE < BASE >
SET
    nombre = (
        CASE
            WHEN (
                1 + LENGTH (NOMBRE) - LENGTH (REPLACE (NOMBRE, '_', ''))
            ) <= 4 THEN SUBSTRING_INDEX (NOMBRE, '_', 1)
            ELSE NOMBRE
        END
    ),
    apellido = (
        CASE
            WHEN (
                1 + LENGTH (NOMBRE) - LENGTH (REPLACE (NOMBRE, '_', ''))
            ) = 2 THEN SUBSTRING_INDEX (NOMBRE, '_', -1)
            WHEN (
                1 + LENGTH (NOMBRE) - LENGTH (REPLACE (NOMBRE, '_', ''))
            ) = 3 THEN SUBSTRING_INDEX (SUBSTRING_INDEX (NOMBRE, '_', -2), '_', 1)
            WHEN (
                1 + LENGTH (NOMBRE) - LENGTH (REPLACE (NOMBRE, '_', ''))
            ) = 4 THEN SUBSTRING_INDEX (SUBSTRING_INDEX (NOMBRE, '_', -2), '_', 1)
            ELSE NULL
        END
    );

-- Validación de Saldos
UPDATE < BASE >
SET
    SALDO = 0
WHERE
    (
        SALDO = ''
        OR SALDO = ' '
        OR SALDO <= 0
        OR SALDO IS NULL
    );

-- Validación de Telefonos Incompletos (5 Ordenes)
SELECT
    < 'CAMPAÑA' >,
    'TELEFONO <> 9',
    COUNT(*) TOTAL
FROM
    < BASE >
WHERE
    LENGTH (TELEFONO_1) <> 9
    AND LENGTH (TELEFONO_2) <> 9
    AND LENGTH (TELEFONO_3) <> 9
    AND LENGTH (TELEFONO_4) <> 9
    AND LENGTH (TELEFONO_5) <> 9;

-- Validación de Telefonos NULL (5 Ordenes)
SELECT
    < 'CAMPAÑA' >,
    'TELEFONO NULL',
    COUNT(*) TOTAL
FROM
    < BASE >
WHERE
    TELEFONO_1 IS NULL
    AND TELEFONO_2 IS NULL
    AND TELEFONO_3 IS NULL
    AND TELEFONO_4 IS NULL
    AND TELEFONO_5 IS NULL;

-- Validación de Telefonos Vacios (5 Ordenes)
SELECT
    < 'CAMPAÑA' >,
    'TELEFONO VACIO',
    COUNT(*) TOTAL
FROM
    < BASE >
WHERE
    (
        TELEFONO_1 = ''
        OR TELEFONO_1 = ' '
    )
    AND (
        TELEFONO_2 = ''
        OR TELEFONO_2 = ' '
    )
    AND (
        TELEFONO_3 = ''
        OR TELEFONO_3 = ' '
    )
    AND (
        TELEFONO_4 = ''
        OR TELEFONO_4 = ' '
    )
    AND (
        TELEFONO_5 = ''
        OR TELEFONO_5 = ' '
    );

-- Verifica números invalidos (Legislación Chile) y convierte a NULL (5 Ordenes)
UPDATE < BASE >
SET
    TELEFONO_1 = NULL
WHERE 
    (
        LEFT (TELEFONO_1, 1) IN (0, 1, 8)
        OR TELEFONO_1 REGEXP '^(\\d)\\1{8}$'
        OR TELEFONO_1 REGEXP '^.?(\\d)\\1{7}$'        
        OR TELEFONO_1 REGEXP '^(123456789|987654321|912345678)$'
    )
    AND TELEFONO_1 REGEXP '^(46|56|74|80|81|82|84)\\d{7}$'
    AND TELEFONO_1 NOT REGEXP '^(32|33|34|35|39|41|42|43|44|45|51|52|53|55|57|58|61|63|64|65|67|68|71|72|73|75)\\d{7}$';

UPDATE < BASE >
SET
    TELEFONO_2 = NULL
WHERE
    (
        LEFT (TELEFONO_2, 1) IN (0, 1, 8)
        OR TELEFONO_2 REGEXP '^(\\d)\\1{8}$'
        OR TELEFONO_2 REGEXP '^.?(\\d)\\1{7}$'
        OR TELEFONO_2 REGEXP '^(123456789|987654321|912345678)$'
    )
    AND TELEFONO_2 REGEXP '^(46|56|74|80|81|82|84)\\d{7}$'
    AND TELEFONO_2 NOT REGEXP '^(32|33|34|35|39|41|42|43|44|45|51|52|53|55|57|58|61|63|64|65|67|68|71|72|73|75)\\d{7}$';

UPDATE < BASE >
SET
    TELEFONO_3 = NULL
WHERE
    (
        LEFT (TELEFONO_3, 1) IN (0, 1, 8)
        OR TELEFONO_3 REGEXP '^(\\d)\\1{8}$'
        OR TELEFONO_3 REGEXP '^.?(\\d)\\1{7}$'
        OR TELEFONO_3 REGEXP '^(123456789|987654321|912345678)$'
    )
    AND TELEFONO_3 REGEXP '^(46|56|74|80|81|82|84)\\d{7}$'
    AND TELEFONO_3 NOT REGEXP '^(32|33|34|35|39|41|42|43|44|45|51|52|53|55|57|58|61|63|64|65|67|68|71|72|73|75)\\d{7}$';

UPDATE < BASE >
SET
    TELEFONO_4 = NULL
WHERE
    (
        LEFT (TELEFONO_4, 1) IN (0, 1, 8)
        OR TELEFONO_4 REGEXP '^(\\d)\\1{8}$'
        OR TELEFONO_4 REGEXP '^.?(\\d)\\1{7}$'
        OR TELEFONO_4 REGEXP '^(123456789|987654321|912345678)$'
    )
    AND TELEFONO_4 REGEXP '^(46|56|74|80|81|82|84)\\d{7}$'
    AND TELEFONO_4 NOT REGEXP '^(32|33|34|35|39|41|42|43|44|45|51|52|53|55|57|58|61|63|64|65|67|68|71|72|73|75)\\d{7}$';

UPDATE < BASE >
SET
    TELEFONO_5 = NULL
WHERE
    (
        LEFT (TELEFONO_5, 1) IN (0, 1, 8)
        OR TELEFONO_5 REGEXP '^(\\d)\\1{8}$'
        OR TELEFONO_5 REGEXP '^.?(\\d)\\1{7}$'
        OR TELEFONO_5 REGEXP '^(123456789|987654321|912345678)$'
    )
    AND TELEFONO_5 REGEXP '^(46|56|74|80|81|82|84)\\d{7}$'
    AND TELEFONO_5 NOT REGEXP '^(32|33|34|35|39|41|42|43|44|45|51|52|53|55|57|58|61|63|64|65|67|68|71|72|73|75)\\d{7}$';

-- Convierte valores vacios o duplicados de Telefonos a NULL (5 Ordenes)
UPDATE < BASE >
SET TELEFONO_2 = CASE
        WHEN TELEFONO_2 IS NULL
            OR TRIM(TELEFONO_2) = ''
            OR TELEFONO_2 = TELEFONO_1
            THEN NULL
        ELSE TELEFONO_2
    END,
    TELEFONO_3 = CASE
        WHEN TELEFONO_3 IS NULL
            OR TRIM(TELEFONO_3) = ''
            OR TELEFONO_3 IN (
                TELEFONO_1,
                TELEFONO_2
            ) THEN NULL
        ELSE TELEFONO_3
    END,
    TELEFONO_4 = CASE
        WHEN TELEFONO_4 IS NULL
            OR TRIM(TELEFONO_4) = ''
            OR TELEFONO_4 IN (
                TELEFONO_1, 
                TELEFONO_2, 
                TELEFONO_3
            ) THEN NULL
        ELSE TELEFONO_4
    END,
    TELEFONO_5 = CASE
        WHEN TELEFONO_5 IS NULL
            OR TRIM(TELEFONO_5) = ''
            OR TELEFONO_5 IN (
                TELEFONO_1,
                TELEFONO_2,
                TELEFONO_3,
                TELEFONO_4
            ) THEN NULL
        ELSE TELEFONO_5
    END;

-- Reordena los telefonos hacia las primeras posiciones (5 Ordenes)
-- =================================================================
DROP TEMPORARY TABLE IF EXISTS tmp_telefonos_pivot;

CREATE TEMPORARY TABLE tmp_telefonos_pivot AS
WITH telefonos_origen AS (
    SELECT ID, 1 AS posicion, NULLIF(TRIM(TELEFONO_1), '') AS telefono
    FROM < BASE >

    UNION ALL
    SELECT ID, 2, NULLIF(TRIM(TELEFONO_2), '')
    FROM < BASE >

    UNION ALL
    SELECT ID, 3, NULLIF(TRIM(TELEFONO_3), '')
    FROM < BASE >

    UNION ALL
    SELECT ID, 4, NULLIF(TRIM(TELEFONO_4), '')
    FROM < BASE >

    UNION ALL
    SELECT ID, 5, NULLIF(TRIM(TELEFONO_5), '')
    FROM < BASE >
),
telefonos_distintos AS (
    SELECT ID, telefono, MIN(posicion) AS primera_posicion
    FROM telefonos_origen
    WHERE telefono IS NOT NULL
    GROUP BY ID, telefono
),
telefonos_ordenados AS (
    SELECT
        ID,
        telefono,
        ROW_NUMBER() OVER (
            PARTITION BY ID
            ORDER BY primera_posicion
        ) AS posicion_final
    FROM telefonos_distintos
)
SELECT
    ID,
    MAX(CASE WHEN posicion_final = 1 THEN telefono END) AS TELEFONO_1_NUEVO,
    MAX(CASE WHEN posicion_final = 2 THEN telefono END) AS TELEFONO_2_NUEVO,
    MAX(CASE WHEN posicion_final = 3 THEN telefono END) AS TELEFONO_3_NUEVO,
    MAX(CASE WHEN posicion_final = 4 THEN telefono END) AS TELEFONO_4_NUEVO,
    MAX(CASE WHEN posicion_final = 5 THEN telefono END) AS TELEFONO_5_NUEVO
FROM telefonos_ordenados
GROUP BY ID;	

UPDATE < BASE > AS b
JOIN tmp_telefonos_pivot AS p
    ON p.ID = b.ID
SET
    b.TELEFONO_1 = p.TELEFONO_1_NUEVO,
    b.TELEFONO_2 = p.TELEFONO_2_NUEVO,
    b.TELEFONO_3 = p.TELEFONO_3_NUEVO,
    b.TELEFONO_4 = p.TELEFONO_4_NUEVO,
    b.TELEFONO_5 = p.TELEFONO_5_NUEVO;

DROP TEMPORARY TABLE tmp_telefonos_pivot;
-- =================================================================

-- Validación de ID Vacio
SELECT
    < 'CAMPAÑA' >,
    'ID VACIO',
    COUNT(*) TOTAL
FROM
    < BASE >
WHERE
    (
        ID = ''
        OR ID = ' '
        OR ID IS NULL
    );