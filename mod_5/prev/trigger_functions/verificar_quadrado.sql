CREATE OR REPLACE FUNCTION 
	VerificarQuadradoAtrelado()
RETURNS TRIGGER AS $VerificarQuadradoAtrelado$

DECLARE
  quadrado_row quadrado%ROWTYPE;

BEGIN
  SELECT * into quadrado_row from Quadrado where Coordenadas = NEW.Coordenadas;

  IF (quadrado_row IS NOT NULL) THEN
    RAISE NOTICE 'Quadrado ja está atrelado!';
    RETURN NULL;
  END IF;

	RETURN NEW;
END;
$VerificarQuadradoAtrelado$ LANGUAGE plpgsql;

CREATE TRIGGER VerificarQuadrado
	BEFORE INSERT OR UPDATE ON Quadrado
FOR EACH ROW EXECUTE PROCEDURE VerificarQuadradoAtrelado();