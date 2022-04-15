CREATE OR REPLACE FUNCTION 
	criar_viking(nome VARCHAR(100))
RETURNS VOID AS $$

DECLARE
  id_mochila INTEGER;
BEGIN
  INSERT INTO Personagem (Nome, Tipo) VALUES (nome, 'viking');
  id_mochila := nextval('id_mochila_sequence');
  INSERT INTO Mochila VALUES (id_mochila, 'basica');
  INSERT INTO Viking
    (Nome, Experiencia, Nivel, Mochila, Quadrado, Ataque, Defesa, Roubo_de_Vida, Agilidade, Velocidade, Nivel_de_Vida, Vida_Restante)
  VALUES (nome, 0, 1, id_mochila, '8,0', 10, 10, 1, 5, 5, 100, 100);

END;
$$ LANGUAGE plpgsql;