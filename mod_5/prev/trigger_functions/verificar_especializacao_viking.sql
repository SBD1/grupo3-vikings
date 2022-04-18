CREATE OR REPLACE FUNCTION
    verificar_especializacao_viking()
RETURNS TRIGGER AS $verificar_especializacao_viking$

BEGIN
    PERFORM * FROM Monstro WHERE Nome = NEW.Nome;
    IF FOUND THEN
        RAISE EXCEPTION 'Este personagem já se encontra na tabela de monstros';
    END IF;

    SELECT * INTO personagem_row FROM Personagem WHERE Nome = NEW.Nome AND Tipo = 'monstro';
    IF (personagem_row IS NOT NULL) THEN
        RAISE EXCEPTION 'Este personagem é do tipo monstro';
    END IF;

    RETURN NEW;
END;

$verificar_especializacao_viking$ LANGUAGE plpgsql;

CREATE TRIGGER VerificarEspecializacaoViking
BEFORE UPDATE OR INSERT ON Viking
FOR EACH ROW EXECUTE PROCEDURE verificar_especializacao_viking();
