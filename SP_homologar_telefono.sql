CREATE DEFINER=`homologacion`@`%` PROCEDURE `SP_homologar_telefono`(param_campo varchar(50),param_tabla varchar(50))
BEGIN
  -- NOTA DE USO: CALL SP_homologar_telefono(<CAMPO>, <BASE>);
  SET @query= CONCAT('UPDATE ',param_tabla,' SET ',param_campo,'= FN_homologar_telefono(',param_campo,')');
  PREPARE stmt FROM @query;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END