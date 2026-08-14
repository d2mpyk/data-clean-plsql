CREATE DEFINER=`homologacion`@`%` PROCEDURE `SP_homologar_telefono`(param_campo varchar(50),param_tabla varchar(50))
BEGIN
  -- NOTA DE USO: CALL SP_homologar_telefono(TELEFONO_1, <BASE>);
  SET @query= CONCAT('UPDATE ',param_tabla,' SET ',param_campo,'= FN_homologar_telefono(',param_campo,')');
  PREPARE stmt FROM @query;
  EXECUTE stmt;
END