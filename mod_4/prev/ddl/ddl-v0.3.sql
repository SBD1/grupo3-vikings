CREATE DOMAIN PERSONAGEM_TYPE
    AS CHAR(6)
    CHECK (VALUE IN ('viking', 'monstro'));

CREATE TABLE Personagem (
  Nome VARCHAR(100) NOT NULL,
  Tipo PERSONAGEM_TYPE NOT NULL

  CONSTRAINT personagem_pk PRIMARY KEY (Nome)
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
  CONSTRAINT viking_nivel_fk FOREIGN KEY (Nivel) REFERENCES Nivel (Valor) ON DELETE CASCADE
);

CREATE TABLE Tipo_Mochila (
  Nome VARCHAR(20) NOT NULL,
  Capacidade INTEGER NOT NULL,

  CONSTRAINT tipo_mochila_pk PRIMARY KEY (Nome),
  CONSTRAINT tipo_mochila_uq UNIQUE (Capacidade),
  CONSTRAINT tipo_mochila_ck_capacidade CHECK(Capacidade > 0)
);

CREATE TABLE Mochila (
  Numero INTEGER NOT NULL,
  Tipo VARCHAR(20) NOT NULL,
  VolumeOcupado INTEGER NOT NULL DEFAULT 0,

  CONSTRAINT mochila_pk PRIMARY KEY (Numero),
  CONSTRAINT mochila_tipo_fk FOREIGN KEY (Tipo) REFERENCES Tipo_Mochila (Nome) ON DELETE CASCADE
);