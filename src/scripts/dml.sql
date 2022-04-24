BEGIN TRANSACTION;

SELECT criar_mapa_jogo();

SELECT criar_itens();

SELECT criar_artefatos();

SELECT criar_barcos();

SELECT criar_monstros();

SELECT criar_deus();

SELECT criar_instancias_itens_iniciais_mapa();

SELECT criar_npc_e_instancias();

INSERT INTO Habilidade VALUES('Arma de Trovao', 3, 5, 1, 1, 'Ao levantar sua arma e gritar o nome de Thor, o deus faz descer um raio para aumentar seu dano e agilidade', 'Thor');
INSERT INTO Habilidade VALUES('Arma de Fogo e Sangue', 5, 2, 1, 5, 'Um pouco de sangue e uma  faisca sao o suficiente para Loki te ajudar a aumentar o dano e roubo de vida', 'Loki');
INSERT INTO Habilidade VALUES('Visao do Futuro', 5, 1, 5, 1, 'Uma visao do futuro que ajuda na esquiva e defesa de ataques', 'Freyja');
INSERT INTO Habilidade VALUES('Fogo primeval', 1, 1, 10, 1, 'Receba o poder do fogo primeval de Surtur, ganhando um enorme bonus de dano', 'Surtur');


COMMIT;
