CREATE OR REPLACE FUNCTION 
	verificar_maos_ocupadas()
RETURNS TRIGGER AS $verificar_maos_ocupadas$

BEGIN
  IF (NEW.MaoEsquerda IS NOT NULL AND NEW.MaoDireita IS NOT NULL)  THEN
    NEW.MaosOcupadas := TRUE;
  ELSE
    NEW.MaosOcupadas := FALSE;
  END IF;

	RETURN NEW;
END;
$verificar_maos_ocupadas$ LANGUAGE plpgsql;

CREATE TRIGGER PreencherVariavelMaosOcupadas
	BEFORE INSERT OR UPDATE ON Viking
FOR EACH ROW EXECUTE PROCEDURE verificar_maos_ocupadas();