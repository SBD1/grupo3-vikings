CREATE OR REPLACE FUNCTION 
	atribuir_tamanho_area_viking()
RETURNS TRIGGER AS $atribuir_tamanho_area_viking$

BEGIN
  IF (TG_OP = 'INSERT') THEN
    UPDATE Area SET Tamanho = Tamanho + 1 WHERE IdArea = NEW.Area;

  ELSIF (TG_OP = 'DELETE') THEN
    UPDATE Area SET Tamanho = Tamanho - 1 WHERE IdArea = OLD.Area;
  END IF;
 
 RETURN NULL;
END;
$atribuir_tamanho_area_viking$ LANGUAGE plpgsql;

CREATE TRIGGER AtualizarTamanhoArea
	AFTER INSERT OR DELETE ON Quadrado
FOR EACH ROW EXECUTE PROCEDURE atribuir_tamanho_area_viking();