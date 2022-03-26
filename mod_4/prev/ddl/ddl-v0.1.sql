CREATE TABLE Personagem (
  Nome VARCHAR(100) NOT NULL,
  Tipo VARCHAR(20) NOT NULL,

  CONSTRAINT personagem_pk PRIMARY KEY (Nome),
  CONSTRAINT personagem_ck_tipo CHECK(Tipo IN ('viking', 'monstro'))
);


CREATE TABLE Viking (
  Nome VARCHAR(100) NOT NULL,
  Experiencia INTEGER NOT NULL,
  Mochila INTEGER NOT NULL,
  MaoEsquerda INTEGER,
  MaoDireita INTEGER,
  MaosOcupadas BOOLEAN NOT NULL,
  Quadrado VARCHAR(10) NOT NULL,
  Nivel INTEGER NOT NULL,

  CONSTRAINT viking_pk PRIMARY KEY (Nome),
  CONSTRAINT viking_mochila_fk FOREIGN KEY (Mochila) REFERENCES Mochila (Numero) ON DELETE CASCADE,
  CONSTRAINT viking_mao_esquerda_fk FOREIGN KEY (MaoEsquerda) REFERENCES InstanciaItem (Id) ON DELETE CASCADE,
  CONSTRAINT viking_mao_direita_fk FOREIGN KEY (MaoDireita) REFERENCES InstanciaItem (Id) ON DELETE CASCADE,
  CONSTRAINT viking_quadrado_fk FOREIGN KEY (Quadrado) REFERENCES Quadrado (Coordenadas) ON DELETE CASCADE,
  CONSTRAINT viking_nivel_fk FOREIGN KEY (Nivel) REFERENCES Nivel (Valor) ON DELETE CASCADE,
);