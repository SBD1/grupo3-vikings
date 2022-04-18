CREATE OR REPLACE FUNCTION 
	criar_barcos()
RETURNS VOID AS $$

BEGIN
  -- Adição dos Barcos  
  INSERT INTO Barco 
    (Tipo, Capacidade, Velocidade, Ataque, Defesa)
  VALUES ('knarr', 15, 10, 100, 80);
  INSERT INTO Barco VALUES ('langskip', 15, 10, 100, 80);

  -- Adição Instancia dos Barcos
  INSERT INTO InstanciaBarco 
    (IdBarco, Tipo, NomeViking, Nome, Integridade, Coordenadas)
  VALUES (nextval('id_instancia_barco_seq'), 'langskip', 'arthur', 'Saturno', 100, '9,15');
  INSERT INTO InstanciaBarco 
  VALUES (nextval('id_instancia_barco_seq'), 'langskip', 'joao', 'Jupiter', 100, '9,16');

END;
$$ LANGUAGE plpgsql;