CREATE OR REPLACE FUNCTION 
	criar_barcos()
RETURNS VOID AS $$

BEGIN
  -- Adição dos Barcos  
  INSERT INTO Barco 
    (Tipo, Capacidade, Velocidade, Ataque, Defesa)
  VALUES ('knarr', 15, 10, 100, 80);
  INSERT INTO Barco VALUES ('langskip', 15, 10, 100, 80);

END;
$$ LANGUAGE plpgsql;