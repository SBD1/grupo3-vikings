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

INSERT INTO Viking VALUES ('marcelo', 150, 1, 2, false, 3, 4, 5, 6, 7, 8, 9);

INSERT INTO Viking (
    Nome, Experiencia, Nivel, MaosOcupadas, Ataque, Defesa, Roubo_de_Vida, Agilidade, Velocidade, Nivel_de_Vida, Vida_Restante
) VALUES ('arthur', 1500, 2, false, 10, 11, 12, 13, 14, 15, 3);
