BEGIN TRANSACTION;

SELECT criar_mapa_jogo();

SELECT criar_itens();

SELECT criar_artefatos();

SELECT criar_viking('arthur');
SELECT criar_viking('marcelo');
SELECT criar_viking('joao');

SELECT criar_monstros();

SELECT criar_barcos();

SELECT criar_deus();

INSERT INTO Instancia_item VALUES (1, 1, '1,1');
INSERT INTO Instancia_item VALUES (2, 1, '1,1');

INSERT INTO Instancia_item (Id, Id_item) VALUES (3, 1);
INSERT INTO Instancia_item (Id, Id_item) VALUES (4, 1);
INSERT INTO Instancia_item (Id, Id_item) VALUES (5, 2);

INSERT INTO Instancia_item VALUES (6, 1, '0,1');

INSERT INTO Item_Mochila VALUES (1, 3);
INSERT INTO Item_Mochila VALUES (1, 4);

INSERT INTO Npc VALUES ('Ferreiro', 'tribo 01', 0, 51);
INSERT INTO Npc VALUES ('Vendedor', 'tribo 01', 0, 51);

INSERT INTO InstanciaNPC VALUES (1, 'Ferreiro', true, '5,1');

INSERT INTO Habilidade VALUES('Arma de Trovao', 3, 5, 1, 1, 'Ao levantar sua arma e gritar o nome de Thor, o deus faz descer um raio para aumentar seu dano e agilidade', 'Thor');
INSERT INTO Habilidade VALUES('Arma de Fogo e Sangue', 5, 2, 1, 5, 'Um pouco de sangue e uma  faisca sao o suficiente para Loki te ajudar a aumentar o dano e roubo de vida', 'Loki');
INSERT INTO Habilidade VALUES('Visao do Futuro', 5, 1, 5, 1, 'Uma visao do futuro que ajuda na esquiva e defesa de ataques', 'Freyja');
INSERT INTO Habilidade VALUES('Fogo primeval', 1, 1, 10, 1, 'Receba o poder do fogo primeval de Surtur, ganhando um enorme bonus de dano', 'Surtur');

INSERT INTO NPC VALUES('Guia de Jornada', 'Tribo', 0, 62);
INSERT INTO Fala VALUES('Guia de Jornada', 'Olá, eu sou o Guia de Jornada, seja bem vindo à vila.');  

COMMIT;
