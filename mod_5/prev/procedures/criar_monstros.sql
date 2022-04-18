CREATE OR REPLACE FUNCTION 
	criar_monstros()
RETURNS VOID AS $$

BEGIN
  INSERT INTO TipoMonstro VALUES ('Garm', 800, 'O guardião dos portões do inferno nórdico.', 'Pantano');
  INSERT INTO TipoMonstro VALUES ('Fenrisulfr', 1000, 'Um lobo monstruoso, filho de Loki com a giganta Angrboda.', 'Pantano');
  INSERT INTO TipoMonstro VALUES ('Draugr', 1300, 'Aquele que anda após a morte. Assustador Demonio Viking.', 'Pantano');
  INSERT INTO TipoMonstro VALUES ('Grendel', 1800, 'Uma criatura cruel e selvagem de enorme estatura, força bruta e astúcia que repetidamente ataca durante a noite.', 'Pantano');
  INSERT INTO TipoMonstro VALUES ('Jormungand', 2300, 'A Serpente do Mundo, segundo filho de Loki com a giganta Angrboda.', 'Pantano');
  INSERT INTO TipoMonstro VALUES ('Nidhogg', 3300, 'O Percutor da Malícia, um dragão que se alimenta de corpos mortos.', 'Pantano');
  INSERT INTO TipoMonstro VALUES ('Surt', 5000, 'O senhor dos gigantes do fogo.', 'Pantano');
  INSERT INTO TipoMonstro VALUES ('Ymir', 10000, 'O primeiro ser vivo. Criado a partir do gelo mágico de Ginungagap.', 'Pantano');

    
  INSERT INTO Personagem VALUES('Garm'      , 'monstro');
  INSERT INTO Personagem VALUES('Fenrisulfr', 'monstro');
  INSERT INTO Personagem VALUES('Draugr'    , 'monstro');
  INSERT INTO Personagem VALUES('Grendel'   , 'monstro');
  INSERT INTO Personagem VALUES('Jormungand', 'monstro');
  INSERT INTO Personagem VALUES('Nidhogg'   , 'monstro');
  INSERT INTO Personagem VALUES('Surt'      , 'monstro');
  INSERT INTO Personagem VALUES('Ymir'      , 'monstro');

  INSERT INTO Monstro VALUES ('Garm'       , '8,9'  , 'Garm'      , 2 , 5,   1,   5, 4,  25,   25   );
  INSERT INTO Monstro VALUES ('Fenrisulfr' , '8,10' , 'Fenrisulfr', 5 , 2,   1,   4, 5,  30,   30   );
  INSERT INTO Monstro VALUES ('Draugr'     , '2,12' , 'Draugr'    , 12, 5,   1,  10, 10, 50,   50   );
  INSERT INTO Monstro VALUES ('Grendel'    , '13,12', 'Grendel'   , 20, 20,  3,  15, 20, 700,  700  );
  INSERT INTO Monstro VALUES ('Jormungand' , '4,13' , 'Jormungand', 25, 15,  10, 10, 40, 1200, 1200 );
  INSERT INTO Monstro VALUES ('Nidhogg'    , '10,13', 'Nidhogg'   , 30, 60,  10, 40, 40, 2000, 2000 );
  INSERT INTO Monstro VALUES ('Surt'       , '8,17' , 'Surt'      , 50, 40,  5,  30, 30, 2500, 2500 );
  INSERT INTO Monstro VALUES ('Ymir'       , '8,20' , 'Ymir'      , 70, 100, 10, 20, 20, 4000, 4000 );

  INSERT INTO Dropa VALUES('Garm', '3');
  INSERT INTO Dropa VALUES('Garm', '12');


END;
$$ LANGUAGE plpgsql;

