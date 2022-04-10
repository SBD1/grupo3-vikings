from database import Database

class Game():
  def __init__(self):
    self.db = Database()
    self.start_game()

  def show_menu(self):
    print("Bem-vindo ao mundo Viking!")
    print("Menu Principal")
    print("1 - Iniciar Jogo")
    print("2 - Sair")

  def start_game(self):
    self.show_menu()

     
  def close_db_connection(self):
    self.db.close()


game = Game()
game.close_db_connection()
