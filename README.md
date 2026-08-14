# Homologación de bases de datos

## Descripción

Repositorio de scripts SQL para limpiar, normalizar y homologar datos de campañas, principalmente nombres, direcciones, teléfonos, saldos e identificadores.

> Aunque el directorio se llama `PLSQL`, los scripts están escritos para MySQL/MariaDB: utilizan `CREATE DEFINER`, `PREPARE`, `EXECUTE`, `REGEXP_REPLACE`, `SUBSTRING_INDEX` y variables de sesión.

## Contenido

| Archivo | Propósito |
| --- | --- |
| `Validaciones_iniciales.sql` | Limpieza y validaciones iniciales sobre una tabla de campaña. Incluye nombres, saldos, teléfonos e ID. |
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

## Hallazgos y riesgos

### Hallazgos actuales fuera del alcance excluido

- `Validaciones_iniciales.sql` utiliza `CREATE TEMPORARY TABLE`, CTE y `ROW_NUMBER()` en las líneas 224–269. El repositorio no declara una versión mínima de MySQL/MariaDB, por lo que el script puede fallar en motores sin soporte para esa combinación.
- La tabla temporal `tmp_telefonos_pivot` se crea con un nombre fijo en la línea 224. Si una ejecución anterior termina antes de la línea 281, una nueva ejecución puede fallar porque la tabla temporal ya existe. Conviene iniciar con `DROP TEMPORARY TABLE IF EXISTS tmp_telefonos_pivot`.
- El reordenamiento agrupa y enlaza únicamente por `ID` en las líneas 246–249 y 271–273. Si `ID` no es único, teléfonos de diferentes registros pueden mezclarse y el `UPDATE` puede afectar más de una fila por resultado.
- La solución exige que exista la columna `ID` y que tenga el mismo tipo y representación en la tabla origen y en la tabla temporal. No hay una validación previa de esa clave.
- La lógica está fija a cinco columnas (`TELEFONO_1` a `TELEFONO_5`) en múltiples secciones; agregar o reducir teléfonos requiere editar manualmente el script.
- El repositorio no incluye un esquema mínimo que documente tipos, índices o restricciones esperadas para `ID`, `SALDO`, `NOMBRE` y los cinco teléfonos.

## Recomendaciones prioritarias

1. Documentar la versión mínima compatible y probar `WITH`, `ROW_NUMBER()` y `CREATE TEMPORARY TABLE` en el motor objetivo.
2. Agregar `DROP TEMPORARY TABLE IF EXISTS tmp_telefonos_pivot` antes de crear la tabla temporal.
3. Confirmar que `ID` sea una clave única; si no lo es, usar la clave primaria real en el `GROUP BY` y el `JOIN`.
4. Validar la existencia y el tipo de `ID` antes de ejecutar el reordenamiento.
5. Documentar explícitamente el límite de cinco teléfonos o parametrizar el diseño.
6. Añadir un esquema de referencia o contrato de columnas para las tablas que consumen estos scripts.

## Estado actual

El repositorio contiene utilidades SQL reutilizables. Esta revisión excluye deliberadamente los placeholders, delimitadores, SQL dinámico, transacciones/auditoría/manejo de errores/pruebas, `DEFINER`, `latin1`, duplicación y transformaciones de datos. Los hallazgos documentados aquí se concentran en compatibilidad del motor, reutilización de tablas temporales, integridad de la clave de enlace y supuestos de esquema.
