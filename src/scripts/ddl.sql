BEGIN TRANSACTION;

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

CREATE DOMAIN ITEM_TIPO
  AS CHAR(8)
  CHECK (VALUE IN ('arma', 'comida', 'pocao', 'armadura'));

CREATE TABLE Especializacao_do_item(
    Id INTEGER NOT NULL,
    Tipo ITEM_TIPO NOT NULL,

    CONSTRAINT especializacao_do_item_pk PRIMARY KEY(Id)
);

CREATE TABLE Instancia_item(
    Id INTEGER NOT NULL,
    Id_item INTEGER NOT NULL,
    Quadrado VARCHAR(9),

    CONSTRAINT instancia_item_pk PRIMARY KEY(Id),
    CONSTRAINT id_item_instancia_item_fk FOREIGN KEY(Id_item) REFERENCES Especializacao_do_item(Id),
    CONSTRAINT instancia_item_quadrado_fk FOREIGN KEY (Quadrado) REFERENCES Quadrado (Coordenadas) ON DELETE SET NULL
);

CREATE TABLE Item_Mochila (
  Numero_Mochila INTEGER NOT NULL,
  Id_Item INTEGER NOT NULL,

  CONSTRAINT item_mochila_pk PRIMARY KEY (Numero_Mochila, Id_Item),
  CONSTRAINT item_mochila_numero_mochila_fk FOREIGN KEY (Numero_Mochila) REFERENCES Mochila (Numero) ON DELETE CASCADE,
  CONSTRAINT item_mochila_id_item_fk FOREIGN KEY (Id_Item) REFERENCES Instancia_item (Id) ON DELETE CASCADE
);

CREATE TABLE Viking (
  Nome VARCHAR(100) NOT NULL,
  
  Experiencia INTEGER NOT NULL,
  Nivel INTEGER NOT NULL,

  Mochila INTEGER,
  MaoEsquerda INTEGER,
  MaoDireita INTEGER,
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
  CONSTRAINT viking_mao_esquerda_fk FOREIGN KEY (MaoEsquerda) REFERENCES Instancia_item (Id) ON DELETE SET NULL,
  CONSTRAINT viking_mao_direita_fk FOREIGN KEY (MaoDireita) REFERENCES Instancia_item (Id) ON DELETE SET NULL,
  CONSTRAINT viking_quadrado_fk FOREIGN KEY (Quadrado) REFERENCES Quadrado (Coordenadas) ON DELETE CASCADE,
  CONSTRAINT viking_mao_esquerda_uq UNIQUE (MaoEsquerda),
  CONSTRAINT viking_mao_direita_uq UNIQUE (MaoDireita),
  CONSTRAINT viking_ck_ataque CHECK(Ataque > 0),
  CONSTRAINT viking_ck_defesa CHECK(Defesa > 0),
  CONSTRAINT viking_ck_roubo_de_vida CHECK(Roubo_de_Vida > 0),
  CONSTRAINT viking_ck_agilidade CHECK(Agilidade > 0),
  CONSTRAINT viking_ck_velocidade CHECK(Velocidade > 0),
  CONSTRAINT viking_ck_nivel_de_vida CHECK(Nivel_de_Vida >= 0),
  CONSTRAINT viking_ck_vida_restante CHECK(Vida_Restante >= 0)
);

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

CREATE TABLE NPC (
  IdNPC VARCHAR(100) NOT NULL,
  Tribo VARCHAR(20) NOT NULL,
  Genero SMALLINT NOT NULL,
  Idade INTEGER NOT NULL,

  CONSTRAINT npc_pk PRIMARY KEY (IdNPC)
);

CREATE TABLE InstanciaNPC (
  Id INTEGER NOT NULL,
  Tipo VARCHAR(100) NOT NULL,
  EstaEmCidade BOOLEAN,
  Quadrado VARCHAR(9) NOT NULL,

  CONSTRAINT instancia_npc_pk PRIMARY KEY (Id),
  CONSTRAINT instancia_npc_tipo_fk FOREIGN KEY (Tipo) REFERENCES NPC (IdNPC) ON DELETE CASCADE,
  CONSTRAINT instancia_npc_quadrado_fk FOREIGN KEY (Quadrado) REFERENCES Quadrado (Coordenadas) ON DELETE CASCADE
);

CREATE TABLE Fala (
  IdNPC VARCHAR(100) NOT NULL,
  Texto VARCHAR(100) NOT NULL,

  CONSTRAINT fala_pk PRIMARY KEY (IdNPC),
  CONSTRAINT fala_npc_fk FOREIGN KEY (IdNPC) REFERENCES NPC (IdNPC) ON DELETE CASCADE,
  CONSTRAINT fala_texto_ck CHECK(Texto != '')
);

