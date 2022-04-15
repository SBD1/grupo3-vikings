CREATE OR REPLACE FUNCTION 
	atribuir_se_item_consumivel()
RETURNS TRIGGER AS $atribuir_se_item_consumivel$

BEGIN
  IF (NEW.Tipo = 'comida' OR NEW.Tipo = 'pocao') THEN
    NEW.Consumivel := TRUE;
  ELSE
    NEW.Consumivel := FALSE;
  END IF;
	RETURN NEW;
END;
$atribuir_se_item_consumivel$ LANGUAGE plpgsql;

CREATE TRIGGER AtribuirItemConsumivel
	BEFORE INSERT ON Especializacao_do_item
FOR EACH ROW EXECUTE PROCEDURE atribuir_se_item_consumivel();
