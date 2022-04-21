import os
from database import Database
from map_graph import MapGraph
from display_game_map import showMap
from tabulate import tabulate

class Game():
  def __init__(self, char):
    self.db = Database()
    self.map_graph = MapGraph()
    self.map_graph.map_squares_to_graph_vertex()
    self.char = char
    self.start_game()

  def open_map(self):
    self.map_graph.update_graph(self.char)
    posicao = self.db.query(f"SELECT Quadrado FROM Viking WHERE Nome = '{self.char}' ")
    showMap(self.map_graph.get_vertexs(), posicao[0][0])

  def movement(self):
    print("Escolha para onde ir")
    print("1 - Um quadrado acima")
    print("2 - Um quadrado abaixo")
    print("3 - Um quadrado a esquerda")
    print("4 - Um quadrado a direita")
    print("5 - Informacoes do quadrado atual")
    print("6 - Trocar acao")
    action = input('--------> ')
    

    if action == '1':
      a = self.db.query(f"SELECT Quadrado FROM Viking WHERE Nome = '{self.char}' ")
      pos = a[0][0]
      new_pos = pos.split(',')

      if new_pos[0] == '0':
        print('Impossivel se mover nessa direcao!')
        return -1

      new_pos = f'{str(int(new_pos[0]) - 1)},{new_pos[1]}'
      estaEmBarco = False
      posicaoViking = pos
      posicaoBarco = self.db.query(f"SELECT * FROM InstanciaBarco WHERE NomeViking = '{self.char}' AND Coordenadas = '{pos}'")
      id_barco = 0
      if len(posicaoBarco) > 0:
        id_barco = posicaoBarco[0][0]
        estaEmBarco = True
      if estaEmBarco:
        self.db.insert(f"UPDATE InstanciaBarco SET Coordenadas = '{new_pos}' WHERE IdBarco = {id_barco}")
      self.db.insert(f"UPDATE Viking SET Quadrado='{new_pos}' WHERE Nome='{self.char}';")
      return 0
  
    elif action == '2':
      a = self.db.query(f"SELECT Quadrado FROM Viking WHERE Nome = '{self.char}' ")
      pos = a[0][0]
      new_pos = pos.split(',')

      if new_pos[0] == '15':
        print('Impossivel se mover nessa direcao!')
        return -1 

      new_pos = f'{str(int(new_pos[0]) + 1)},{new_pos[1]}'
      estaEmBarco = False
      posicaoViking = pos
      posicaoBarco = self.db.query(f"SELECT * FROM InstanciaBarco WHERE NomeViking = '{self.char}' AND Coordenadas = '{pos}'")
      id_barco = 0
      if len(posicaoBarco) > 0:
        id_barco = posicaoBarco[0][0]
        estaEmBarco = True
      if estaEmBarco:
        self.db.insert(f"UPDATE InstanciaBarco SET Coordenadas = '{new_pos}' WHERE IdBarco = {id_barco}")
      self.db.insert(f"UPDATE Viking SET Quadrado='{new_pos}' WHERE Nome='{self.char}';")
      return 0
  
    elif action == '3':
      a = self.db.query(f"SELECT Quadrado FROM Viking WHERE Nome = '{self.char}' ")
      pos = a[0][0]
      new_pos = pos.split(',')

      if new_pos[1] == '0':
        print('Impossivel se mover nessa direcao!')
        return -1

      new_pos = f'{new_pos[0]},{str(int(new_pos[1]) - 1)}'
      estaEmBarco = False
      posicaoViking = pos
      posicaoBarco = self.db.query(f"SELECT * FROM InstanciaBarco WHERE NomeViking = '{self.char}' AND Coordenadas = '{pos}'")
      id_barco = 0
      if len(posicaoBarco) > 0:
        id_barco = posicaoBarco[0][0]
        estaEmBarco = True
      if estaEmBarco:
        self.db.insert(f"UPDATE InstanciaBarco SET Coordenadas = '{new_pos}' WHERE IdBarco = {id_barco}")
      self.db.insert(f"UPDATE Viking SET Quadrado='{new_pos}' WHERE Nome='{self.char}';")
      return 0

    elif action == '4':
      a = self.db.query(f"SELECT Quadrado FROM Viking WHERE Nome = '{self.char}' ")
      pos = a[0][0]
      new_pos = pos.split(',')

      if new_pos[1] == '23':
        print('Impossivel se mover nessa direcao!')
        return -1

      new_pos = f'{new_pos[0]},{str(int(new_pos[1]) + 1)}'
      estaEmBarco = False
      posicaoViking = pos
      posicaoBarco = self.db.query(f"SELECT * FROM InstanciaBarco WHERE NomeViking = '{self.char}' AND Coordenadas = '{pos}'")
      id_barco = 0
      if len(posicaoBarco) > 0:
        id_barco = posicaoBarco[0][0]
        estaEmBarco = True
      if estaEmBarco:
        self.db.insert(f"UPDATE InstanciaBarco SET Coordenadas = '{new_pos}' WHERE IdBarco = {id_barco}")
      self.db.insert(f"UPDATE Viking SET Quadrado='{new_pos}' WHERE Nome='{self.char}';")
      return 0

    elif action == '5':
      a = self.db.query(f"SELECT Quadrado FROM Viking WHERE Nome = '{self.char}' ")
      print(f'Voce se encontra na posicao ({a[0][0]})')
      try:
        self.open_map()
        return 0
      except:
        print('Nao foi possivel abrir o mapa')
        return 0
    elif action == '6':
      return 0
    else:
      print('Acao invalida.')
      return 1

    return