CREATE TABLE TipoMonstro (
  Nome VARCHAR(100) NOT NULL,
  Experiencia INTEGER NOT NULL,
  Descricao VARCHAR(1000) NOT NULL,
  Bioma VARCHAR(20) NOT NULL,

  CONSTRAINT tipo_monstro_pk PRIMARY KEY (Nome)
);

CREATE TABLE Monstro (
  Nome VARCHAR(100) NOT NULL,
  Quadrado VARCHAR(9) NOT NULL,
  Tipo VARCHAR(100) NOT NULL,

   -- Atributos_de_Luta
  Ataque INTEGER NOT NULL,
  Defesa INTEGER NOT NULL,
  Roubo_de_Vida INTEGER NOT NULL,
  Agilidade INTEGER NOT NULL,
  Velocidade INTEGER NOT NULL,

  -- Vida
  Nivel_de_Vida INTEGER NOT NULL,
  Vida_Restante INTEGER NOT NULL,

  CONSTRAINT monstro_pk PRIMARY KEY (Nome),
  CONSTRAINT monstro_nome_fk FOREIGN KEY (Nome) REFERENCES Personagem (Nome) ON DELETE CASCADE,
  CONSTRAINT monstro_tipo_fk FOREIGN KEY (Tipo) REFERENCES TipoMonstro (Nome) ON DELETE CASCADE,
  CONSTRAINT monstro_quadrado_fk FOREIGN KEY (Quadrado) REFERENCES Quadrado (Coordenadas) ON DELETE CASCADE,
  CONSTRAINT monstro_ck_ataque CHECK(Ataque > 0),
  CONSTRAINT monstro_ck_defesa CHECK(Defesa > 0),
  CONSTRAINT monstro_ck_roubo_de_vida CHECK(Roubo_de_Vida > 0),
  CONSTRAINT monstro_ck_agilidade CHECK(Agilidade > 0),
  CONSTRAINT monstro_ck_velocidade CHECK(Velocidade > 0),
  CONSTRAINT monstro_ck_nivel_de_vida CHECK(Nivel_de_Vida >= 0),
  CONSTRAINT monstro_ck_vida_restante CHECK(Vida_Restante >= 0)
);

CREATE DOMAIN ITEM_RARIDADE
  AS CHAR(8)
  CHECK (VALUE IN ('comum', 'incomum', 'raro', 'epico', 'lendario', 'mitico'));

CREATE TABLE Arma (
    Id INTEGER NOT NULL,
    Nome VARCHAR(100) NOT NULL,
    Tipo ITEM_TIPO NOT NULL,
    Descricao VARCHAR(300) NOT NULL,
    Peso INTEGER NOT NULL,
    Raridade ITEM_RARIDADE NOT NULL,
    Consumivel BOOLEAN,
    Valor_de_ataque INTEGER NOT NULL,
    Valor_de_defesa INTEGER NOT NULL,
    Valor_de_agilidade INTEGER NOT NULL,

    CONSTRAINT arma_pk PRIMARY KEY(Id),
    CONSTRAINT id_arma_fk FOREIGN KEY(Id) REFERENCES Especializacao_do_item(Id)
);

CREATE TABLE Comida (
    Id INTEGER NOT NULL,
    Nome VARCHAR(100) NOT NULL,
    Tipo ITEM_TIPO NOT NULL,
    Descricao VARCHAR(300) NOT NULL,
    Peso INTEGER NOT NULL,
    Raridade ITEM_RARIDADE NOT NULL,
    Consumivel BOOLEAN,
    Valor_de_cura INTEGER NOT NULL,

    CONSTRAINT comida_pk PRIMARY KEY(Id),
    CONSTRAINT id_comida_fk FOREIGN KEY(Id) REFERENCES Especializacao_do_item(Id)
);

CREATE TABLE Pocao (
  Id INTEGER NOT NULL,
  Nome VARCHAR(100) NOT NULL,
  Tipo ITEM_TIPO NOT NULL,
  Descricao VARCHAR(300) NOT NULL,
  Peso INTEGER NOT NULL,
  Raridade ITEM_RARIDADE NOT NULL,
  Consumivel BOOLEAN,
  Bonus INTEGER NOT NULL,
  Duracao INTEGER NOT NULL,

  CONSTRAINT pocao_pk PRIMARY KEY(Id),
  CONSTRAINT id_pocao_fk FOREIGN KEY(Id) REFERENCES Especializacao_do_item(Id)
);

CREATE TABLE Armadura (
  Id INTEGER NOT NULL,
  Nome VARCHAR(100) NOT NULL,
  Tipo ITEM_TIPO NOT NULL,
  Descricao VARCHAR(300) NOT NULL,
  Peso INTEGER NOT NULL,
  Raridade ITEM_RARIDADE NOT NULL,
  Consumivel BOOLEAN,
  Valor_de_defesa INTEGER NOT NULL,
  Valor_de_agilidade INTEGER NOT NULL,

  CONSTRAINT armadura_pk PRIMARY KEY(Id),
  CONSTRAINT id_armadura_fk FOREIGN KEY(Id) REFERENCES Especializacao_do_item(Id)
);

