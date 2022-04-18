from database import Database
import os

class Game():
  def __init__(self):
    self.db = Database()
    self.start_game()

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
      a = self.db.query("SELECT Quadrado FROM Viking WHERE Nome = 'joao' ")
      pos = a[0][0]
      new_pos = pos.split(',')

      if new_pos[1] == '0':
        print('Impossivel se mover nessa direcao!')
        return -1

      new_pos = f'{new_pos[0]},{str(int(new_pos[1]) - 1)}'
      self.db.insert(f"UPDATE Viking SET Quadrado='{new_pos}' WHERE Nome='joao';")
      print(f'Voce esta agora no quadrado {new_pos}')
      return 0
  
    elif action == '2':
      a = self.db.query("SELECT Quadrado FROM Viking WHERE Nome = 'joao' ")
      pos = a[0][0]
      new_pos = pos.split(',')

      if new_pos[1] == '15':
        print('Impossivel se mover nessa direcao!')
        return -1 

      new_pos = f'{new_pos[0]},{str(int(new_pos[1]) + 1)}'
      self.db.insert(f"UPDATE Viking SET Quadrado='{new_pos}' WHERE Nome='joao';")
      print(f'Voce esta agora no quadrado {new_pos}')
      return 0
  
    elif action == '3':
      a = self.db.query("SELECT Quadrado FROM Viking WHERE Nome = 'joao' ")
      pos = a[0][0]
      new_pos = pos.split(',')

      if new_pos[0] == '0':
        print('Impossivel se mover nessa direcao!')
        return -1

      new_pos = f'{str(int(new_pos[0]) - 1)},{new_pos[1]}'
      self.db.insert(f"UPDATE Viking SET Quadrado='{new_pos}' WHERE Nome='joao';")
      print(f'Voce esta agora no quadrado {new_pos}')
      return 0

    elif action == '4':
      a = self.db.query("SELECT Quadrado FROM Viking WHERE Nome = 'joao' ")
      pos = a[0][0]
      new_pos = pos.split(',')

      if new_pos[0] == '23':
        print('Impossivel se mover nessa direcao!')
        return -1

      new_pos = f'{str(int(new_pos[0]) + 1)},{new_pos[1]}'
      self.db.insert(f"UPDATE Viking SET Quadrado='{new_pos}' WHERE Nome='joao';")
      print(f'Voce esta agora no quadrado {new_pos}')
      return 0

    elif action == '5':
      a = self.db.query("SELECT Quadrado FROM Viking WHERE Nome = 'joao' ")
      print(f'Voce se encontra na posicao ({a[0][0]})')
      return 0
    elif action == '6':
      return 0
    else:
      print('Acao invalida.')
      return 1

    return

  def take_action(self):
    print("Escolha o que fazer")
    print("1 - Andar")
    print("2 - Abrir mochila")
    print("3 - Visualizar status")
    print("4 - Visualizar habilidades")
    print("5 - Sair")
    action = input('--------> ')

    if action == '1':
      self.movement()
      return 0
    elif action == '2':
      return 0
    elif action == '3':
      return 0
    elif action == '4':
      return 0
    elif action == '5':
      return -1
    else:
      print('Acao invalida.')
      return 1

  def show_menu(self):
    print("Bem-vindo ao mundo Viking!")
    print("Menu Principal")
    print("1 - Iniciar Jogo")
    print("2 - Sair")

  # check if monster is in squere
  def check_squere(self):
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
  
  # check if item is in squere
  def check_item_squere(self):
    a = self.db.query("SELECT Item FROM Item WHERE Item = '1,1' ")
    b = self.db.query("SELECT Viking FROM Viking WHERE Quadrado = '1,1' ")
    if a and b:
      print('Item está no mesmo bloco, você pode pegá-lo!')
      return 1
    else:
      return 0

  # create a new monster
  def create_monster(self):
    if self.check_squere():
      print('Não é possivel criar um monstro neste quadrado!')
      return -1
    self.db.insert("INSERT INTO Monstro (Quadrado) VALUES ('1,1')")
    print('Monstro criado!')

  # kill monster
  def kill_monster(self):
    if self.check_squere():
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
    if self.check_item_squere():
      self.db.insert("INSERT INTO Item (Item) VALUES ('1,1')")
      print('Item pegado!')
    else:
      print('Não há item neste quadrado!')
  
  # show status
  def show_status(self):
    a = self.db.query("SELECT Nome, Vida, Ataque, Defesa, Inteligencia, Forca, Destreza, Sorte FROM Viking WHERE Nome = 'joao' ")
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
    a = self.db.query("SELECT Nome, Habilidade1, Habilidade2, Habilidade3 FROM Viking WHERE Nome = 'joao' ")
    print(f'Nome: {a[0][0]}')
    print(f'Habilidade 1: {a[0][1]}')
    print(f'Habilidade 2: {a[0][2]}')
    print(f'Habilidade 3: {a[0][3]}')
  
  # show inventory
  def show_inventory(self):
    a = self.db.query("SELECT Item FROM Item WHERE Item = '1,1' ")
    if a:
      print('Voce possui um item!')
    else:
      print('Voce não possui nenhum item!')
  
  # use skill during fight
  def use_skill(self):
    a = self.db.query("SELECT Nome, Habilidade1, Habilidade2, Habilidade3 FROM Viking WHERE Nome = 'joao' ")
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
  def check_health(self):
    a = self.db.query("SELECT Vida FROM Viking WHERE Nome = 'joao' ")
    if a[0][0] <= 0:
      print('Voce morreu!')
      return -1
    else:
      return 0

  def start_game(self):
    self.show_menu()
    action = input('--------> ')
    os.system('cls' if os.name == 'nt' else 'clear')

    if action == '1':
      while(self.take_action() != -1):
        # check if local has enemy
          # if enemy exists, fight
        self.check_squere()
        # check if local has item to be dropped
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


game = Game()
game.close_db_connection()