# call this function after killing a monster
  def add_xp(xp, self):
    a = self.db.query(f"SELECT Experiencia FROM Viking WHERE Nome = '{self.char}' ")
    self.db.insert(f"UPDATE Viking SET Experiencia='{a[0][0] + xp}' WHERE Nome='{self.char}';")
    self.db.commit()

  def add_life_level(self):
    a = self.db.query(f"SELECT Nivel_de_Vida FROM Viking WHERE Nome = '{self.char}' ")
    self.db.insert(f"UPDATE Viking SET Nivel_de_Vida='{a[0][0]+10}', Vida_Restante='{a[0][0]+10}' WHERE Nome='{self.char}';")
    self.db.commit()

  def add_atribute(self):
    print('Voce deseja adicionar 10 pontos em que atributo?')
    print("1 - Ataque")
    print("2 - Defesa")
    print("3 - Roubo de vida")
    print("4 - Agilidade")
    print("5 - Velocidade")
    action = input('--------> ')

    atribute = 'nil'

    if action == '1': 
      atribute = 'Ataque'
    if action == '2':
      atribute = 'Defesa'
    if action == '3':
      atribute = 'Roubo_de_Vida'
    if action == '4':
      atribute = 'Agilidade'
    if action == '5':
      atribute = 'Velocidade'
    
    if atribute != 'nil':
      a = self.db.query(f"SELECT {atribute} FROM Viking WHERE Nome = '{self.char}' ")
      self.db.insert(f"UPDATE Viking SET {atribute}='{a[0][0]+10}' WHERE Nome='{self.char}';")
      self.db.commit()

