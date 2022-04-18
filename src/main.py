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
