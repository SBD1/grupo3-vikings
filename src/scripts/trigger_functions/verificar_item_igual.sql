CREATE OR REPLACE FUNCTION 
	verificar_id_repetido()
RETURNS TRIGGER AS $verificar_id_repetido$

DECLARE
  viking_row viking%ROWTYPE;
BEGIN
  IF (NEW.MaoEsquerda = NEW.MaoDireita)
  THEN
    RAISE EXCEPTION 'A mesma instância de item está sendo adicionada nas duas mãos';
  END IF;
  SELECT * into viking_row from Viking where MaoEsquerda = NEW.MaoDireita OR MaoDireita = NEW.MaoEsquerda;
  IF (viking_row IS NULL) 
  THEN
    RETURN NEW;
  ELSE
    RAISE EXCEPTION 'Item já referenciado por outra coluna';
  END IF;
  RETURN NULL;
END;
$verificar_id_repetido$ LANGUAGE plpgsql;

CREATE TRIGGER VerificarSeIdIgual
	BEFORE INSERT OR UPDATE ON Viking
FOR EACH ROW EXECUTE PROCEDURE verificar_id_repetido();