CREATE TABLE Entidade (
    Nome VARCHAR(100) NOT NULL,
    Descricao VARCHAR(300) NOT NULL,
    
    CONSTRAINT entidade_pk PRIMARY KEY(Nome)
);

CREATE TABLE Habilidade (
    Nome VARCHAR(100) NOT NULL,
    Multiplicador_agilidade INTEGER NOT NULL,
    Multiplicador_ataque INTEGER NOT NULL,
    Multiplicador_defesa INTEGER NOT NULL,
    Multiplicador_roubo_de_vida INTEGER NOT NULL,
    Descricao VARCHAR(300) NOT NULL,
    Entidade VARCHAR(100) NOT NULL,
    
    CONSTRAINT habilidade_pk PRIMARY KEY(Nome),
    CONSTRAINT entidade_habilidade_fk FOREIGN KEY(Entidade) REFERENCES Entidade(Nome)
);

CREATE TABLE Recebe (
    Nome_habilidade VARCHAR(100) NOT NULL,
    Nome_viking VARCHAR(100) NOT NULL,
    Nome_entidade VARCHAR(100) NOT NULL,
    
    CONSTRAINT recebe_pk PRIMARY KEY(Nome_habilidade),
    CONSTRAINT habilidade_nome_fk FOREIGN KEY(Nome_habilidade) REFERENCES Habilidade(Nome),
    CONSTRAINT viking_nome_fk FOREIGN KEY(Nome_viking) REFERENCES Habilidade(Nome),
    CONSTRAINT entidade_nome_fk FOREIGN KEY(Nome_entidade) REFERENCES Entidade(Nome)
);

CREATE TABLE Aesir (
    Id VARCHAR(100) NOT NULL,
    TipoEntidade VARCHAR(100) NOT NULL,
    Bonus_ataque INTEGER NOT NULL,
    Bonus_agilidade INTEGER NOT NULL,
    
    CONSTRAINT aesir_pk PRIMARY KEY(Id),
    CONSTRAINT aesir_entidade_fk FOREIGN KEY(Id) REFERENCES Entidade(Nome)
);

CREATE TABLE Vanir (
    Id VARCHAR(100) NOT NULL,
    TipoEntidade VARCHAR(100) NOT NULL,
    Bonus_defesa INTEGER NOT NULL,
    Bonus_agilidade INTEGER NOT NULL,
    
    CONSTRAINT vanir_pk PRIMARY KEY(Id),
    CONSTRAINT vanir_entidade_fk FOREIGN KEY(Id) REFERENCES Entidade(Nome)
);

CREATE TABLE Jotun (
    Id VARCHAR(100) NOT NULL,
    TipoEntidade VARCHAR(100) NOT NULL,
    Bonus_ataque INTEGER NOT NULL,
    Bonus_defesa INTEGER NOT NULL,
    Bonus_agilidade INTEGER NOT NULL,
    Maldicao INTEGER NOT NULL,
    
    CONSTRAINT jotun_pk PRIMARY KEY(Id),
    CONSTRAINT jotun_entidade_fk FOREIGN KEY(Id) REFERENCES Entidade(Nome)
);

CREATE OR REPLACE FUNCTION 
	atualizar_volume_ocupado_mochila()
RETURNS TRIGGER AS $atualizar_volume_ocupado_mochila$

BEGIN
  IF (TG_OP = 'INSERT') THEN
    UPDATE Mochila SET VolumeOcupado = VolumeOcupado + 1
    WHERE Numero = NEW.Numero_Mochila;

  ELSIF (TG_OP = 'DELETE') THEN
    UPDATE Mochila SET VolumeOcupado = VolumeOcupado - 1
    WHERE Numero = OLD.Numero_Mochila;
  END IF;

	RETURN NULL;
END;
$atualizar_volume_ocupado_mochila$ LANGUAGE plpgsql;

CREATE TRIGGER AtualizarVolumeOcupado
	AFTER INSERT OR DELETE ON Item_Mochila
FOR EACH ROW EXECUTE PROCEDURE atualizar_volume_ocupado_mochila();

CREATE OR REPLACE FUNCTION 
	verificar_maos_ocupadas()
RETURNS TRIGGER AS $verificar_maos_ocupadas$

BEGIN
  IF (NEW.MaoEsquerda IS NOT NULL AND NEW.MaoDireita IS NOT NULL)  THEN
    NEW.MaosOcupadas := TRUE;
  ELSE
    NEW.MaosOcupadas := FALSE;
  END IF;

	RETURN NEW;
END;
$verificar_maos_ocupadas$ LANGUAGE plpgsql;

CREATE TRIGGER PreencherVariavelMaosOcupadas
	BEFORE INSERT OR UPDATE ON Viking
FOR EACH ROW EXECUTE PROCEDURE verificar_maos_ocupadas();


COMMIT;
