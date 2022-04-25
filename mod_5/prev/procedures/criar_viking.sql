CREATE OR REPLACE FUNCTION 
	criar_viking(nome VARCHAR(100))
RETURNS VOID AS $$

DECLARE
  id_mochila INTEGER;
  quadrado_inicial_viking VARCHAR(20);
  id_instancia_item INTEGER;
BEGIN
  INSERT INTO Personagem (Nome, Tipo) VALUES (nome, 'viking');
  id_mochila := nextval('id_mochila_sequence');
  INSERT INTO Mochila VALUES (id_mochila, 'basica');
  quadrado_inicial_viking := '8,0';
  INSERT INTO Viking
    (Nome, Experiencia, Nivel, Mochila, Quadrado, Ataque, Defesa, Roubo_de_Vida, Agilidade, Velocidade, Nivel_de_Vida, Vida_Restante)
  VALUES (nome, 0, 1, id_mochila, quadrado_inicial_viking, 10, 10, 1, 5, 5, 100, 100);
  INSERT INTO InstanciaBarco 
    (IdBarco, Tipo, NomeViking, Nome, Integridade, Coordenadas)
  VALUES (nextval('id_instancia_barco_seq'), 'knarr', nome, 'Barco comercial', 100, '9,15');

  -- Adiciona um item do tipo 'Carne' (Id_item = 10) à mochila
  id_instancia_item := nextval('id_instancia_item_seq');
  INSERT INTO Instancia_item (Id, Id_item, Quadrado) VALUES (id_instancia_item, 10, NULL);
  INSERT INTO Item_Mochila VALUES (id_mochila, id_instancia_item);
  
  -- Adiciona um item do tipo 'Poção de vida' (Id_item = 11) na tabela de instancia de itens
  id_instancia_item := nextval('id_instancia_item_seq');
  INSERT INTO Instancia_item (Id, Id_item, Quadrado) VALUES (id_instancia_item, 11, NULL);
  INSERT INTO Item_Mochila VALUES (id_mochila, id_instancia_item);

END;
$$ LANGUAGE plpgsql;