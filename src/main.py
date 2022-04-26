from itertools import count
import os
from database import Database
from map_graph import MapGraph
from display_game_map import showMap
from tabulate import tabulate
import random

class Game():
  def __init__(self):
    self.db = Database()
    self.map_graph = MapGraph()
    self.map_graph.map_squares_to_graph_vertex()
    self.char = ''
    self.a_used = 0
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
      self.check_square(new_pos)
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
      self.check_square(new_pos)
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
      self.check_square(new_pos)
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
      self.check_square(new_pos)
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
      return -6
    else:
      print('Acao invalida.')
      return 1

    return

# call this function after killing a monster
  def add_xp(self, xp):
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
      print(f'Parabens! Voce agora eh nivel {check[0][0]}!')
      self.add_atribute()
      self.add_life_level()
      self.db.commit()
      check = self.db.query(f"SELECT Nivel FROM Viking WHERE Nome = '{self.char}' ")

      if check[0][0] == 2:
          m = self.db.query(f"SELECT Mochila FROM Viking WHERE Nome='{self.char}'")
          self.db.insert(f"UPDATE Mochila SET Tipo='normal' WHERE Numero='{m[0][0]}'")
          self.db.commit()

          print("\nII > Você ganhou uma mochila melhor para continuar sua jornada!\n")
      elif check[0][0] == 3:
          m = self.db.query(f"SELECT Mochila FROM Viking WHERE Nome='{self.char}'")
          self.db.insert(f"UPDATE Mochila SET Tipo='reforcada' WHERE Numero='{m[0][0]}'")
          self.db.commit()

          print("\nII > Você ganhou uma mochila reforçada!\n")
    else:
      print()
      print("Voce ainda nao tem experiencia suficiente para upar.")
      print(f'Faltam {b[0][0] - a[0][0]} de XP para o proximo nivel.')
      print()


  def status(self):
    print()
    a = self.db.query(f"SELECT * FROM Viking WHERE Nome = '{self.char}' ")
    print(f'Nome -> {a[0][0]}')
    print(f'Experiencia -> {a[0][1]}, Nivel -> {a[0][2]}')
    print(f'Quadrado -> {a[0][7]}')
    print(f'Ataque -> {a[0][8]}, Defesa -> {a[0][9]}, Roubo de Vida -> {a[0][10]}')
    print(f'Agilidade -> {a[0][11]}, Velocidade -> {a[0][12]}')
    print(f'Nivel de Vida -> {a[0][13]}, Vida Restante -> {a[0][14]}')
    print()


  def tuples_list_to_list(self, lt:list):
    return [item for t in lt for item in t]

  def withdraw_items(self):
    os.system('cls' if os.name == 'nt' else 'clear')
    
    q = self.db.query(f"SELECT Quadrado FROM Viking WHERE Nome='{self.char}'")[0][0]
    mp = self.db.query(f"SELECT Mochila FROM Viking WHERE Nome='{self.char}'")[0][0]
    saved_items = self.db.query(f"SELECT * FROM Item_Mochila WHERE Numero_Mochila={mp}")
    
    if saved_items:
      if len(saved_items) > 1: print("\nII > Itens Guardados.\n")
      else: print("\nII > Item Guardado.\n")
    
      item_number = 0
      for item in saved_items:
        ii = self.db.query(f"SELECT * FROM Instancia_item WHERE Id='{item[1]}'")[0]
        ei = self.db.query(f"SELECT * FROM Especializacao_do_item WHERE Id='{ii[1]}'")[0]
        
        if "arma " in ei[1]:
          item_number = item_number + 1
          a = self.db.query(f"SELECT * FROM Arma WHERE Id='{ei[0]}'")[0]            
          print(f"{item_number}) {a[1]} - {a[2]} | Peso: {a[4]}; Ataque: {a[5]}; Defesa: {a[6]}; Agilidade: {a[7]} | {a[3]}")
          saved_items[item_number - 1] = item + (a[4], )
        elif "comida" in ei[1]:
          item_number = item_number + 1
          c = self.db.query(f"SELECT * FROM Comida WHERE Id='{ei[0]}'")[0]
          print(f"{item_number}) {c[1]} - {c[2]} | Peso: {c[4]}; Pontos de Cura: {c[5]} | {c[3]}")
          saved_items[item_number - 1] = item + (c[4], )
        elif "pocao" in ei[1]:
          item_number = item_number + 1
          p = self.db.query(f"SELECT * FROM Pocao WHERE Id='{ei[0]}'")[0]
          print(f"{item_number}) {p[1]} - {p[2]} | Peso: {p[4]}; Bônus: {p[5]}; Duração: {p[6]} | {p[3]}")
          saved_items[item_number - 1] = item + (p[4], )
        elif "armadura" in ei[1]:
          item_number = item_number + 1
          ar = self.db.query(f"SELECT * FROM Armadura WHERE Id='{ei[0]}'")[0]
          print(f"{item_number}) {ar[1]} - {ar[2]} | Peso: {ar[4]}; Defesa: {ar[5]}; Agilidade: {ar[6]} | {ar[3]}")
          saved_items[item_number - 1] = item + (ar[4], )
    
      print("\nII > Insira os números, separados por vírgula, dos itens que deseja retirar.")
      print("II > Insira 0 para não retirar.")

      s = input('--------> ')
      print()

      if s != "0":
        for i in list(set(s.split(','))):
          try:
            if (int(i) > 0 and int(i) <= item_number):
              vom = self.db.query(f"SELECT VolumeOcupado FROM Mochila Where Numero={mp}")[0][0]
              nvo = vom - saved_items[int(i) - 1][2]

              self.db.insert(f"DELETE FROM Item_Mochila WHERE Numero_Mochila='{mp}' AND Id_Item='{saved_items[int(i) - 1][1]}'")
              self.db.insert(f"UPDATE Instancia_item SET Quadrado='{q}' WHERE Id='{saved_items[int(i) - 1][1]}'")
              self.db.commit()
              
              print(f"O item número {i} foi retirado com sucesso!")
            else:
              print(f"O número {i} não é um número válido!")
          except:
            print(f"O número {i} não é um número válido!")
    
    print()

  def choose_entity(self):
    print("Escolha uma entidade para adorar e receba a sua primeira habilidade!")
    print("1 - Thor, Deus associado a forca, trovoes, relampagos e tempestades.")
    print("    Habilidade - Arma de Trovao.")
    print("2 - Loki, Deus associado a trapaca, travessuras, fogo e tambem magia.")
    print("    Habilidade - Arma de Fogo e Sangue.")
    print("3 - Freyja, Deusa associada a beleza, fertilidade, amor e seidhr, magia para visualizacao e alteracao do futuro.")
    print("    Habilidade - Visao do Futuro.")
    print("4 - Surtur, Lider dos gigantes de fogo e inimigo dos deuses, causador de destruicao extrema durante o ragnarok.")
    print("    Habilidade - Fogo primeval.")

    s = input('--------> ')
    
    if s == '1':
      skill = 'Arma de Trovao'
      ent = 'Thor'
    elif s == '2':
      skill = 'Arma de Fogo e Sangue'
      ent = 'Loki'
    elif s == '3':
      skill = 'Visao do Futuro'
      ent = 'Freyja'
    elif s == '4':
      skill = 'Fogo primeval'
      ent = 'Surtur'
    else:
      print('Habilidade invalida!')
      return -1
    
    query_result = self.db.query(f"SELECT criar_recebe('{skill}', '{self.char}', '{ent}')")
    self.db.commit()

    return 0

  def show_itens(self):
   
    id_mochila = self.tuples_list_to_list(self.db.query(f"SELECT Mochila FROM Viking WHERE Nome = '{self.char}' ") ) 

    mochila = self.tuples_list_to_list(self.db.query(f"SELECT Tipo, Capacidade, VolumeOcupado, Numero FROM Mochila M inner join Tipo_Mochila TM on M.tipo = TM.nome  WHERE Numero = '{id_mochila[0]}' ") ) 
 
    id_itens_mochila = tuple(self.tuples_list_to_list(self.db.query(f"SELECT Id_Item FROM Item_Mochila WHERE Numero_Mochila = '{id_mochila[0]}' ")))
    print(f'Mochila do tipo {mochila[0]}.')
    print(f'Capacidade total: {mochila[1]}kg')
    print(f'Volume ocupado: {mochila[2]}kg\n')

    if len(id_itens_mochila) == 0:
      print(f'A mochila está vazia.')
    else:
      tipo_itens_mochila = self.db.query(f"SELECT Tipo, id_item, II.id as instancia_id, consumivel \
      FROM instancia_item II \
      INNER JOIN especializacao_do_item EI \
      ON II.id_item = EI.id \
      WHERE II.id IN ({','.join(map(str, id_itens_mochila))})")
      itens = []
      for i in range(len(id_itens_mochila)): 
          query = f"SELECT Id, Nome, Raridade, Peso FROM {tipo_itens_mochila[i][0].strip()} WHERE Id = {tipo_itens_mochila[i][1]}"
          consumivel = "Sim" if tipo_itens_mochila[i][3] else "Não"
          item =  (*self.tuples_list_to_list(self.db.query(query)),  consumivel)  
          itens.append(item)
      print (tabulate(itens, headers=["Item","Id", "Nome", "Raridade", "Peso(kg)", "Consumivel"],   showindex="always"))

      print("\nII > Deseja retirar algo? (s/n)")
      s = input('--------> ')

      if s == "s": self.withdraw_items()

  def investigate_location(self, a_pos):
    items_found = self.db.query(f"SELECT * FROM Instancia_item WHERE Quadrado = '{a_pos[0][0]}'")
      
    if items_found:
      if len(items_found) > 1: print("\nII > Itens Encontrados.\n")
      else: print("\nII > Item Encontrado.\n")

      item_number = 0      
      for item in items_found:
        ei = self.db.query(f"SELECT * FROM Especializacao_do_item WHERE Id='{item[1]}'")[0]

        if "arma " in ei[1]:
          item_number = item_number + 1
          a = self.db.query(f"SELECT * FROM Arma WHERE Id='{item[1]}'")[0]            
          print(f"{item_number}) {a[1]} - {a[2]} | Peso: {a[4]}; Ataque: {a[5]}; Defesa: {a[6]}; Agilidade: {a[7]} | {a[3]}")
          items_found[item_number - 1] = item + (a[4], )
        elif "comida" in ei[1]:
          item_number = item_number + 1
          c = self.db.query(f"SELECT * FROM Comida WHERE Id='{item[1]}'")[0]
          print(f"{item_number}) {c[1]} - {c[2]} | Peso: {c[4]}; Pontos de Cura: {c[5]} | {c[3]}")
          items_found[item_number - 1] = item + (c[4], )
        elif "pocao" in ei[1]:
          item_number = item_number + 1
          p = self.db.query(f"SELECT * FROM Pocao WHERE Id='{item[1]}'")[0]
          print(f"{item_number}) {p[1]} - {p[2]} | Peso: {p[4]}; Bônus: {p[5]}; Duração: {p[6]} | {p[3]}")
          items_found[item_number - 1] = item + (p[4], )
        elif "armadura" in ei[1]:
          item_number = item_number + 1
          ar = self.db.query(f"SELECT * FROM Armadura WHERE Id='{item[1]}'")[0]
          print(f"{item_number}) {ar[1]} - {ar[2]} | Peso: {ar[4]}; Defesa: {ar[5]}; Agilidade: {ar[6]} | {ar[3]}")
          items_found[item_number - 1] = item + (ar[4], )

      selected_items = []

      mo = self.db.query(f"SELECT MaosOcupadas FROM Viking WHERE Nome='{self.char}'")[0][0]
      if mo:
        print("\nII > Suas mãos estão ocupadas.")
      else:
        mdo = self.db.query(f"SELECT MaoDireita FROM Viking WHERE Nome='{self.char}'")[0][0]
        
        if mdo:
          print("\nII > Sua Mão Direita está ocupada.")
        else:
          print("\nII > Insira o número do item que deseja equipar na Mão Direita.")
          print("II > Insira 0 para não coletar.")

          e = input('--------> ')
          print()

          if e != "0":
            try:
              if (int(e) > 0 and int(e) <= item_number):
                self.db.insert(f"UPDATE Viking SET MaoDireita='{items_found[int(e) - 1][0]}' WHERE Nome='{self.char}'")
                self.db.insert(f"UPDATE Instancia_item SET Quadrado=NULL WHERE Id='{items_found[int(e) - 1][0]}'")
                self.db.commit()
                
                print(f"O item número {e} foi equipado na Mão Direita com sucesso!")
                selected_items.append(items_found[int(e) - 1][0])
              else:
                print(f"O número {e} não é um número válido!")
            except:
              print(f"O número {e} não é um número válido!")

        mde = self.db.query(f"SELECT MaoEsquerda FROM Viking WHERE Nome='{self.char}'")[0][0]

        if mde:
          print("\nII > Sua Mão Esquerda está ocupada.")
        else:
          print("\nII > Insira o número do item que deseja equipar na Mão Esquerda.")
          print("II > Insira 0 para não coletar.")

          e1 = input('--------> ')
          print()

          if e1 != "0":
            try:
              if (int(e1) > 0 and int(e1) <= item_number):
                if items_found[int(e1) - 1][0] not in selected_items:
                  self.db.insert(f"UPDATE Viking SET MaoEsquerda='{items_found[int(e1) - 1][0]}' WHERE Nome='{self.char}'")
                  self.db.insert(f"UPDATE Instancia_item SET Quadrado=NULL WHERE Id='{items_found[int(e1) - 1][0]}'")
                  self.db.commit()

                  print(f"O item número {e1} foi equipado na Mão Esquerda com sucesso!")
                  selected_items.append(items_found[int(e1) - 1][0])
                else:
                  print(f"O número {e1} foi selecionado anteriormente.")
              else:
                print(f"O número {e1} não é um número válido!")
            except:
              print(f"O número {e1} não é um número válido!")

      print("\nII > Insira os números, separados por vírgula, dos itens que deseja coletar.")
      print("II > Insira 0 para não coletar.")
            
      s = input('--------> ')
      print()

      if s != "0":
        mp = self.db.query(f"SELECT Mochila FROM Viking Where Nome='{self.char}'")[0]
        dmp = self.db.query(f"SELECT * FROM Mochila Where Numero={mp[0]}")[0]
        cm = self.db.query(f"SELECT Capacidade FROM Tipo_Mochila Where Nome='{dmp[1]}'")[0][0]

        for i in s.split(","):
          try:
            if (int(i) > 0 and int(i) <= item_number):
              if items_found[int(i) - 1][0] not in selected_items:
                vom = self.db.query(f"SELECT VolumeOcupado FROM Mochila Where Numero={mp[0]}")[0][0]

                if (vom + items_found[int(i) - 1][3] > cm):
                  print(f"O item número {i} não cabe na mochila. Tente liberar espaço.")
                else:
                  nvo = vom + items_found[int(i) - 1][3]

                  self.db.insert(f"INSERT INTO Item_Mochila VALUES ('{dmp[0]}', '{items_found[int(i) - 1][0]}')")
                  self.db.insert(f"UPDATE Instancia_item SET Quadrado=NULL WHERE Id='{items_found[int(i) - 1][0]}'")
                  self.db.commit()

                  print(f"O item número {i} foi guardado com sucesso!")
              else:
                print(f"O número {i} foi selecionado anteriormente.")                
            else:
              print(f"O número {i} não é um número válido!")
          except:
            print(f"O número {i} não é um número válido!")

        print()

  def show_equipment(self):
    md = self.db.query(f"SELECT MaoDireita FROM Viking WHERE Nome='{self.char}'")[0][0]
    if md:
      ii = self.db.query(f"SELECT Id_item FROM Instancia_item WHERE Id={md}")[0][0]
      ei = self.db.query(f"SELECT * FROM Especializacao_do_item WHERE Id={ii}")[0]

      if "arma " in ei[1]:
        a = self.db.query(f"SELECT * FROM Arma WHERE Id='{ei[0]}'")[0]
        print(f"\n> Mão Direita: {a[1]} - {a[2]} | Peso: {a[4]}; Ataque: {a[5]}; Defesa: {a[6]}; Agilidade: {a[7]} | {a[3]}")
      elif "comida" in ei[1]:
        c = self.db.query(f"SELECT * FROM Comida WHERE Id='{ei[0]}'")[0]
        print(f"\n> Mão Direita: {c[1]} - {c[2]} | Peso: {c[4]}; Pontos de Cura: {c[5]} | {c[3]}")
      elif "pocao" in ei[1]:
        p = self.db.query(f"SELECT * FROM Pocao WHERE Id='{ei[0]}'")[0]
        print(f"\n> Mão Direita: {p[1]} - {p[2]} | Peso: {p[4]}; Bônus: {p[5]}; Duração: {p[6]} | {p[3]}")
      elif "armadura" in ei[1]:
        ar = self.db.query(f"SELECT * FROM Armadura WHERE Id='{ei[0]}'")[0]
        print(f"\n> Mão Direita: {ar[1]} - {ar[2]} | Peso: {ar[4]}; Defesa: {ar[5]}; Agilidade: {ar[6]} | {ar[3]}")

    else:
      print("\n> Mão Direita vazia!")

    me = self.db.query(f"SELECT MaoEsquerda FROM Viking WHERE Nome='{self.char}'")[0][0]
    if me:
      iie = self.db.query(f"SELECT Id_item FROM Instancia_item WHERE Id={me}")[0][0]
      eie = self.db.query(f"SELECT * FROM Especializacao_do_item WHERE Id={iie}")[0]

      if "arma " in eie[1]:
        a = self.db.query(f"SELECT * FROM Arma WHERE Id='{eie[0]}'")[0]
        print(f"\n> Mão Esquerda: {a[1]} - {a[2]} | Peso: {a[4]}; Ataque: {a[5]}; Defesa: {a[6]}; Agilidade: {a[7]} | {a[3]}\n")
      elif "comida" in eie[1]:
        c = self.db.query(f"SELECT * FROM Comida WHERE Id='{eie[0]}'")[0]
        print(f"\n> Mão Esquerda: {c[1]} - {c[2]} | Peso: {c[4]}; Pontos de Cura: {c[5]} | {c[3]}\n")
      elif "pocao" in eie[1]:
        p = self.db.query(f"SELECT * FROM Pocao WHERE Id='{eie[0]}'")[0]
        print(f"\n> Mão Esquerda: {p[1]} - {p[2]} | Peso: {p[4]}; Bônus: {p[5]}; Duração: {p[6]} | {p[3]}\n")
      elif "armadura" in eie[1]:
        ar = self.db.query(f"SELECT * FROM Armadura WHERE Id='{eie[0]}'")[0]
        print(f"\n> Mão Esquerda: {ar[1]} - {ar[2]} | Peso: {ar[4]}; Defesa: {ar[5]}; Agilidade: {ar[6]} | {ar[3]}\n")

    else:
      print("\n> Mão Esquerda vazia!\n")

  def unequip_items(self):
    print("II > Deseja desequipar algo?")
    print("I > Insira d para desequipar a Mão Direita.")
    print("I > Insira e para desequipar a Mão Esquerda.")
    print("I > Insira a para desequipar ambas Mãos.")
    print("I > Insira 0 para não desequipar.")

    s = input('--------> ')
    print()

    q = self.db.query(f"SELECT MaoDireita, MaoEsquerda, Quadrado FROM Viking WHERE Nome='{self.char}'")[0]

    if (s == "d" or s == "a"):
      if q[0]:
        self.db.insert(f"UPDATE Viking SET MaoDireita=NULL WHERE Nome='{self.char}'")
        self.db.insert(f"UPDATE Instancia_item SET Quadrado='{q[2]}' WHERE Id={q[0]}")
        self.db.commit()

        print("Mão Direita desequipada!\n")
      else:
        print("Mão Direita sem equipamento!\n")
    
    if (s == "e" or s == "a"):
      if q[1]:
        self.db.insert(f"UPDATE Viking SET MaoEsquerda=NULL WHERE Nome='{self.char}'")
        self.db.insert(f"UPDATE Instancia_item SET Quadrado='{q[2]}' WHERE Id={q[1]}")
        self.db.commit()

        print("Mão Esquerda desequipada!\n")
      else:
        print("Mão Esquerda sem equipamento!\n") 
    
    if (s not in ["d", "e", "a"]):
      print("Não desequipar selecionado.\n")

  def take_action(self):
    print("Escolha o que fazer")
    print("1 - Investigar local atual")
    print("2 - Andar")
    print("3 - Visualizar itens equipados")
    print("4 - Abrir mochila")
    print("5 - Visualizar status")
    print("6 - Visualizar habilidades")
    print("7 - Abrir mapa")
    print("8 - Verificar se posso subir de nivel")
    print("9 - Sair")

    action = input('--------> ')

    if action == '1':
      a_pos = self.db.query(f"SELECT Quadrado FROM Viking WHERE Nome = '{self.char}' ")
      print(f'Local atual: {a_pos[0][0]}')
      self.investigate_location(a_pos)
      return 0

    elif action == '2':
      r = self.movement()

      self.db.commit()
      a_pos = self.db.query(f"SELECT Quadrado FROM Viking WHERE Nome = '{self.char}' ")
      print(f'Voce esta agora no quadrado {a_pos[0][0]}')
      self.monster_encounter(a_pos)

      if (r != -6):
        self.investigate_location(a_pos)

      return 0

    elif action == '3':
      self.show_equipment()
      self.unequip_items()
      return 0
    
    elif action == '4':
      self.show_itens()
      return 0
    elif action == '5':
      self.status()
      return 0
    elif action == '6':
      self.show_skills()
      return 0
    elif action == '7':
      try:
        self.open_map()
        return 0
      except:
        print('Nao foi possivel abrir o mapa')
        return 0
    elif action == '8':
      self.check_level_up()
      return 0
    elif action == '9':
      return -1
    else:
      print('Acao invalida.')
      return 1

  def show_menu(self):
    os.system('cls' if os.name == 'nt' else 'clear')

    print("Bem-vindo ao mundo Viking!\n")
    print("--- Menu Principal ---\n")
    print("1 - Iniciar Novo Jogo")
    print("2 - Iniciar Jogo Salvo")
    print("3 - Sair")

  # check if monster is in square
  def check_square(self, a_pos):     
    monster = self.db.query(f"SELECT * FROM Monstro WHERE Quadrado = '{a_pos[0][0]}'")
    if monster:
      os.system('cls' if os.name == 'nt' else 'clear')
      print('Monstro encontrado!')
      print(f"Um {monster[0][0]} se encontra nesse quadrado.")
      return monster[0][0]
    return ' '
 

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
  def drop_item(self, monster, square):
    itens_to_drop = self.tuples_list_to_list(self.db.query(f"SELECT id_item FROM Dropa WHERE nome_tipo_monstro = '{monster}' "))

    if(len(itens_to_drop) == 0):
      print("Nenhum item para ser dropado.")
    
    count = self.tuples_list_to_list(self.db.query(f"SELECT COUNT(*) id FROM instancia_item"))[0]

    for item_to_drop in itens_to_drop:
      count = count + 1
      self.db.insert(f"INSERT INTO instancia_item (id, id_item, quadrado) VALUES ({count}, {item_to_drop}, '{square}')")
      self.db.commit()

    print("Itens dropados.")


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
  
  # # show status
  # def show_status(self):
  #   a = self.db.query(f"SELECT Nome, Vida, Ataque, Defesa, Inteligencia, Forca, Destreza, Sorte FROM Viking WHERE Nome = '{self.char}' ")
  #   print(f'Nome: {a[0][0]}')
  #   print(f'Vida: {a[0][1]}')
  #   print(f'Ataque: {a[0][2]}')
  #   print(f'Defesa: {a[0][3]}')
  #   print(f'Inteligencia: {a[0][4]}')
  #   print(f'Forca: {a[0][5]}')
  #   print(f'Destreza: {a[0][6]}')
  #   print(f'Sorte: {a[0][7]}')

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
    new_game_successful, save_game_successful = False, False

    while 1:
      self.show_menu()
      action = input('--------> ')

      if action == '1':
        os.system('cls' if os.name == 'nt' else 'clear')

        print("--- Iniciar Novo Jogo ---\n")
        print("> Insira 0 para voltar ao Menu Principal\n")

        viking_name = input("Insira o nome do viking: ")

        if viking_name != "0": 
          is_name_already_use = self.db.query("SELECT * FROM Personagem Where Nome='" + viking_name + "'")
          
          while is_name_already_use:
            print("\n!! > Esse nome já está sendo utilizado!\n")

            viking_name = input("Insira o nome do viking: ")
            
            if viking_name == "0": break
            
            is_name_already_use = self.db.query("SELECT * FROM Personagem Where Nome='" + viking_name + "'")

          if not is_name_already_use:
            new_game_successful = True

            self.char = viking_name

            query_result = self.db.query("SELECT criar_viking('" + viking_name + "')")
            while self.choose_entity() == -1:
              continue
            fala_npc = self.db.query("SELECT * FROM fala WHERE idnpc = 'GuiaDeJornada'")
            print('\nII > {}'.format(fala_npc[0][1]))
            print("\nII > Parabéns! Você ganhou uma mochila básica para iniciar sua aventura.\n")
            input("II > Está pronto para começar? Insira qualquer tecla para continuar.")

            self.db.commit()
            break

      if action == '2':
        os.system('cls' if os.name == 'nt' else 'clear')

        print("--- Iniciar Jogo Salvo ---\n")
        print("> Insira 0 para voltar ao Menu Principal\n")

        game_number = 0
        save_games = self.db.query("SELECT * FROM Viking")
        
        for save_game in save_games:
          game_number = game_number + 1
          print(str(game_number) + " - " + save_game[0])

        number = input("\nInsira o número do jogo que deseja carregar: ")

        if number != "0":
          while int(number) < 0 or int(number) > game_number:
            print("\n!! > Número inválido!\n")

            number = input("Insira o número do jogo que deseja carregar: ")

            if number == "0": break

          if int(number) > 0 and int(number) <= game_number:
            save_game_successful = True

            self.char = save_games[int(number) - 1][0]

            break

      if action == '3':
        break

    os.system('cls' if os.name == 'nt' else 'clear')

    if new_game_successful or save_game_successful:
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

  def check_player_health(self):
    player_health = self.db.query(f"SELECT Vida_Restante FROM Viking WHERE Nome = '{self.char}'")
    return player_health[0][0]

  def check_monster_health(self, monster):
    monster_health = self.db.query(f"SELECT Vida_Restante FROM Monstro WHERE Nome = '{monster}'")
    if monster_health[0][0] <= 0:
      monster_xp = self.db.query(f"SELECT Experiencia FROM Monstro M INNER JOIN TipoMonstro TM ON M.tipo = TM.nome WHERE M.Nome = '{monster}'")
      self.db.insert(f"DELETE FROM Monstro WHERE Nome = '{monster}' ")
      return monster_xp[0][0]
    else:
      return 0

  def use_skill(self):
    a = self.db.query(f"SELECT Nome_habilidade FROM Recebe WHERE Nome_viking = '{self.char}' ")
    b = self.db.query(f"SELECT * FROM Habilidade WHERE Nome = '{a[0][0]}' ")
    print()
    print(f'1 - Habilidade: {a[0][0]}')
    print(f'Efeitos: {b[0][5]}')
    print(f'0 - Retornar')
    action = input('--------> ')
    if action == '1':
      query = self.db.query(f"SELECT Ataque, Defesa, Roubo_de_Vida, Agilidade, Velocidade FROM Viking WHERE Nome = '{self.char}'")
      new_att = query[0][0] * b[0][2]
      new_def = query[0][1] * b[0][3]
      new_ls = query[0][2] * b[0][4]
      new_ag = query[0][3] * b[0][1]
      self.db.insert(f"UPDATE Viking SET Ataque = '{new_att}', Defesa = '{new_def}', Roubo_de_Vida = '{new_ls}', Agilidade = '{new_ag}'")
      self.db.commit()
      return
    else:
      return
  
  # MONSTER ATTACK MISSING
  def attack(self, is_monster, monster):
    if not is_monster:
      dmg = self.db.query(f"SELECT Ataque FROM Viking WHERE Nome = '{self.char}' ")
      # weapon_dmg = self.db.query(f"")
      # new_dmg = dmg[0][0] + weapon_dmg[0][0]
      m_attributes = self.db.query(f"SELECT Vida_restante, Defesa FROM Monstro WHERE Nome = '{monster}'")
      real_dmg = dmg[0][0] // m_attributes[0][1]
      monster_new_health = m_attributes[0][0] - real_dmg
      if monster_new_health < 0:
        monster_new_health = 0
      self.db.insert(f"UPDATE Monstro SET Vida_restante = '{monster_new_health}'")
      self.db.commit()
      if monster_new_health > 0:
        print(f'Voce deu {real_dmg} de dano e seu inimigo possui {monster_new_health} de vida!')
      else:
        print(f'Voce deu {real_dmg} de dano e matou seu inimigo!')
      return
    else:
      # monster attack
      return

  def flee(self):
    query = self.db.query(f"SELECT Velocidade FROM Viking WHERE Nome = '{self.char}'")
    has_fled = random.randrange(100)
    random_treshold = random.randrange(100)
    random_treshold_five = random.randrange(5)
    if has_fled >= random_treshold * (random_treshold_five/query[0][0]):
      print()
      print('Voce escapou com sucesso!')
      print()
      return 0
    print()
    print('Nao conseguiu escapar!')
    print()
    return -1

  def player_turn(self, monster):
    print()
    print('Sua vez de realizar uma acao na batalha!')
    print('1 - Ataque')
    print('2 - Usar habilidade')
    print('3 - Tentar fugir')
    print('4 - Ver status')
    action = input('--------> ')
    
    while True:
      if action == '1':
        self.attack(False, monster)
        return
      elif action == '2' and self.a_used == 0:
        self.use_skill()
        self.a_used = 1
        return
      elif action == '2' and self.a_used != 0:
        print()
        print('Voce ja usou a habilidade nessa batalha!')
        print()
        print('Sua vez de realizar uma acao na batalha!')
        print('1 - Ataque')
        print('2 - Usar habilidade')
        print('3 - Tentar fugir')
        print('4 - Ver status')
        action = input('--------> ')
        pass
      elif action == '3':
        if self.flee() == 0:
          self.a_used = 0
          self.db.insert(f"UPDATE Viking SET Quadrado = '8,1' WHERE Nome = '{self.char}'")
        return
      elif action == '4':
        self.status()
        return
      else:
        print('Acao invalida!')
        print()
        print('Sua vez de realizar uma acao na batalha!')
        print('1 - Ataque')
        print('2 - Usar habilidade')
        print('3 - Tentar fugir')
        print('4 - Ver status')
        action = input('--------> ')
        pass

  # NOT IMPLEMENTED YET
  def monster_turn(self, monster):
    pass

  def reset_status(self):
    a = self.db.query(f"SELECT Nome_habilidade FROM Recebe WHERE Nome_viking = '{self.char}' ")
    b = self.db.query(f"SELECT * FROM Habilidade WHERE Nome = '{a[0][0]}' ")
    query = self.db.query(f"SELECT Ataque, Defesa, Roubo_de_Vida, Agilidade, Velocidade FROM Viking WHERE Nome = '{self.char}'")
    new_att = query[0][0] // b[0][2]
    new_def = query[0][1] // b[0][3]
    new_ls = query[0][2] // b[0][4]
    new_ag = query[0][3] // b[0][1]
    print(new_att)
    print(new_def)
    print(new_ls)
    print(new_ag)
    self.db.insert(f"UPDATE Viking SET Ataque = '{new_att}', Defesa = '{new_def}', Roubo_de_Vida = '{new_ls}', Agilidade = '{new_ag}'")
    self.db.commit()

  def fight(self, monster):
    while True:
      if self.check_player_health() <= 0:
        return -1
      is_monster_dead = self.check_monster_health(monster)
      if is_monster_dead != 0:
        return is_monster_dead
      self.player_turn(monster)
      # self.monster_turn(monster)
  
  def monster_encounter(self, square):
    monster = self.check_square(square)
    if monster != ' ':
      monster_xp = self.fight(monster)
      if monster_xp != -1:
        self.add_xp(monster_xp)
        # self.drop_item(monster, square)
        self.a_used = 0
        self.reset_status()
      else:
        os.system('cls' if os.name == 'nt' else 'clear')
        print('Voce foi morto.')
        self.a_used = 0
        self.reset_status()
        self.db.insert(f"UPDATE Viking SET Quadrado = '8,1', Vida_Restante = Nivel_de_Vida WHERE Nome = '{self.char}'")
        input('Aperte qualquer tecla para continuar.')
        os.system('cls' if os.name == 'nt' else 'clear')
    else:
      pass

  def close_db_connection(self):
    self.db.close()


game = Game()
game.close_db_connection()
