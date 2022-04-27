CREATE OR REPLACE FUNCTION 
	verificar_quadrado_barco()
RETURNS TRIGGER AS $verificar_quadrado_barco$

DECLARE
  id_area_mar INTEGER;
  quadrado_row quadrado%ROWTYPE;

BEGIN
  id_area_mar := 4;
  SELECT * INTO quadrado_row FROM Quadrado WHERE Coordenadas = NEW.Coordenadas;
  IF (quadrado_row.area != id_area_mar) THEN
    RAISE NOTICE 'O Barco não pode estar fora da área "Mar"';
    RETURN NULL;
  ELSE
    RETURN NEW;
  END IF;

END;
$verificar_quadrado_barco$ LANGUAGE plpgsql;

CREATE TRIGGER VerificarQuadradoBarco
	BEFORE INSERT OR UPDATE ON InstanciaBarco
FOR EACH ROW EXECUTE PROCEDURE verificar_quadrado_barco();