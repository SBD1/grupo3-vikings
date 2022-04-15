CREATE OR REPLACE FUNCTION 
	criar_mapa_jogo()
RETURNS VOID AS $$

DECLARE 

  iterador_linha INTEGER;
  iterador_coluna INTEGER;
  coordenadas VARCHAR(10);
  limite_x INTEGER;
  limite_y INTEGER;
  coordenada_x VARCHAR(10);
  coordenada_y VARCHAR(10);
  i INTEGER;
  j INTEGER;

BEGIN
  INSERT INTO Mapa (ID, QtdLinhas, QtdColunas) VALUES(1, 16, 24);
  
  INSERT INTO Area (IdArea, Tipo, Tamanho, IdMapa) VALUES(1, 'Vila Viking', 77, 1);
  INSERT INTO Area VALUES(2, 'Floresta Negra', 133, 1);
  INSERT INTO Area VALUES(3, 'Ilha', 36, 1);
  INSERT INTO Area VALUES(4, 'Mar', 138, 1);
  
  -- Valores baseados no mapa de referência: https://github.com/SBD1/grupo8-Vikings/blob/main/src/assets/mapa.png
  -- Quadrados Vila Viking
  iterador_linha := 4;
  iterador_coluna := 0;
  limite_x := 10;
  limite_y := 10;

  FOR i IN iterador_linha..limite_x LOOP
    FOR j IN iterador_coluna..limite_y LOOP
      coordenadas := replace(to_char(i, '99'), ' ', '') || ',' || replace(to_char(j, '99'), ' ', '');
      INSERT INTO Quadrado (Coordenadas, Area, Descricao) VALUES (coordenadas, 1, 'Quadrado Vila Viking');
    END LOOP;
  END LOOP;

  -- Quadrados Floresta Negra
  iterador_linha := 1;
  iterador_coluna := 0;
  limite_x := 14;
  limite_y := 14; 

  FOR i IN iterador_linha..limite_x LOOP
    IF (i > 3 AND i < 11) THEN
      iterador_coluna := 11;
    ELSE
      iterador_coluna := 0;
    END IF;
    FOR j IN iterador_coluna..limite_y LOOP

      coordenadas := replace(to_char(i, '99'), ' ', '') || ',' || replace(to_char(j, '99'), ' ', '');
      INSERT INTO Quadrado (Coordenadas, Area, Descricao) VALUES (coordenadas, 2, 'Quadrado Floresta Negra');
    END LOOP;
  END LOOP;


  -- Quadrados Ilha
  iterador_linha := 5;
  iterador_coluna := 17;
  limite_x := 10;
  limite_y := 22; 
  FOR i IN iterador_linha..limite_x LOOP
    FOR j IN iterador_coluna..limite_y LOOP
      coordenadas := replace(to_char(i, '99'), ' ', '') || ',' || replace(to_char(j, '99'), ' ', '');
      INSERT INTO Quadrado (Coordenadas, Area, Descricao) VALUES (coordenadas, 3, 'Quadrado Ilha');
    END LOOP;
  END LOOP;

  -- Quadrados Mar
  iterador_linha := 0;
  iterador_coluna := 0;
  limite_x := 15;
  limite_y := 23; 
  FOR i IN iterador_linha..limite_x LOOP
    FOR j IN iterador_coluna..limite_y LOOP
      coordenadas := replace(to_char(i, '99'), ' ', '') || ',' || replace(to_char(j, '99'), ' ', '');
      INSERT INTO Quadrado (Coordenadas, Area, Descricao) VALUES (coordenadas, 4, 'Quadrado Mar');
    END LOOP;
  END LOOP;

END;
$$ LANGUAGE plpgsql;