CREATE OR REPLACE FUNCTION 
	criar_npc_e_instancias()
RETURNS VOID AS $$

BEGIN
  
-- NPCS e suas Falas
INSERT INTO Npc (IdNPC, Tribo, genero, idade) VALUES ('Ferreiro', 'Tribo Vila Viking', 0, 51);
INSERT INTO Npc (IdNPC, Tribo, genero, idade) VALUES ('Vendedor', 'Tribo Vila Viking', 0, 41);
INSERT INTO Npc (IdNPC, Tribo, genero, idade) VALUES('GuiaDeJornada', 'Tribo Vila Viking', 0, 34);
INSERT INTO Npc (IdNPC, Tribo, genero, idade) VALUES('Sacerdote', 'Tribo Vila Viking', 0, 60);
INSERT INTO Fala (IdNpc, Texto) VALUES('Sacerdote', 'Olá, eu sou o Sacerdote Goði. Antes de sair, você deve escolher um Deus para te ajudar nessa jornada.');  
INSERT INTO Fala (IdNpc, Texto) VALUES('Ferreiro', 'Olá, eu sou o Ferreiro, o que desejas?.');  
INSERT INTO Fala (IdNpc, Texto) VALUES('Vendedor', 'Olá, eu sou o Vendedor, o que vai querer para hoje?.');  
INSERT INTO Fala (IdNpc, Texto) VALUES('GuiaDeJornada', 'Olá, eu sou o Guia de Jornada, seja bem vindo à vila.');  

-- Instancias dos NPCS
INSERT INTO InstanciaNPC VALUES (nextval('id_instancia_npc_seq'), 'Ferreiro', true, '5,1');
INSERT INTO InstanciaNPC VALUES (nextval('id_instancia_npc_seq'), 'Vendedor', true, '10,4');
INSERT INTO InstanciaNPC VALUES (nextval('id_instancia_npc_seq'), 'GuiaDeJornada', true, '8,0');
INSERT INTO InstanciaNPC VALUES (nextval('id_instancia_npc_seq'), 'Sacerdote', true, '8,1');


END;
$$ LANGUAGE plpgsql;