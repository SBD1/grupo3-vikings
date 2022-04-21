CREATE OR REPLACE FUNCTION 
	verificar_area_viking()
RETURNS TRIGGER AS $verificar_area_viking$

DECLARE
  area_pretendida VARCHAR(20);
  viking_row viking%ROWTYPE;
  instancia_barco_row instanciaBarco%ROWTYPE;
BEGIN

  SELECT area.tipo INTO area_pretendida FROM quadrado JOIN area ON quadrado.area = area.idArea WHERE quadrado.coordenadas = NEW.quadrado;
  SELECT * INTO instancia_barco_row FROM instanciaBarco WHERE instanciaBarco.Coordenadas = NEW.quadrado AND instanciaBarco.NomeViking = NEW.Nome;
  IF (area_pretendida = 'Mar' AND instancia_barco_row IS NULL) THEN
    RAISE EXCEPTION 'Não é possível se movimentar na área "Mar" sem estar em um barco!';
    RETURN NULL;
  END IF;
  RETURN NEW;
END;
$verificar_area_viking$ LANGUAGE plpgsql;

CREATE TRIGGER VerificarArea
	BEFORE UPDATE ON Viking
FOR EACH ROW EXECUTE PROCEDURE verificar_area_viking();