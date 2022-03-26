CREATE DOMAIN PERSONAGEM_TYPE
  AS CHAR(7)
  CHECK (VALUE IN ('viking', 'monstro'));

CREATE TABLE Personagem (
  Nome VARCHAR(100) NOT NULL,
  Tipo PERSONAGEM_TYPE NOT NULL,

  CONSTRAINT personagem_pk PRIMARY KEY (Nome)
);

CREATE TABLE Nivel (
    Valor INTEGER NOT NULL,
    Pontos_ao_Subir INTEGER NOT NULL,
    Experiencia_para_Subir_de_Nivel INTEGER NOT NULL,

    CONSTRAINT nivel_pk PRIMARY KEY (Valor),
    CONSTRAINT nivel_ck_pontos_ao_subir CHECK(Pontos_ao_Subir > 0),
    CONSTRAINT nivel_ck_experiencia_para_subir_de_nivel CHECK(Experiencia_para_Subir_de_Nivel > 0)
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
  CONSTRAINT mochila_tipo_fk FOREIGN KEY (Tipo) REFERENCES Tipo_Mochila (Nome) ON DELETE CASCADE,
  CONSTRAINT tipo_mochila_ck_volume_ocupado CHECK(VolumeOcupado >= 0)
);

CREATE TABLE Viking (
  Nome VARCHAR(100) NOT NULL,
  
  Experiencia INTEGER NOT NULL,
  Nivel INTEGER NOT NULL,

  Mochila INTEGER,
  -- MaoEsquerda INTEGER,
  -- MaoDireita INTEGER,
  MaosOcupadas BOOLEAN NOT NULL,

  -- Quadrado VARCHAR(10) NOT NULL,

  -- Atributos_de_Luta
  Ataque INTEGER NOT NULL,
  Defesa INTEGER NOT NULL,
  Roubo_de_Vida INTEGER NOT NULL,
  Agilidade INTEGER NOT NULL,
  Velocidade INTEGER NOT NULL,

  -- Vida
  Nivel_de_Vida INTEGER NOT NULL,
  Vida_Restante INTEGER NOT NULL,

  CONSTRAINT viking_pk PRIMARY KEY (Nome),
  CONSTRAINT viking_nome_fk FOREIGN KEY (Nome) REFERENCES Personagem (Nome) ON DELETE CASCADE,
  CONSTRAINT viking_nivel_fk FOREIGN KEY (Nivel) REFERENCES Nivel (Valor) ON DELETE CASCADE,

  CONSTRAINT viking_mochila_fk FOREIGN KEY (Mochila) REFERENCES Mochila (Numero) ON DELETE SET NULL,
  -- CONSTRAINT viking_mao_esquerda_fk FOREIGN KEY (MaoEsquerda) REFERENCES InstanciaItem (Id) ON DELETE SET NULL,
  -- CONSTRAINT viking_mao_direita_fk FOREIGN KEY (MaoDireita) REFERENCES InstanciaItem (Id) ON DELETE SET NULL,

  -- CONSTRAINT viking_quadrado_fk FOREIGN KEY (Quadrado) REFERENCES Quadrado (Coordenadas) ON DELETE CASCADE,

  CONSTRAINT viking_ck_ataque CHECK(Ataque > 0),
  CONSTRAINT viking_ck_defesa CHECK(Defesa > 0),
  CONSTRAINT viking_ck_roubo_de_vida CHECK(Roubo_de_Vida > 0),
  CONSTRAINT viking_ck_agilidade CHECK(Agilidade > 0),
  CONSTRAINT viking_ck_velocidade CHECK(Velocidade > 0),
  CONSTRAINT viking_ck_nivel_de_vida CHECK(Nivel_de_Vida >= 0),
  CONSTRAINT viking_ck_vida_restante CHECK(Vida_Restante >= 0)
);

-- Tipo_Monstro
