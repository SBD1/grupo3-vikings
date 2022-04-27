CREATE OR REPLACE FUNCTION 
	criar_deus()
RETURNS VOID AS $$

BEGIN
    INSERT INTO Entidade VALUES('Thor', 'Deus nordico associado a forca, trovoes, relampagos e tempestades.');
    INSERT INTO Entidade VALUES('Loki', 'Deus nordico associado a trapaca, travessuras, fogo e tambem magia.');
    INSERT INTO Entidade VALUES('Freyja', 'Deusa-mae dos Vanir, associada a beleza,  fertilidade,  amor e seidhr, magia para visualizacao e alteracao do futuro.');
    INSERT INTO Entidade VALUES('Surtur', 'Lider dos gigantes de fogo e inimigo dos deuses, causador de destruicao extrema durante o ragnarok.');

    INSERT INTO Aesir VALUES('Thor', 'Aesir', 5, 1);
    INSERT INTO Aesir VALUES('Loki', 'Aesir', 1, 5);
    INSERT INTO Vanir VALUES('Freyja', 'Vanir', 2, 4);
    INSERT INTO Jotun VALUES('Surtur', 'Jotun', 5, 5, 0, 5);

END;
$$ LANGUAGE plpgsql;

