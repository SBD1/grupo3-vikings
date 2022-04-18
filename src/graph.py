class Graph:
  def __init__(self):
    self.vertexs = {}

  def add_vertex(self, vertex, data):
    data['neighbors'] = []
    self.vertexs[vertex] = data

  def add_edge(self, origin, destiny):
    self.vertexs[origin]['neighbors'].append(destiny)
    self.vertexs[destiny]['neighbors'].append(origin)

  def get_vertexs(self):
    return self.vertexs

  def get_neighbors(self, vertex):
    return self.vertexs[vertex]['neighbors']

  def print(self):
    print('\n')
    for vertex in self.vertexs:
      print("['{}'] = {}".format(vertex, self.vertexs[vertex]))
    print('\n')