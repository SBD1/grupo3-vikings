CREATE TABLE Mapa (
    ID INTEGER NOT NULL,

    CONSTRAINT mapa_pk PRIMARY KEY (ID)
);

CREATE TABLE Area (
    IdArea INTEGER NOT NULL,
    Coordenadas VARCHAR(9) NOT NULL,
    Tipo VARCHAR(5) NOT NULL DEFAULT 'terra',
    Tamanho INTEGER NOT NULL,
    IdMapa INTEGER NOT NULL,

    CONSTRAINT area_pk PRIMARY KEY (IdArea),
    CONSTRAINT area_id_mapa_fk FOREIGN KEY (IdMapa) REFERENCES Mapa (ID) ON DELETE CASCADE,

    CONSTRAINT area_ck_tipo CHECK(Tipo IN ('terra', 'mar')),
    CONSTRAINT area_ck_tamanho CHECK(Tamanho > 0)
);

CREATE TABLE Quadrado (
    Coordenadas VARCHAR(9) NOT NULL,
    Area INTEGER NOT NULL,
    Descricao VARCHAR(200) NOT NULL,

    CONSTRAINT quadrado_pk PRIMARY KEY (Coordenadas),
    CONSTRAINT quadrado_area_fk FOREIGN KEY (Area) REFERENCES Area (IdArea) ON DELETE CASCADE
);

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

  Quadrado VARCHAR(9) NOT NULL,

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

  CONSTRAINT viking_quadrado_fk FOREIGN KEY (Quadrado) REFERENCES Quadrado (Coordenadas) ON DELETE CASCADE,

  CONSTRAINT viking_ck_ataque CHECK(Ataque > 0),
  CONSTRAINT viking_ck_defesa CHECK(Defesa > 0),
  CONSTRAINT viking_ck_roubo_de_vida CHECK(Roubo_de_Vida > 0),
  CONSTRAINT viking_ck_agilidade CHECK(Agilidade > 0),
  CONSTRAINT viking_ck_velocidade CHECK(Velocidade > 0),
  CONSTRAINT viking_ck_nivel_de_vida CHECK(Nivel_de_Vida >= 0),
  CONSTRAINT viking_ck_vida_restante CHECK(Vida_Restante >= 0)
);

-- Tipo_Monstro


CREATE TABLE Barco (
  Tipo VARCHAR(20) NOT NULL,
  Capacidade INTEGER NOT NULL,
  Velocidade INTEGER NOT NULL,
  Ataque INTEGER NOT NULL,
  Defesa INTEGER NOT NULL,

  CONSTRAINT barco_pk PRIMARY KEY (Tipo),
  CONSTRAINT barco_capacidade_ck CHECK(Capacidade > 0),
  CONSTRAINT barco_velocidade_ck CHECK(Velocidade > 0),
  CONSTRAINT barco_tipo_ck CHECK(Tipo IN ('knarr', 'langskip'))
);

CREATE TABLE InstanciaBarco (
  IdBarco INTEGER NOT NULL,
  Tipo VARCHAR(20) NOT NULL,
  NomeViking VARCHAR(100),
  Nome VARCHAR(100),
  Integridade INTEGER NOT NULL,
  Coordenadas VARCHAR(9) NOT NULL,

  CONSTRAINT instancia_barco_pk PRIMARY KEY (IdBarco),
  CONSTRAINT instancia_barco_tipo_fk FOREIGN KEY (Tipo) REFERENCES Barco (Tipo) ON DELETE CASCADE,
  CONSTRAINT instancia_barco_viking_fk FOREIGN KEY (NomeViking) REFERENCES Viking (Nome) ON DELETE CASCADE
);