# call this function everytime a monster is killed
  def check_level_up(self):
    a = self.db.query(f"SELECT Experiencia FROM Viking WHERE Nome = '{self.char}' ")
    check = self.db.query(f"SELECT Nivel FROM Viking WHERE Nome = '{self.char}' ")
    b = self.db.query(f"SELECT Experiencia_para_Subir_de_Nivel FROM Nivel WHERE Valor = '{check[0][0]}' ")

    if a[0][0] >= b[0][0]:
      self.db.insert(f"UPDATE Viking SET Nivel='{check[0][0]+1}' WHERE Nome='{self.char}';")
      self.db.insert(f"UPDATE Viking SET Experiencia='{0}' WHERE Nome='{self.char}';")
      points = self.db.query(f"SELECT Pontos_ao_Subir FROM Nivel WHERE Valor = '{check[0][0]+1}' ")
      self.add_atribute()
      self.add_life_level()
      self.db.commit()
      check = self.db.query(f"SELECT Nivel FROM Viking WHERE Nome = '{self.char}' ")
      print(f'Parabens! Voce agora eh nivel {check[0][0]}!')

  def status(self):
    a = self.db.query(f"SELECT * FROM Viking WHERE Nome = '{self.char}' ")
    print(f'Nome -> {a[0][0]}')
    print(f'Experiencia -> {a[0][1]}, Nivel -> {a[0][2]}')
    print(f'Quadrado -> {a[0][7]}')
    print(f'Ataque -> {a[0][8]}, Defesa -> {a[0][9]}, Roubo de Vida -> {a[0][10]}')
    print(f'Agilidade -> {a[0][11]}, Velocidade -> {a[0][12]}')
    print(f'Nivel de Vida -> {a[0][13]}, Vida Restante -> {a[0][14]}')


  def tuples_list_to_list(self, lt:list):
    return [item for t in lt for item in t]


  def show_itens(self):
   
    id_mochila = self.tuples_list_to_list(self.db.query(f"SELECT Mochila FROM Viking WHERE Nome = '{self.char}' ") ) 

    mochila = self.tuples_list_to_list(self.db.query(f"SELECT Tipo, Capacidade, VolumeOcupado, Numero FROM Mochila M inner join Tipo_Mochila TM on M.tipo = TM.nome  WHERE Numero = '{id_mochila[0]}' ") ) 
 
    id_itens_mochila = tuple(self.tuples_list_to_list(self.db.query(f"SELECT Id_Item FROM Item_Mochila WHERE Numero_Mochila = '{id_mochila[0]}' ")))

    print(f'Mochila do tipo {mochila[0]}.')
    print(f'Capacidade total: {mochila[1]}.')
    print(f'Volume ocupado: {mochila[2]}.\n')

    if len(id_itens_mochila) == 0:
      print(f'A mochila está vazia.')
    else:
      tipo_itens_mochila = self.tuples_list_to_list(self.db.query(f"SELECT Tipo FROM Especializacao_do_item WHERE Id IN {id_itens_mochila} ") ) 
      itens = []
      for i, id in enumerate(id_itens_mochila): 
          item =  self.tuples_list_to_list(self.db.query(f"SELECT Id, Nome, Raridade, Peso FROM {tipo_itens_mochila[i].strip()} WHERE Id = {id} "))  
          itens.append(item)
      print (tabulate(itens, headers=["Item","Id", "Nome", "Raridade", "Peso"],   showindex="always"))



  def take_action(self):

    print("Escolha o que fazer")
    print("1 - Andar")
    print("2 - Abrir mochila")
    print("3 - Visualizar status")
    print("4 - Visualizar habilidades")
    print("5 - Abrir mapa")
    print("6 - Sair")
    action = input('--------> ')

    if action == '1':
      self.movement()
      self.db.commit()
      posicao_atual = self.db.query(f"SELECT Quadrado FROM Viking WHERE Nome = '{self.char}' ")
      print(f'Voce esta agora no quadrado {posicao_atual[0][0]}')
      return 0
    elif action == '2':
      self.show_itens()
      return 0
    elif action == '3':
      self.status()
      return 0
    elif action == '4':
      self.show_skills()
      return 0
    elif action == '5':
      try:
        self.open_map()
        return 0
      except:
        print('Nao foi possivel abrir o mapa')
        return 0
    elif action == '6':
      return -1
    else:
      print('Acao invalida.')
      return 1

  def show_menu(self):
    print("Bem-vindo ao mundo Viking!")
    print("Menu Principal")
    print("1 - Iniciar Jogo")
    print("2 - Sair")

  # check if monster is in square
  def check_square(self):
    a = self.db.query("SELECT Quadrado FROM Monstro WHERE Quadrado = '1,1' ")
    if a:
      print('Voce encontrou um monstro!')
      return 1
    else:
      return 0

  # check if player has item to be dropped
  def check_item(self):
    a = self.db.query("SELECT Item FROM Item WHERE Item = '1,1' ")
    if a:
      print('Voce encontrou um item!')
      return 1
    else:
      return 0
  
  # check if item is in square
  def check_item_square(self):
    a = self.db.query("SELECT Item FROM Item WHERE Item = '1,1' ")
    b = self.db.query("SELECT Viking FROM Viking WHERE Quadrado = '1,1' ")
    if a and b:
      print('Item está no mesmo bloco, você pode pegá-lo!')
      return 1
    else:
      return 0

  # create a new monster
  def create_monster(self):
    if self.check_square():
      print('Não é possivel criar um monstro neste quadrado!')
      return -1
    self.db.insert("INSERT INTO Monstro (Quadrado) VALUES ('1,1')")
    print('Monstro criado!')

  # kill monster
  def kill_monster(self):
    if self.check_square():
      self.db.insert("DELETE FROM Monstro WHERE Quadrado = '1,1'")
      print('Monstro morto!')
    else:
      print('Não há monstro neste quadrado!')

  # drop item
  def drop_item(self):
    if self.check_item():
      self.db.insert("DELETE FROM Item WHERE Item = '1,1'")
      print('Item dropado!')
    else:
      print('Não há item para ser dropado!')

  # pick up item
  def pick_up_item(self):
    if self.check_item_square():
      self.db.insert("INSERT INTO Item (Item) VALUES ('1,1')")
      print('Item pegado!')
    else:
      print('Não há item neste quadrado!')
  
  # show status
  def show_status(self):
    a = self.db.query(f"SELECT Nome, Vida, Ataque, Defesa, Inteligencia, Forca, Destreza, Sorte FROM Viking WHERE Nome = '{self.char}' ")
    print(f'Nome: {a[0][0]}')
    print(f'Vida: {a[0][1]}')
    print(f'Ataque: {a[0][2]}')
    print(f'Defesa: {a[0][3]}')
    print(f'Inteligencia: {a[0][4]}')
    print(f'Forca: {a[0][5]}')
    print(f'Destreza: {a[0][6]}')
    print(f'Sorte: {a[0][7]}')

  # show skills
  def show_skills(self):
    habilidade = self.tuples_list_to_list(self.db.query(f"SELECT Nome_habilidade, Nome_entidade, Descricao, Multiplicador_agilidade, Multiplicador_ataque, Multiplicador_defesa, Multiplicador_roubo_de_vida FROM Recebe R  inner join Habilidade H on R.nome_habilidade = H.nome WHERE Nome_viking = '{self.char}' ") ) 
    if len(habilidade) == 0:
      print(f"{self.char} não possui habilidade especiais.")
      print(f"Para receber uma habilidade é necessario adorar uma entidade.")
    else:
      print(f"{self.char} adora a entidade: {habilidade[1]}")
      print(f"e por isso recebeu a habilidade: {habilidade[0]}")
      print(f"{habilidade[2]}")
      print(f"\n Bônus:")
      print(f"\t Multiplicador agilidade: {habilidade[3]}")
      print(f"\t Multiplicador ataque: {habilidade[4]}")
      print(f"\t Multiplicador defesa: {habilidade[5]}")
      print(f"\t Multiplicador roubo de vida: {habilidade[6]}")
    
  
  
  # use skill during fight
  def use_skill(self):
    a = self.db.query(f"SELECT Nome, Habilidade1, Habilidade2, Habilidade3 FROM Viking WHERE Nome = '{self.char}' ")
    print(f'Nome: {a[0][0]}')
    print(f'Habilidade 1: {a[0][1]}')
    print(f'Habilidade 2: {a[0][2]}')
    print(f'Habilidade 3: {a[0][3]}')
    action = input('--------> ')
    if action == '1':
      print('Voce usou a habilidade 1')
    elif action == '2':
      print('Voce usou a habilidade 2')
    elif action == '3':
      print('Voce usou a habilidade 3')
    else:
      print('Acao invalida.')
  
  # check player's health 
  def check_player_health(self):
    a = self.db.query(f"SELECT Vida FROM Viking WHERE Nome = '{self.char}' ")
    if a[0][0] <= 0:
      print('Voce morreu!')
      return -1
    else:
      return 0
  
  # check monster's health
  def check_monster_health(self):
    a = self.db.query("SELECT Vida FROM Monstro WHERE Quadrado = '1,1' ")
    if a[0][0] <= 0:
      print('Monstro morreu!')
      return -1
    else:
      return 0

  # fight with monster
  def fight_monster(self):
    a = self.db.query(f"SELECT Vida FROM Viking WHERE Nome = '{self.char}' ")
    b = self.db.query("SELECT Vida FROM Monstro WHERE Quadrado = '1,1' ")
    while a[0][0] > 0 and b[0][0] > 0:
      print('Voce ataca o monstro!')
      print('Monstro ataca você!')
      a[0][0] = a[0][0] - b[0][0]
      b[0][0] = b[0][0] - a[0][0]
      print(f'Vida do monstro: {b[0][0]}')
      print(f'Vida do jogador: {a[0][0]}')
      if self.check_monster_health() == -1:
        break
      if self.check_player_health() == -1:
        break
    if a[0][0] <= 0:
      print('Voce morreu!')
    else:
      print('Monstro morreu!')

  # check if player is in the same square as monster
  def check_player_monster(self):
    a = self.db.query("SELECT Quadrado FROM Viking WHERE Quadrado = '1,1' ")
    b = self.db.query("SELECT Quadrado FROM Monstro WHERE Quadrado = '1,1' ")
    if a and b:
      print('Voce está no mesmo bloco do monstro!')
      self.fight_monster()
      return 1
    else:
      return 0

  # use life potion
  def use_life_potion(self):
    a = self.db.query(f"SELECT Vida FROM Viking WHERE Nome = '{self.char}' ")
    if a[0][0] <= 0:
      print('Voce está morto!')
      return -1
    else:
      self.db.insert(f"UPDATE Viking SET Vida = Vida + 10 WHERE Nome = '{self.char}' ")
      print('Vida restaurada!')

  # use item
  def use_item(self):
    a = self.db.query("SELECT Item FROM Item WHERE Item = '1,1' ")
    if a:
      print('Voce usou um item!')
      self.db.insert("DELETE FROM Item WHERE Item = '1,1' ")
    else:
      print('Voce não possui nenhum item!')

  # use luck potion
  def use_luck_potion(self):
    a = self.db.query(f"SELECT Sorte FROM Viking WHERE Nome = '{self.char}' ")
    if a[0][0] <= 0:
      return -1
    else:
      self.db.insert(f"UPDATE Viking SET Sorte = Sorte + 10 WHERE Nome = '{self.char}' ")
      print('Sorte aumentada!')
  
  # increase player's attack damage
  def increase_attack(self):
    a = self.db.query(f"SELECT Ataque FROM Viking WHERE Nome = '{self.char}' ")
    if a[0][0] <= 0:
      return -1
    else:
      self.db.insert(f"UPDATE Viking SET Ataque = Ataque + 10 WHERE Nome = '{self.char}' ")
      print('Ataque aumentado!')

  def start_game(self):
    self.show_menu()
    action = input('--------> ')
    os.system('cls' if os.name == 'nt' else 'clear')

    if action == '1':
      while(self.take_action() != -1):
        # check if local has enemy
          # if enemy exists, fight
        # self.check_square()
        # self.check_player_monster()

        # check if local has item to be dropped
        # self.check_item_square()
          # if exists, player choose to grab
        # check if local has npc
          # if npc exists, start conversation
        print('Clique em qualquer botao para realizar a proxima acao!')
        input()
        os.system('cls' if os.name == 'nt' else 'clear')

    else: 
      return 0

     
  def close_db_connection(self):
    self.db.close()


game = Game('arthur')
game.close_db_connection()
