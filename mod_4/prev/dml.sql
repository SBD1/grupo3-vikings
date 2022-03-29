BEGIN TRANSACTION;

INSERT INTO Mapa VALUES(1);
INSERT INTO Mapa VALUES(2);

INSERT INTO Area VALUES(1, '0,0', 'terra', 2, 1);
INSERT INTO Area VALUES(3, '0,0', 'mar', 2, 2);
INSERT INTO Area (IdArea, Coordenadas, Tamanho, IdMapa) VALUES(4, '2,2', 4, 2);

INSERT INTO Quadrado VALUES ('0,0', 1, 'Floresta');
INSERT INTO Quadrado VALUES ('0,1', 1, 'Floresta');
INSERT INTO Quadrado VALUES ('1,1', 1, 'Floresta');
INSERT INTO Quadrado VALUES ('0,2', 1, 'Floresta');

INSERT INTO Quadrado VALUES('2,2', 4, 'Floresta Negra');
INSERT INTO Quadrado VALUES('3,3', 4, 'Vila velha');

INSERT INTO Personagem VALUES('marcelo', 'viking');
INSERT INTO Personagem VALUES('arthur', 'viking');
INSERT INTO Personagem VALUES('sa', 'monstro');

INSERT INTO Nivel VALUES(1, 100, 1000);
INSERT INTO Nivel VALUES(2, 200, 2000);
INSERT INTO Nivel VALUES(3, 300, 3000);

INSERT INTO Tipo_Mochila VALUES('basica', 20);
INSERT INTO Tipo_Mochila VALUES('normal', 35);
INSERT INTO Tipo_Mochila VALUES('reforcada', 50);

INSERT INTO Mochila VALUES(1, 'basica');
INSERT INTO Mochila VALUES(2, 'normal');
INSERT INTO Mochila VALUES(3, 'reforcada');
INSERT INTO Mochila VALUES(4, 'basica');

INSERT INTO Especializacao_do_item VALUES (1, 'arma');
INSERT INTO Especializacao_do_item VALUES (2, 'arma');

INSERT INTO Arma VALUES (1, 'Machado', 'arma', 'Machado corta cabeças', 20, 'comum', false, 30, 4, 3);
INSERT INTO Arma VALUES (2, 'Espada', 'arma', 'Espada de prata', 6, 'epico', false, 70, 2, 90);

INSERT INTO Instancia_item VALUES (1, 1, '1,1');
INSERT INTO Instancia_item VALUES (2, 1, '1,1');

INSERT INTO Instancia_item (Id, Id_item) VALUES (3, 1);
INSERT INTO Instancia_item (Id, Id_item) VALUES (4, 1);
INSERT INTO Instancia_item (Id, Id_item) VALUES (5, 2);

INSERT INTO Instancia_item VALUES (6, 1, '0,1');

INSERT INTO Viking (
    Nome, Experiencia, Nivel, MaosOcupadas, Quadrado, Ataque, Defesa, Roubo_de_Vida, Agilidade, Velocidade, Nivel_de_Vida, Vida_Restante
) VALUES ('arthur', 1500, 2, false, '2,2', 10, 11, 12, 13, 14, 15, 3);

INSERT INTO Viking VALUES ('marcelo', 150, 1, 2, 3, 4, true, '0,0', 3, 4, 5, 6, 7, 8, 9);

INSERT INTO Personagem VALUES('joao', 'viking');

INSERT INTO Viking (
    Nome, Experiencia, Nivel, Mochila, MaoEsquerda, MaosOcupadas, Quadrado, Ataque, Defesa, Roubo_de_Vida, Agilidade, Velocidade, Nivel_de_Vida, Vida_Restante
) VALUES ('joao', 2500, 3, 3, 5, false, '2,2', 16, 17, 18, 19, 20, 21, 2);

INSERT INTO Item_Mochila VALUES (1, 3);
INSERT INTO Item_Mochila VALUES (1, 4);

INSERT INTO Barco VALUES ('knarr', 15, 10, 100, 80);
INSERT INTO Barco VALUES ('langskip', 15, 10, 100, 80);

INSERT INTO InstanciaBarco VALUES (1, 'knarr', 'arthur', 'barco1', 100, '4,5');
INSERT INTO InstanciaBarco VALUES (2, 'knarr', 'arthur', 'barco2', 100, '6,5');
INSERT INTO InstanciaBarco VALUES (3, 'langskip', 'marcelo', 'barco3', 100, '3,5');

INSERT INTO InstanciaBarco (
    IdBarco, Tipo, Integridade, Coordenadas
) VALUES (4, 'knarr', 100, '9,5');

INSERT INTO Npc VALUES ('Ferreiro', 'tribo 01', 0, 51);
INSERT INTO Npc VALUES ('Vendedor', 'tribo 01', 0, 51);

INSERT INTO Quadrado VALUES('5,1', 3, 'Mar Gelado');
INSERT INTO Quadrado VALUES('0,6', 4, 'Vila velha');

INSERT INTO InstanciaNPC VALUES (1, 'Ferreiro', true, '5,1');

INSERT INTO TipoMonstro VALUES ('Demonio', 1300, 'Assustador Demonio Viking', 'Pantano');

INSERT INTO Personagem VALUES('Monstro 01', 'monstro');
INSERT INTO Personagem VALUES('Monstro 02', 'monstro');
INSERT INTO Monstro VALUES ('Monstro 01', '0,6', 'Demonio', 300, 250, 10, 50, 40, 100, 100);

INSERT INTO Entidade VALUES('Thor', 'Deus nordico associado a forca, trovoes, relampagos e tempestades.');
INSERT INTO Entidade VALUES('Loki', 'Deus nordico associado a trapaca, travessuras, fogo e tambem magia.');
INSERT INTO Entidade VALUES('Freyja', 'Deusa-mae dos Vanir, associada a beleza,  fertilidade,  amor e seidhr, magia para visualizacao e alteracao do futuro.');
INSERT INTO Entidade VALUES('Surtur', 'Lider dos gigantes de fogo e inimigo dos deuses, causador de destruicao extrema durante o ragnarok.');

INSERT INTO Aesir VALUES('Thor', 'Aesir', 5, 1);
INSERT INTO Aesir VALUES('Loki', 'Aesir', 1, 5);
INSERT INTO Vanir VALUES('Thor', 'Vanir', 2, 4);
INSERT INTO Jotun VALUES('Surtur', 'Jotun', 5, 5, 0, 5);

INSERT INTO Habilidade VALUES('Arma de Trovao', 3, 5, 1, 1, 'Ao levantar sua arma e gritar o nome de Thor, o deus faz descer um raio para aumentar seu dano e agilidade', 'Thor');
INSERT INTO Habilidade VALUES('Arma de Fogo e Sangue', 5, 2, 1, 5, 'Um pouco de sangue e uma  faisca sao o suficiente para Loki te ajudar a aumentar o dano e roubo de vida', 'Loki');
INSERT INTO Habilidade VALUES('Visao do Futuro', 5, 1, 5, 1, 'Uma visao do futuro que ajuda na esquiva e defesa de ataques', 'Freyja');
INSERT INTO Habilidade VALUES('Fogo primeval', 1, 1, 10, 1, 'Receba o poder do fogo primeval de Surtur, ganhando um enorme bonus de dano', 'Surtur');

INSERT INTO NPC VALUES('Guia de Jornada', 'Tribo', 0, 62);
INSERT INTO Fala VALUES('Guia de Jornada', 'Olá, eu sou o Guia de Jornada, seja bem vindo à vila.');

COMMIT;
