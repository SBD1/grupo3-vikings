CREATE OR REPLACE FUNCTION 
	criar_itens()
RETURNS VOID AS $$

DECLARE 

BEGIN
  INSERT INTO Especializacao_do_item (Id, Tipo) VALUES (1, 'arma', false);
  INSERT INTO Especializacao_do_item VALUES (2, 'arma', false);
  INSERT INTO Especializacao_do_item VALUES (3, 'arma', false);
  INSERT INTO Especializacao_do_item VALUES (4, 'arma', false);
  INSERT INTO Especializacao_do_item VALUES (5, 'arma', false);

  INSERT INTO Arma 
    (Id, Nome, Descricao, Raridade, Peso, Valor_de_ataque, Valor_de_defesa, Valor_de_agilidade) 
  VALUES (1, 'Machado', 'Machado corta cabeças', 'comum', 20, 30, 4, 3);
  INSERT INTO Arma VALUES (2, 'Espada', 'Espada de prata','comum', 12, 70, 2, 90);
  INSERT INTO Arma VALUES (3, 'Faca', 'Faca simples', 'comum', 3, 70, 2, 90);
  INSERT INTO Arma VALUES (4, 'Lança', 'Ponta de metal', 'comum', 8, 70, 2, 90);
  INSERT INTO Arma VALUES (5, 'Porrete', 'Ideal para viagens de saque', 'comum', 8, 70, 2, 90);

  INSERT INTO Especializacao_do_item (Id, Tipo) VALUES (6, 'comida', true);
  INSERT INTO Especializacao_do_item VALUES (7, 'comida', true);
  INSERT INTO Especializacao_do_item VALUES (8, 'comida', true);
  INSERT INTO Especializacao_do_item VALUES (9, 'comida', true);
  INSERT INTO Especializacao_do_item VALUES (10, 'comida', true);

  INSERT INTO Comida
    (Id, Nome, Descricao, Raridade, Peso, Valor_de_cura)
  VALUES (6, 'Peixe', 'Principal refeição', 'comum', 6, 100);
  INSERT INTO Comida VALUES (7, 'Cereais', 'Cereal', 'comum', 6, 100);
  INSERT INTO Comida VALUES (8, 'Pão', 'Pão Baguete', 'comum', 6, 100);
  INSERT INTO Comida VALUES (9, 'Fruta Seca', 'Alguma fruta', 'comum', 6, 100);
  INSERT INTO Comida VALUES (10, 'Carne', 'Alguma Carne', 'comum', 6, 100);

  INSERT INTO Especializacao_do_item (Id, Tipo) VALUES (11, 'pocao', true);
  INSERT INTO Especializacao_do_item VALUES (12, 'pocao', true);
  INSERT INTO Especializacao_do_item VALUES (13, 'pocao', true);

  INSERT INTO Pocao
    (Id, Nome, Descricao, Raridade, Peso, Bonus, Duracao)
  VALUES (11, 'Poção de Vida', 'Recupera sua vida instantaneamente', 'comum', 2, 70, 30);
  INSERT INTO Pocao VALUES (12, 'Poção de Ataque', 'Aumenta o seu poder de ataque por alguns segundos', 'comum', 2, 40, 30);
  INSERT INTO Pocao VALUES (13, 'Poção de Defesa', 'Aumenta o seu poder defensivo por alguns segundos', 'comum', 2, 40, 30);
  
  INSERT INTO Especializacao_do_item (Id, Tipo) VALUES (14, 'armadura', false);
  INSERT INTO Especializacao_do_item VALUES (15, 'armadura', false);

  INSERT INTO Armadura
    (Id, Nome, Descricao, Raridade, Peso, Valor_de_defesa, Valor_de_agilidade)
  VALUES (14, 'Armadura Básica', 'Te protege de ataques básicos', 'comum', 2, 70, 30);
  INSERT INTO Armadura VALUES (15, 'Armadura Reforçada', 'Te proteje dos principais ataques', 'comum', 2, 100, 30);

END;
$$ LANGUAGE plpgsql;