-- Esse script supõe que os outros scripts dessa pasta foram utilizados para criar e popular o banco de dados;

BEGIN TRANSACTION

-- Adiciona os items do chão na mochila do jogador

INSERT INTO Item_Mochila (Numero_Mochila, Id_Item)
	SELECT
		v.Mochila,
		i.Id
	FROM
		Viking v
		CROSS JOIN Instancia_item i
	WHERE
		v.Nome = 'joao'
		AND i.Quadrado = '1,1';

-- Atualiza a instâncias de item

UPDATE Instancia_item SET Quadrado = NULL WHERE Instancia_item.Quadrado = '1,1';

COMMIT;
