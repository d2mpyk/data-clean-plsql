CREATE DEFINER=`homologacion`@`%` FUNCTION `FN_homologar_telefono`(texto varchar(300)) RETURNS varchar(300) CHARSET latin1
BEGIN
  -- Convertimos el texto en minusculas
	SET texto = LOWER(texto);
  -- Eliminamos todas las letras (incluyendo tildes y ñ) y otros caracteres no deseados
  SET texto = REGEXP_REPLACE(texto, '[a-záéíóúàèìòùäëïöüâêîôûñ]', '');
  -- Eliminamos espacios, guiones, puntos, comas, paréntesis, barras y asteriscos
  SET texto = REGEXP_REPLACE(texto, '[ \-.,()/\*]', '');
  -- Reemplazamos 'o' por '0'
  SET texto = REPLACE(texto, 'o', '0');
  RETURN texto;
END