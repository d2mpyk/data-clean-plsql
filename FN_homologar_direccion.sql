CREATE DEFINER=`homologacion`@`%` FUNCTION `FN_homologar_direccion`(texto varchar(300)) RETURNS varchar(300) CHARSET latin1
BEGIN
  -- Convertir texto a mayúsculas
  SET texto = UPPER(texto);

  -- Corrección de caracteres mal codificados
  SET texto = REPLACE(texto, 'Ã¡', 'Á');
  SET texto = REPLACE(texto, 'Ã­A', 'ÍA');
	SET texto = REPLACE(texto, 'Ã­', 'Í');  
	SET texto = REPLACE(texto, 'Â¿', 'Í');
  SET texto = REPLACE(texto, 'Ã©', 'É');
  SET texto = REPLACE(texto, 'Ã³', 'Ó');
  SET texto = REPLACE(texto, 'Ãº', 'Ú');
  SET texto = REPLACE(texto, 'Ã±', 'Ñ');
	SET texto = REPLACE(texto, 'Ã‘', 'Ñ'); 

  -- Normalización de caracteres especiales
  SET texto = REPLACE(texto, 'Ñ', 'N');
  SET texto = REPLACE(texto, 'Ž', 'N');
  SET texto = REPLACE(texto, 'ñ', 'N');
  SET texto = REPLACE(texto, 'ð', 'N');
  SET texto = REPLACE(texto, 'Ã±', 'N');
  SET texto = REPLACE(texto, CHAR(203), 'N');

  -- Eliminación de tildes
  SET texto = REPLACE(texto, 'Á', 'A');
  SET texto = REPLACE(texto, 'É', 'E');
  SET texto = REPLACE(texto, 'Í', 'I');
  SET texto = REPLACE(texto, 'Ó', 'O');
  SET texto = REPLACE(texto, 'Ú', 'U');
  SET texto = REPLACE(texto, 'Ü', 'U');
  SET texto = REPLACE(texto, 'ü', 'U');

  -- Eliminación de caracteres especiales y símbolos innecesarios
  SET texto = REPLACE(texto, '#', 'N');
  SET texto = REPLACE(texto, '%', 'N');
  SET texto = REPLACE(texto, '/', 'N');
  SET texto = REPLACE(texto, '\\', 'N');
  SET texto = REPLACE(texto, '|', '');
  SET texto = REPLACE(texto, '¿', 'n');
  SET texto = REPLACE(texto, '?', 'n');
  SET texto = REPLACE(texto, 'D´', 'DE');
  SET texto = REPLACE(texto, '´', '');
  SET texto = REPLACE(texto, '"', '');
  SET texto = REPLACE(texto, '''', '');
  SET texto = REPLACE(texto, '+', '');
  SET texto = REPLACE(texto, '<', '');
  SET texto = REPLACE(texto, '>', '');
  SET texto = REPLACE(texto, ',', '');
  SET texto = REPLACE(texto, ':', '_');
  SET texto = REPLACE(texto, ';', '_');
  SET texto = REPLACE(texto, '}', '');

  -- Corrección de números y otros caracteres
  SET texto = REPLACE(texto, 'Ã', 'N');
  SET texto = REPLACE(texto, '-', '_');

  -- Convertir a minúsculas al final
  SET texto = LOWER(texto);

  RETURN texto;
END