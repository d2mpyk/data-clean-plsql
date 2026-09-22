-- Consulltas para homologación de bases de datos
-- Validación de inicio de carga para email
-- Recuerda cambiar <BASE> por el nombre de la tabla correspondiente
-- Recuerda cambiar <ID> por el Identificador del Cliente (Cedula, Rut)
-- Recuerda cambiar <ID_CAMPANIA> por el Identificador de la Campaña
-- NOTA: No se consideran los nombres solo los email's

-- Consulta los cargados de HOY
select 'CARGADOS', count(*) from <BASE>
where date(fecha_carga)=current_date();

-- Consulta los enviados de HOY
select 'ENVIADOS',count(*) from <BASE>
where date(fecha_envio)=current_date();

-- Consulta los Pendientes de HOY
select 'PENDIENTES',count(*) from <BASE>
where fecha_envio is NULL;

-- Visualización para validación
select * from <BASE>
where date(fecha_carga)=current_date()
LIMIT 100;

-- Validar si se cargan registros repetidos (*** POR ID ***) antes de enviar correos
SELECT concat("'",id_registro,"',") from 
(select <ID>, max(id_registro) id_registro from <BASE> where date(fecha_carga)=CURRENT_DATE GROUP BY <ID>) registros
join 
(select <ID>, count(*)from <BASE>
where date(fecha_carga)=CURRENT_DATE
GROUP BY <ID>
HAVING count(*)>1) repetidos
on registros.<ID> = repetidos.<ID>;

-- Validar correos Invalidos conocidos
select concat("'",id_registro,"',"), mail_envio from <BASE>
WHERE estado_envio is null 
and mail_envio LIKE '%tiene%'
	OR mail_envio LIKE '%cliente%' 
	OR mail_envio LIKE '%tieme%' 
	OR mail_envio LIKE 'no@%' 
	OR mail_envio LIKE '%@no.c%' 
	OR mail_envio LIKE '%tieque%'
	OR mail_envio LIKE '%tieke%'
	OR mail_envio LIKE 'nohay%'
	OR mail_envio LIKE 'noentrega%'
	OR mail_envio LIKE 'n@%'
	OR mail_envio LIKE ' ';

-- Validar si el correo está mal formado
select concat("'",id_registro,"',"), mail_envio from <BASE>
WHERE estado_envio is null 
and mail_envio NOT REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

-- Consulta para Eliminar correos invalidos, o mal formados
/* DELETE from <BASE> WHERE id_registro in () */

-- Verificación FINAL de Cargados
select * from <BASE> where date(fecha_carga)=CURRENT_DATE;

-- Consulta para activación
select * from tbl_campania_mail where id_campania=<ID_CAMPANIA>;
