CREATE OR REPLACE FUNCTION 
	atualizar_volume_ocupado_mochila()
RETURNS TRIGGER AS $atualizar_volume_ocupado_mochila$

DECLARE 

  volume_ocupado_atual INTEGER;
  peso_item INTEGER;
  tableName VARCHAR(50);
  capacidade_mochila INTEGER;

BEGIN

  IF (TG_OP = 'INSERT') THEN
    SELECT Especializacao_do_item.tipo INTO tableName
    FROM Instancia_item
    INNER JOIN Especializacao_do_item
    ON Instancia_item.Id_item = Especializacao_do_item.Id
    WHERE Instancia_item.Id = NEW.Id_item;

    IF (tableName = 'arma') THEN
      SELECT ItemEspecializado.peso INTO peso_item
      FROM Instancia_item
      INNER JOIN Especializacao_do_item 
      ON Especializacao_do_item.Id = Instancia_item.Id_Item
      INNER JOIN "arma" ItemEspecializado
      ON ItemEspecializado.id = Especializacao_do_item.Id
      WHERE Instancia_item.id = NEW.Id_item;
    ELSIF (tableName = 'armadura') THEN
      SELECT ItemEspecializado.peso INTO peso_item
      FROM Instancia_item
      INNER JOIN Especializacao_do_item 
      ON Especializacao_do_item.Id = Instancia_item.Id_Item
      INNER JOIN "armadura" ItemEspecializado
      ON ItemEspecializado.id = Especializacao_do_item.Id
      WHERE Instancia_item.id = NEW.Id_item;
    ELSIF (tableName = 'pocao') THEN
      SELECT ItemEspecializado.peso INTO peso_item
      FROM Instancia_item
      INNER JOIN Especializacao_do_item 
      ON Especializacao_do_item.Id = Instancia_item.Id_Item
      INNER JOIN "pocao" ItemEspecializado
      ON ItemEspecializado.id = Especializacao_do_item.Id
      WHERE Instancia_item.id = NEW.Id_item;
    ELSIF (tableName = 'comida') THEN
      SELECT ItemEspecializado.peso INTO peso_item
      FROM Instancia_item
      INNER JOIN Especializacao_do_item 
      ON Especializacao_do_item.Id = Instancia_item.Id_Item
      INNER JOIN "comida" ItemEspecializado
      ON ItemEspecializado.id = Especializacao_do_item.Id
      WHERE Instancia_item.id = NEW.Id_item;

    END IF;

    SELECT VolumeOcupado INTO volume_ocupado_atual FROM Mochila WHERE Numero = NEW.Numero_mochila;
    SELECT Tipo_mochila.capacidade INTO capacidade_mochila
    FROM Mochila 
    INNER JOIN Tipo_mochila
    ON Tipo_mochila.nome = Mochila.tipo
    WHERE Mochila.Numero = NEW.Numero_mochila;

    IF ((volume_ocupado_atual + peso_item) > capacidade_mochila) THEN
      RAISE EXCEPTION 'O item não pode ser adicionado na mochila, pois ultrapassa o volume máximo disponível';
      RETURN NULL;
    ELSE
      UPDATE Mochila SET VolumeOcupado = volume_ocupado_atual + peso_item
      WHERE Numero = NEW.Numero_mochila;
      RETURN NEW;
    END IF;

  ELSIF (TG_OP = 'DELETE') THEN
    SELECT Especializacao_do_item.tipo INTO tableName
    FROM Instancia_item
    INNER JOIN Especializacao_do_item
    ON Instancia_item.Id_item = Especializacao_do_item.Id
    WHERE Instancia_item.Id = OLD.Id_item;

    IF (tableName = 'arma') THEN
      SELECT ItemEspecializado.peso INTO peso_item
      FROM Instancia_item
      INNER JOIN Especializacao_do_item 
      ON Especializacao_do_item.Id = Instancia_item.Id_Item
      INNER JOIN "arma" ItemEspecializado
      ON ItemEspecializado.id = Especializacao_do_item.Id
      WHERE Instancia_item.id = OLD.Id_item;
    ELSIF (tableName = 'armadura') THEN
      SELECT ItemEspecializado.peso INTO peso_item
      FROM Instancia_item
      INNER JOIN Especializacao_do_item 
      ON Especializacao_do_item.Id = Instancia_item.Id_Item
      INNER JOIN "armadura" ItemEspecializado
      ON ItemEspecializado.id = Especializacao_do_item.Id
      WHERE Instancia_item.id = OLD.Id_item;
    ELSIF (tableName = 'pocao') THEN
      SELECT ItemEspecializado.peso INTO peso_item
      FROM Instancia_item
      INNER JOIN Especializacao_do_item 
      ON Especializacao_do_item.Id = Instancia_item.Id_Item
      INNER JOIN "pocao" ItemEspecializado
      ON ItemEspecializado.id = Especializacao_do_item.Id
      WHERE Instancia_item.id = OLD.Id_item;
    ELSIF (tableName = 'comida') THEN
      SELECT ItemEspecializado.peso INTO peso_item
      FROM Instancia_item
      INNER JOIN Especializacao_do_item 
      ON Especializacao_do_item.Id = Instancia_item.Id_Item
      INNER JOIN "comida" ItemEspecializado
      ON ItemEspecializado.id = Especializacao_do_item.Id
      WHERE Instancia_item.id = OLD.Id_item;

    END IF;

    UPDATE Mochila SET VolumeOcupado = VolumeOcupado - peso_item
    WHERE Numero = OLD.Numero_Mochila;
  END IF;

	RETURN OLD;
END;
$atualizar_volume_ocupado_mochila$ LANGUAGE plpgsql;

CREATE TRIGGER AtualizarVolumeOcupado
	BEFORE INSERT OR DELETE ON Item_Mochila
FOR EACH ROW EXECUTE PROCEDURE atualizar_volume_ocupado_mochila();
