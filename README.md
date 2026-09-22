# Homologación de bases de datos

## Descripción

Repositorio de scripts SQL para limpiar, normalizar y homologar datos de campañas, principalmente nombres, direcciones, teléfonos, email's, saldos e identificadores.

> Aunque el directorio se llama `PLSQL`, los scripts están escritos para MySQL/MariaDB: utilizan `CREATE DEFINER`, `PREPARE`, `EXECUTE`, `REGEXP_REPLACE`, `SUBSTRING_INDEX` y variables de sesión.

> Sugerencia de versiones: MySQL 8.0+ - MariaDB 10.2+

> Importante: Las consultas están diseñadas para tablas con 5 números de telefonos

## Contenido

| Archivo | Propósito |
| --- | --- |
| `Validaciones_iniciales.sql` | Limpieza y validaciones iniciales sobre una tabla de campaña. Incluye nombres, saldos, teléfonos e ID. |
| `Validaciones_iniciales_EMAIL.sql` | Limpieza y validaciones iniciales sobre una tabla de campaña, solo para email's. Incluye email, ID, ID_CAMPANIA. |
| `FN_homologar.sql` | Función genérica de normalización de texto. |
| `FN_homologar_direccion.sql` | Normalización de direcciones, caracteres especiales y problemas de codificación. |
| `FN_homologar_telefono.sql` | Limpieza de teléfonos y eliminación de caracteres no deseados. |
| `SP_homologar_tabla.sql` | Procedimiento para aplicar `FN_homologar` a un campo de una tabla. |
| `SP_homologar_direccion.sql` | Procedimiento para aplicar `FN_homologar_direccion` a un campo. |
| `SP_homologar_telefono.sql` | Procedimiento para aplicar `FN_homologar_telefono` a un campo. |

Los archivos anteriores `homologar_tabla.sql` y `homologar_direccion.sql` fueron reemplazados en el estado de trabajo por sus equivalentes `SP_*`.

## Flujo sugerido

1. Trabajar sobre una copia o respaldo de la tabla origen.
2. Sustituir todos los placeholders de `Validaciones_iniciales.sql`, especialmente `< BASE >` y `< 'CAMPAÑA' >`.
3. Corregir y probar el script en un entorno de desarrollo.
4. Ejecutar las validaciones iniciales y revisar sus conteos.
5. Crear las funciones y procedimientos requeridos.
6. Aplicar la homologación por campo.
7. Verificar resultados, duplicados, valores nulos y longitudes antes de promover los cambios.

Ejemplos de uso de los procedimientos:

```sql
CALL SP_homologar_tabla('NOMBRE', 'mi_tabla');
CALL SP_homologar_direccion('DIRECCION', 'mi_tabla');
CALL SP_homologar_telefono('TELEFONO_1', 'mi_tabla');
```

Los nombres de tabla y campo deben provenir de una lista controlada. No se deben aceptar directamente desde entradas de usuario.
