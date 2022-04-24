CREATE OR REPLACE FUNCTION 
	criar_instancias_itens_iniciais_mapa()
RETURNS VOID AS $$

BEGIN
  
  -- Itens pelo mapa de jogo

  -- Tipo 'Machado' Quadrado '1,1'
  INSERT INTO Instancia_item (Id, Id_item, Quadrado) VALUES (nextval('id_instancia_item_seq'), 1, '1,1');
  -- Tipo 'Cereais' Quadrado '10,2'
  INSERT INTO Instancia_item (Id, Id_item, Quadrado) VALUES (nextval('id_instancia_item_seq'), 10, '10,2');
  -- Tipo 'Peixe' Quadrado '0,15'
  INSERT INTO Instancia_item (Id, Id_item, Quadrado) VALUES (nextval('id_instancia_item_seq'), 6, '0,15');
  -- Tipo 'Peixe' Quadrado '11,16'
  INSERT INTO Instancia_item (Id, Id_item, Quadrado) VALUES (nextval('id_instancia_item_seq'), 6, '11,16');
  -- Tipo 'Fruta Seca' Quadrado '1,9'
  INSERT INTO Instancia_item (Id, Id_item, Quadrado) VALUES (nextval('id_instancia_item_seq'), 9, '1,9');
  -- Tipo 'Fruta Seca' Quadrado '14,3'
  INSERT INTO Instancia_item (Id, Id_item, Quadrado) VALUES (nextval('id_instancia_item_seq'), 9, '14,3');
  -- Tipo 'Poção de ataque' Quadrado '12,7'
  INSERT INTO Instancia_item (Id, Id_item, Quadrado) VALUES (nextval('id_instancia_item_seq'), 12, '12,7');


END;
$$ LANGUAGE plpgsql;