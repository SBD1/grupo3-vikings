CREATE OR REPLACE FUNCTION 
	criar_viking(nome VARCHAR(100))
RETURNS VOID AS $$

DECLARE
  id_mochila INTEGER;
  quadrado_inicial_viking VARCHAR(20);
BEGIN
  INSERT INTO Personagem (Nome, Tipo) VALUES (nome, 'viking');
  id_mochila := nextval('id_mochila_sequence');
  INSERT INTO Mochila VALUES (id_mochila, 'basica');
  quadrado_inicial_viking := '8,0';
  INSERT INTO Viking
    (Nome, Experiencia, Nivel, Mochila, Quadrado, Ataque, Defesa, Roubo_de_Vida, Agilidade, Velocidade, Nivel_de_Vida, Vida_Restante)
  VALUES (nome, 0, 1, id_mochila, quadrado_inicial_viking, 10, 10, 1, 5, 5, 100, 100);

END;
$$ LANGUAGE plpgsql;