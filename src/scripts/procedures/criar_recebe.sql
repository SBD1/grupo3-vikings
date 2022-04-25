CREATE OR REPLACE FUNCTION 
	criar_recebe(nome_habilidade VARCHAR(100), nome VARCHAR(100), nome_entidade VARCHAR(100))
RETURNS VOID AS $$

BEGIN
    INSERT INTO Recebe (Nome_habilidade, Nome_viking, Nome_entidade) VALUES(nome_habilidade, nome, nome_entidade);
END;
$$ LANGUAGE plpgsql;