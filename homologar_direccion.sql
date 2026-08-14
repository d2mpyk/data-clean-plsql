CREATE DEFINER=`homologacion`@`%` PROCEDURE `homologar_direccion`(prm_campo varchar(50),prm_tabla varchar(50))
BEGIN
  SET @query= CONCAT('UPDATE ',prm_tabla,' SET ',prm_campo,'= FN_homologar_direccion(',prm_campo,')');
  PREPARE stmt FROM @query;
  EXECUTE stmt;
END