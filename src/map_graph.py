import os
import sys
from graph import Graph
from database import Database

class MapGraph():
  def __init__(self):
    self.db = Database()
    self.graph = Graph()
    
  def map_squares_to_graph_vertex(self):
    query = self.db.query("select * from quadrado")
    for square_tuple in query:
      data = {
        'area': square_tuple[1],
        'description': square_tuple[2],
        'center_x': -1, # used for pygame 
        'center_y': -1,  # used for pygame 
        'content': ''
      }
      self.graph.add_vertex(square_tuple[0], data)
    self.map_edges_db_graph()

  def map_edges_db_graph(self):
    init_x = 20 # used for pygame 
    init_y = 20 # used for pygame 
    for i in range(16):
      for j in range(24):
        current_vertex = str(i) + ',' + str(j)
        vertex_data = self.graph.vertexs[current_vertex]
        vertex_data['center_x'] = init_x + (j * 50) # used for pygame 
        vertex_data['center_y'] = init_y + (i * 50) # used for pygame 
        self.graph.vertexs[current_vertex] = vertex_data
        if j == 23 and i < 15:
          bottom_vertex = str(i + 1) + ',' + str(j)
          self.graph.add_edge(current_vertex, bottom_vertex)
        elif j == 23 and i == 15:
          continue
        if i == 15 and j < 23:
          right_vertex = str(i) + ',' + str(j + 1)
          self.graph.add_edge(current_vertex, right_vertex)
        elif i == 15 and j == 23:
          break
        else:
          if i < 15 and j < 23:
            bottom_vertex = str(i + 1) + ',' + str(j)
            right_vertex = str(i) + ',' + str(j + 1)
            self.graph.add_edge(current_vertex, right_vertex)
            self.graph.add_edge(current_vertex, bottom_vertex)

  def get_vertexs(self):
    return self.graph.get_vertexs()

  def get_neighbors(self, vertex):
    return self.graph.get_neighbors(vertex)

  def update_graph(self):
    vertexs = self.graph.get_vertexs()
    for vertex in vertexs:
      vertexs[vertex]['content'] = ''

    # Viking position
    query = self.db.query("SELECT Quadrado FROM Viking WHERE Nome = 'arthur'")
    position = query[0][0]
    vertexs[position]['content'] = 'Você'

     # NPCS
    query = self.db.query("SELECT * FROM InstanciaNPC")
    for npc_tuple in query:
      vertex = npc_tuple[3]
      vertex_data = vertexs[vertex]
      vertex_data['content'] = npc_tuple[1]

    # Instancia barco
    query = self.db.query("SELECT * FROM InstanciaBarco where nomeviking = 'arthur'")
    for barco_tuple in query:
      vertex = barco_tuple[5]
      vertex_data = vertexs[vertex]
      vertex_data['content'] = 'Barco'