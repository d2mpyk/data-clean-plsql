CREATE DEFINER=`homologacion`@`%` FUNCTION `FN_homologar_telefono`(texto varchar(300)) RETURNS varchar(300) CHARSET latin1
BEGIN
  -- Convertimos el texto en minusculas
	SET texto = LOWER(texto);
  -- Reemplazamos 'o' por '0'
  SET texto = REPLACE(texto, 'o', '0');
  -- Eliminamos todo menos los números
  SET texto = REGEXP_REPLACE(texto, '[^0-9]', '');
  
  RETURN texto;
END