-- Adicionando Tuplas de Mapa

INSERT INTO Mapa VALUES(2);

-- Adicionando Tuplas de Area

INSERT INTO Area VALUES(3, '0,0', 'mar', 2, 2);
INSERT INTO Area (IdArea, Coordenadas, Tamanho, IdMapa) VALUES(4, '2,2', 4, 2);

-- Adicionando Tuplas de Quadrado

INSERT INTO Quadrado VALUES('0,0', 3, 'Mar Gelado');
INSERT INTO Quadrado VALUES('2,2', 4, 'Floresta Negra');
INSERT INTO Quadrado VALUES('3,3', 4, 'Vila velha');

-- Adicionando Tuplas de Personagens

INSERT INTO Personagem VALUES('marcelo', 'viking');
INSERT INTO Personagem VALUES('arthur', 'viking');
INSERT INTO Personagem VALUES('sa', 'monstro');

-- Adicionando Tuplas de Nível

INSERT INTO Nivel VALUES(1, 100, 1000);
INSERT INTO Nivel VALUES(2, 200, 2000);
INSERT INTO Nivel VALUES(3, 300, 3000);

-- Adicionando Tuplas de Tipos de Mochilas

INSERT INTO Tipo_Mochila VALUES('basica', 20);
INSERT INTO Tipo_Mochila VALUES('normal', 35);
INSERT INTO Tipo_Mochila VALUES('reforcada', 50);

-- Adicionando Tuplas de Mochilas

INSERT INTO Mochila VALUES(1, 'basica');
INSERT INTO Mochila VALUES(2, 'normal');
INSERT INTO Mochila VALUES(3, 'reforcada');
INSERT INTO Mochila VALUES(4, 'basica');

-- Adicionando Tuplas de Viking

INSERT INTO Viking VALUES ('marcelo', 150, 1, 2, false, '0,0', 3, 4, 5, 6, 7, 8, 9);

INSERT INTO Viking (
    Nome, Experiencia, Nivel, MaosOcupadas, Quadrado, Ataque, Defesa, Roubo_de_Vida, Agilidade, Velocidade, Nivel_de_Vida, Vida_Restante
) VALUES ('arthur', 1500, 2, false, '2,2', 10, 11, 12, 13, 14, 15, 3);


-- Adicionando os Barcos do jogo

INSERT INTO Barco VALUES ('knarr', 15, 10, 100, 80);
INSERT INTO Barco VALUES ('langskip', 15, 10, 100, 80);

-- Adicionando Instancia de Barco

INSERT INTO InstanciaBarco VALUES (1, 'knarr', 'arthur', 'barco1', 100, '4,5');
INSERT INTO InstanciaBarco VALUES (2, 'knarr', 'arthur', 'barco2', 100, '6,5');
INSERT INTO InstanciaBarco VALUES (3, 'langskip', 'marcelo', 'barco3', 100, '3,5');


INSERT INTO InstanciaBarco (
    IdBarco, Tipo, Integridade, Coordenadas
) VALUES (4, 'knarr', 100, '9,5');

INSERT INTO Npc VALUES ('Ferreiro', 'tribo 01', 0, 51);

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

INSERT INTO Habilidades VALUES('Arma de Trovao', 3, 5, 1, 1, 'Ao levantar sua arma e gritar o nome de Thor, o deus faz descer um raio para aumentar seu dano e agilidade', 'Thor');
INSERT INTO Habilidades VALUES('Arma de Fogo e Sangue', 5, 2, 1, 5, 'Um pouco de sangue e uma  faisca sao o suficiente para Loki te ajudar a aumentar o dano e roubo de vida', 'Loki');
INSERT INTO Habilidades VALUES('Visao do Futuro', 5, 1, 5, 1, 'Uma visao do futuro que ajuda na esquiva e defesa de ataques', 'Freyja');
INSERT INTO Habilidades VALUES('Fogo primeval', 1, 1, 10, 1, 'Receba o poder do fogo primeval de Surtur, ganhando um enorme bonus de dano', 'Surtur');
