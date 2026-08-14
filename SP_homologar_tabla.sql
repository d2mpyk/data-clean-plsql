CREATE DEFINER=`homologacion`@`%` PROCEDURE `SP_homologar_tabla`(prm_campo varchar(50),prm_tabla varchar(50))
BEGIN
  -- NOTA DE USO: CALL SP_homologar_tabla(<CAMPO>, <BASE>);
  SET @query= CONCAT('UPDATE ',prm_tabla,' SET ',prm_campo,'= FN_homologar(',prm_campo,')');
  PREPARE stmt FROM @query;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END