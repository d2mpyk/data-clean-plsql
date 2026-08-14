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
    );

-- Normaliza nombres tipo juan____perez
UPDATE < BASE > >
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
        TELEFONO__1 = ''
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
    LEFT (TELEFONO_1, 1) IN (0, 1, 8)
    OR TELEFONO_1 REGEXP '^(\\d)\\1{8}$'
    OR TELEFONO_1 REGEXP '^.?(\\d)\\1{7}$'
    AND TELEFONO_1 REGEXP '^(46|56|74|80|81|82|84)\\d{7}$'
    AND TELEFONO_1 NOT REGEXP '^(32|33|34|35|39|41|42|43|44|45|51|52|53|55|57|58|61|63|64|65|67|68|71|72|73|75)\\d{7}$';

UPDATE < BASE >
SET
    TELEFONO_2 = NULL
WHERE
    LEFT (TELEFONO_2, 1) IN (0, 1, 8)
    OR TELEFONO_2 REGEXP '^(\\d)\\1{8}$'
    OR TELEFONO_2 REGEXP '^.?(\\d)\\1{7}$'
    OR TELEFONO_2 REGEXP '^(123456789|987654321|912345678)$'
    AND TELEFONO_2 REGEXP '^(46|56|74|80|81|82|84)\\d{7}$'
    AND TELEFONO_2 NOT REGEXP '^(32|33|34|35|39|41|42|43|44|45|51|52|53|55|57|58|61|63|64|65|67|68|71|72|73|75)\\d{7}$';

UPDATE < BASE >
SET
    TELEFONO_3 = NULL
WHERE
    LEFT (TELEFONO_3, 1) IN (0, 1, 8)
    OR TELEFONO_3 REGEXP '^(\\d)\\1{8}$'
    OR TELEFONO_3 REGEXP '^.?(\\d)\\1{7}$'
    OR TELEFONO_3 REGEXP '^(123456789|987654321|912345678)$'
    AND TELEFONO_3 REGEXP '^(46|56|74|80|81|82|84)\\d{7}$'
    AND TELEFONO_3 NOT REGEXP '^(32|33|34|35|39|41|42|43|44|45|51|52|53|55|57|58|61|63|64|65|67|68|71|72|73|75)\\d{7}$';

UPDATE < BASE >
SET
    TELEFONO_4 = NULL
WHERE
    LEFT (TELEFONO_4, 1) IN (0, 1, 8)
    OR TELEFONO_4 REGEXP '^(\\d)\\1{8}$'
    OR TELEFONO_4 REGEXP '^.?(\\d)\\1{7}$'
    OR TELEFONO_4 REGEXP '^(123456789|987654321|912345678)$'
    AND TELEFONO_4 REGEXP '^(46|56|74|80|81|82|84)\\d{7}$'
    AND TELEFONO_4 NOT REGEXP '^(32|33|34|35|39|41|42|43|44|45|51|52|53|55|57|58|61|63|64|65|67|68|71|72|73|75)\\d{7}$';

UPDATE < BASE >
SET
    TELEFONO_5 = NULL
WHERE
    LEFT (TELEFONO_5, 1) IN (0, 1, 8)
    OR TELEFONO_5 REGEXP '^(\\d)\\1{8}$'
    OR TELEFONO_5 REGEXP '^.?(\\d)\\1{7}$'
    OR TELEFONO_5 REGEXP '^(123456789|987654321|912345678)$'
    AND TELEFONO_5 REGEXP '^(46|56|74|80|81|82|84)\\d{7}$'
    AND TELEFONO_5 NOT REGEXP '^(32|33|34|35|39|41|42|43|44|45|51|52|53|55|57|58|61|63|64|65|67|68|71|72|73|75)\\d{7}$';

-- Convierte valores vacios o duplicados de Telefonos a NULL (5 Ordenes)
UPDATE < BASE >
SET
    TELEFONO_2 = CASE
        WHEN TELEFONO_2 IN (TELEFONO_1, '', NULL) THEN NULL
        ELSE TELEFONO_2
    END,
    TELEFONO_3 = CASE
        WHEN TELEFONO_3 IN (TELEFONO_1, TELEFONO_2, '', NULL) THEN NULL
        ELSE TELEFONO_3
    END,
    TELEFONO_4 = CASE
        WHEN TELEFONO_4 IN (TELEFONO_1, TELEFONO_2, TELEFONO_3, '', NULL) THEN NULL
        ELSE TELEFONO_4
    END,
    TELEFONO_5 = CASE
        WHEN TELEFONO_5 IN (
            TELEFONO_1,
            TELEFONO_2,
            TELEFONO_3,
            TELEFONO_4,
            '',
            NULL
        ) THEN NULL
        ELSE TELEFONO_5
    END;

-- Reordena los telefonos hacia las primeras posiciones (5 Ordenes)
UPDATE < BASE >
SET
    TELEFONO_1 = COALESCE(
        TELEFONO_1,
        TELEFONO_2,
        TELEFONO_3,
        TELEFONO_4,
        TELEFONO_5
    ),
    TELEFONO_2 = CASE
        WHEN TELEFONO_1 = TELEFONO_2 THEN COALESCE(TELEFONO_3, TELEFONO_4, TELEFONO_5, NULL)
        ELSE COALESCE(
            TELEFONO_2,
            TELEFONO_3,
            TELEFONO_4,
            TELEFONO_5,
            NULL
        )
    END,
    TELEFONO_3 = CASE
        WHEN TELEFONO_1 = TELEFONO_3
        OR TELEFONO_2 = TELEFONO_3 THEN COALESCE(TELEFONO_4, TELEFONO_5, NULL)
        ELSE COALESCE(TELEFONO_3, TELEFONO_4, TELEFONO_5, NULL)
    END,
    TELEFONO_4 = CASE
        WHEN TELEFONO_1 = TELEFONO_4
        OR TELEFONO_2 = TELEFONO_4
        OR TELEFONO_3 = TELEFONO_4 THEN COALESCE(TELEFONO_5, NULL)
        ELSE COALESCE(TELEFONO_4, TELEFONO_5, NULL)
    END,
    TELEFONO_5 = CASE
        WHEN TELEFONO_1 = TELEFONO_5
        OR TELEFONO_2 = TELEFONO_5
        OR TELEFONO_3 = TELEFONO_5
        OR TELEFONO_4 = TELEFONO_5 THEN NULL
        ELSE TELEFONO_5
    END;

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