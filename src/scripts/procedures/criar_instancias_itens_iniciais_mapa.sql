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
  -- Tipo 'Peixe' Quadrado '0,15'
  INSERT INTO Instancia_item (Id, Id_item, Quadrado) VALUES (nextval('id_instancia_item_seq'), 6, '0,15');
  -- Tipo 'Peixe' Quadrado '0,15'
  INSERT INTO Instancia_item (Id, Id_item, Quadrado) VALUES (nextval('id_instancia_item_seq'), 6, '0,15');
  -- Tipo 'Peixe' Quadrado '11,16'
  INSERT INTO Instancia_item (Id, Id_item, Quadrado) VALUES (nextval('id_instancia_item_seq'), 6, '11,16');
  -- Tipo 'Peixe' Quadrado '15,23'
  INSERT INTO Instancia_item (Id, Id_item, Quadrado) VALUES (nextval('id_instancia_item_seq'), 6, '15,23');
  -- Tipo 'Fruta Seca' Quadrado '1,9'
  INSERT INTO Instancia_item (Id, Id_item, Quadrado) VALUES (nextval('id_instancia_item_seq'), 9, '1,9');
  -- Tipo 'Fruta Seca' Quadrado '14,3'
  INSERT INTO Instancia_item (Id, Id_item, Quadrado) VALUES (nextval('id_instancia_item_seq'), 9, '14,3');
  -- Tipo 'Poção de vida' Quadrado '12,7'
  INSERT INTO Instancia_item (Id, Id_item, Quadrado) VALUES (nextval('id_instancia_item_seq'), 11, '12,7');
  -- Tipo 'Poção de ataque' Quadrado '12,7'
  INSERT INTO Instancia_item (Id, Id_item, Quadrado) VALUES (nextval('id_instancia_item_seq'), 12, '12,7');
  -- Tipo 'Poção de defesa' Quadrado '12,7'
  INSERT INTO Instancia_item (Id, Id_item, Quadrado) VALUES (nextval('id_instancia_item_seq'), 13, '12,7');
  -- Tipo 'Lança' Quadrado '8,8'
  INSERT INTO Instancia_item (Id, Id_item, Quadrado) VALUES (nextval('id_instancia_item_seq'), 4, '8,8');
  -- Tipo 'Pão' Quadrado '8,8'
  INSERT INTO Instancia_item (Id, Id_item, Quadrado) VALUES (nextval('id_instancia_item_seq'), 8, '8,8');


END;
$$ LANGUAGE plpgsql;