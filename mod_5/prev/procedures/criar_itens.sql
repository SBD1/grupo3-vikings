CREATE OR REPLACE FUNCTION 
	criar_itens()
RETURNS VOID AS $$

BEGIN
  INSERT INTO Especializacao_do_item (Id, Tipo) VALUES (1, 'arma');
  INSERT INTO Especializacao_do_item VALUES (2, 'arma');
  INSERT INTO Especializacao_do_item VALUES (3, 'arma');
  INSERT INTO Especializacao_do_item VALUES (4, 'arma');
  INSERT INTO Especializacao_do_item VALUES (5, 'arma');

  INSERT INTO Arma 
    (Id, Nome, Descricao, Raridade, Peso, Valor_de_ataque, Valor_de_defesa, Valor_de_agilidade) 
  VALUES (1, 'Machado', 'Machado corta cabeças', 'comum', 7, 30, 4, 3);
  INSERT INTO Arma VALUES (2, 'Espada', 'Espada de prata','comum', 6, 70, 2, 90);
  INSERT INTO Arma VALUES (3, 'Faca', 'Faca simples', 'comum', 1, 70, 2, 90);
  INSERT INTO Arma VALUES (4, 'Lança', 'Ponta de metal', 'comum', 6, 70, 2, 90);
  INSERT INTO Arma VALUES (5, 'Porrete', 'Ideal para viagens de saque', 'comum', 7, 70, 2, 90);

  INSERT INTO Especializacao_do_item (Id, Tipo) VALUES (6, 'comida');
  INSERT INTO Especializacao_do_item VALUES (7, 'comida');
  INSERT INTO Especializacao_do_item VALUES (8, 'comida');
  INSERT INTO Especializacao_do_item VALUES (9, 'comida');
  INSERT INTO Especializacao_do_item VALUES (10, 'comida');

  INSERT INTO Comida
    (Id, Nome, Descricao, Raridade, Peso, Valor_de_cura)
  VALUES (6, 'Peixe', 'Principal refeição', 'comum', 1, 100);
  INSERT INTO Comida VALUES (7, 'Cereais', 'Cereal', 'comum', 1, 100);
  INSERT INTO Comida VALUES (8, 'Pão', 'Pão Baguete', 'comum', 1, 100);
  INSERT INTO Comida VALUES (9, 'Fruta Seca', 'Alguma fruta', 'comum', 1, 100);
  INSERT INTO Comida VALUES (10, 'Carne', 'Alguma Carne', 'comum', 1, 100);

  INSERT INTO Especializacao_do_item (Id, Tipo) VALUES (11, 'pocao');
  INSERT INTO Especializacao_do_item VALUES (12, 'pocao');
  INSERT INTO Especializacao_do_item VALUES (13, 'pocao');

  INSERT INTO Pocao
    (Id, Nome, Descricao, Raridade, Peso, Bonus, Duracao)
  VALUES (11, 'Poção de Vida', 'Recupera sua vida instantaneamente', 'comum', 1, 70, 30);
  INSERT INTO Pocao VALUES (12, 'Poção de Ataque', 'Aumenta o seu poder de ataque por alguns segundos', 'comum', 1, 40, 30);
  INSERT INTO Pocao VALUES (13, 'Poção de Defesa', 'Aumenta o seu poder defensivo por alguns segundos', 'comum', 1, 40, 30);
  
  INSERT INTO Especializacao_do_item (Id, Tipo) VALUES (14, 'armadura');
  INSERT INTO Especializacao_do_item VALUES (15, 'armadura');

  INSERT INTO Armadura
    (Id, Nome, Descricao, Raridade, Peso, Valor_de_defesa, Valor_de_agilidade)
  VALUES (14, 'Armadura Básica', 'Te protege de ataques básicos', 'comum', 6, 70, 30);
  INSERT INTO Armadura VALUES (15, 'Armadura Reforçada', 'Te protege dos principais ataques', 'comum', 8, 100, 30);

END;
$$ LANGUAGE plpgsql;