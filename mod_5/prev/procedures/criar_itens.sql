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
  INSERT INTO Arma VALUES (3, 'Faca', 'Faca simples', 'comum', 0.7, 70, 2, 90);
  INSERT INTO Arma VALUES (4, 'Lança', 'Ponta de metal', 'comum', 5.5, 70, 2, 90);
  INSERT INTO Arma VALUES (5, 'Porrete', 'Ideal para viagens de saque', 'comum', 7.5, 70, 2, 90);

  INSERT INTO Especializacao_do_item (Id, Tipo) VALUES (6, 'comida');
  INSERT INTO Especializacao_do_item VALUES (7, 'comida');
  INSERT INTO Especializacao_do_item VALUES (8, 'comida');
  INSERT INTO Especializacao_do_item VALUES (9, 'comida');
  INSERT INTO Especializacao_do_item VALUES (10, 'comida');

  INSERT INTO Comida
    (Id, Nome, Descricao, Raridade, Peso, Valor_de_cura)
  VALUES (6, 'Peixe', 'Principal refeição', 'comum', 0.5, 40);
  INSERT INTO Comida VALUES (7, 'Cereais', 'Aveia, Milho e Trigo', 'comum', 0.2, 15);
  INSERT INTO Comida VALUES (8, 'Pão', 'Pão Nórdico de castanhas e sementes', 'comum', 0.6, 30);
  INSERT INTO Comida VALUES (9, 'Fruta Seca', 'Fruta do bosque da Floresta negra', 'comum', 0.1, 5);
  INSERT INTO Comida VALUES (10, 'Carne', 'A iguaria que te dará mais nutrientes', 'comum', 2, 85);

  INSERT INTO Especializacao_do_item (Id, Tipo) VALUES (11, 'pocao');
  INSERT INTO Especializacao_do_item VALUES (12, 'pocao');
  INSERT INTO Especializacao_do_item VALUES (13, 'pocao');

  INSERT INTO Pocao
    (Id, Nome, Descricao, Raridade, Peso, Bonus, Duracao)
  VALUES (11, 'Poção de Vida', 'Recupera parte sua vida instantaneamente', 'comum', 0.5, 70, 30);
  INSERT INTO Pocao VALUES (12, 'Poção de Ataque', 'Aumenta o seu poder de ataque por alguns segundos', 'comum', 0.5, 40, 30);
  INSERT INTO Pocao VALUES (13, 'Poção de Defesa', 'Aumenta o seu poder defensivo por alguns segundos', 'comum', 0.5, 40, 30);
  
  INSERT INTO Especializacao_do_item (Id, Tipo) VALUES (14, 'armadura');
  INSERT INTO Especializacao_do_item VALUES (15, 'armadura');

  INSERT INTO Armadura
    (Id, Nome, Descricao, Raridade, Peso, Valor_de_defesa, Valor_de_agilidade)
  VALUES (14, 'Armadura Básica', 'Te protege de ataques básicos', 'comum', 9.5, 30, 15);
  INSERT INTO Armadura VALUES (15, 'Armadura Reforçada', 'Te protege dos principais ataques', 'comum', 12.5, 55, 30);

END;
$$ LANGUAGE plpgsql;