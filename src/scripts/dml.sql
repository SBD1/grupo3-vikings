BEGIN TRANSACTION;

SELECT criar_mapa_jogo();

SELECT criar_itens();

SELECT criar_artefatos();

SELECT criar_barcos();

SELECT criar_monstros();

SELECT criar_deus();

SELECT criar_instancias_itens_iniciais_mapa();

SELECT criar_npc_e_instancias();

select criar_habilidade();

COMMIT;
