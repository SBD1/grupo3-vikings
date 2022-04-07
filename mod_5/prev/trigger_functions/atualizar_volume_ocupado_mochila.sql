CREATE OR REPLACE FUNCTION 
	atualizar_volume_ocupado_mochila()
RETURNS TRIGGER AS $atualizar_volume_ocupado_mochila$

BEGIN
  IF (TG_OP = 'INSERT') THEN
    UPDATE Mochila SET VolumeOcupado = VolumeOcupado + 1
    WHERE Numero = NEW.Numero_Mochila;

  ELSIF (TG_OP = 'DELETE') THEN
    UPDATE Mochila SET VolumeOcupado = VolumeOcupado - 1
    WHERE Numero = OLD.Numero_Mochila;
  END IF;

	RETURN NULL;
END;
$atualizar_volume_ocupado_mochila$ LANGUAGE plpgsql;

CREATE TRIGGER AtualizarVolumeOcupado
	AFTER INSERT OR DELETE ON Item_Mochila
FOR EACH ROW EXECUTE PROCEDURE atualizar_volume_ocupado_mochila();
