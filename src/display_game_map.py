import os
import sys
import time
import pygame
os.environ['PYGAME_HIDE_SUPPORT_PROMPT'] = "hide"

BLACK = (0, 0, 0)
WHITE = (255, 255, 255)
BLUE = (71, 71, 255)
GREEN = (128, 255, 128)
GRAY = (186, 186, 186)
RED = (255, 0, 0)
ISLAND_COLOR = (255, 230, 204)
WINDOW_HEIGHT = 800
WINDOW_WIDTH = 1500

def drawGridLines(SCREEN):
  blockSize = 50 # Set the size of the grid block
  for x in range(0, WINDOW_WIDTH - 300, blockSize): # -300 pois o grid vai até 1200(largura) e a largura da tela é 1500
      for y in range(0, WINDOW_HEIGHT, blockSize):
          rect = pygame.Rect(x, y, blockSize, blockSize)
          pygame.draw.rect(SCREEN, BLACK, rect, 1)

def drawInfo(SCREEN, FONT, posicao, estaEmBarco):

  string = FONT.render('Áreas do mapa', True, BLACK)
  SCREEN.blit(string, (1250, 30))

  rect = pygame.Rect(1250, 50, 50, 50)
  pygame.draw.rect(SCREEN, GRAY, rect, 0)
  rect = pygame.Rect(1250, 100, 50, 50)
  pygame.draw.rect(SCREEN, GREEN, rect, 0)
  rect = pygame.Rect(1250, 150, 50, 50)
  pygame.draw.rect(SCREEN, ISLAND_COLOR, rect, 0)
  rect = pygame.Rect(1250, 200, 50, 50)
  pygame.draw.rect(SCREEN, BLUE, rect, 0)

  string = FONT.render('Vila Viking', True, BLACK)
  SCREEN.blit(string, (1305, 70))
  string = FONT.render('Floresta Negra', True, BLACK)
  SCREEN.blit(string, (1305, 120))
  string = FONT.render('Ilha', True, BLACK)
  SCREEN.blit(string, (1305, 170))
  string = FONT.render('Mar', True, BLACK)
  SCREEN.blit(string, (1305, 220))
      

  string = FONT.render('"?" pode significar Item ou Monstro', True, BLACK)
  SCREEN.blit(string, (1240, 300))
  string = FONT.render('Você está na coordenada [{}]'.format(posicao), True, BLACK)
  SCREEN.blit(string, (1240, 320))
  if estaEmBarco:
    string = FONT.render('Você está em um barco'.format(posicao), True, RED)
    SCREEN.blit(string, (1240, 340))

  string = FONT.render('Pressione qualquer tecla para fechar', True, BLACK)
  SCREEN.blit(string, (1240, 750))

def showMap(data, posicao):
  pygame.init()
  pygame.display.set_caption('Mapa Vikings')  
  SCREEN = pygame.display.set_mode((WINDOW_WIDTH, WINDOW_HEIGHT))
  SCREEN.fill(WHITE)
  FONT = pygame.font.SysFont(None, 20)
  blockSize = 50
  for square in data:
    rect = pygame.Rect(data[square]['center_x'] - 20, data[square]['center_y'] - 20, blockSize, blockSize)
    if data[square]['area'] == 1:
        pygame.draw.rect(SCREEN, GRAY, rect, 0)
    elif data[square]['area'] == 2:
        pygame.draw.rect(SCREEN, GREEN, rect, 0)
    elif data[square]['area'] == 3:
        pygame.draw.rect(SCREEN, ISLAND_COLOR, rect, 0)
    elif data[square]['area'] == 4:
        pygame.draw.rect(SCREEN, BLUE, rect, 0)
    square_text = data[square]['content']
    if len(square_text) == 0:
        square_text = ['']
    string = FONT.render(square_text[0], True, BLACK if not 'Você' in square_text else RED)
    if len(square_text[0]) > 1:
        SCREEN.blit(string, [data[square]['center_x'] - (2.5 * len(square_text[0])), data[square]['center_y']])
    else:
        SCREEN.blit(string, [data[square]['center_x'], data[square]['center_y']])
  drawGridLines(SCREEN)
  estaEmBarco = False
  if 'Barco' in data[posicao]['content'] and 'Você' in data[posicao]['content']:
    estaEmBarco = True
  drawInfo(SCREEN, FONT, posicao, estaEmBarco)

  while True:
    pygame.display.update() 
    for event in pygame.event.get():
        if event.type == pygame.KEYDOWN or event.type == pygame.QUIT:
            del FONT
            pygame.quit()
            return



if __name__ == '__main__':
    main()
