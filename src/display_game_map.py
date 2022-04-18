import os
import sys
import time
import pygame
os.environ['PYGAME_HIDE_SUPPORT_PROMPT'] = "hide"

BLACK = (0, 0, 0)
WHITE = (255, 255, 255)
BLUE = (0, 0, 255)
GREEN = (0, 255, 0)
GRAY = (186, 186, 186)
RED = (255, 0, 0)
ISLAND_COLOR = (255, 230, 204)
WINDOW_HEIGHT = 800
WINDOW_WIDTH = 1200

def drawGridLines(SCREEN):
  blockSize = 50 # Set the size of the grid block
  for x in range(0, WINDOW_WIDTH, blockSize):
      for y in range(0, WINDOW_HEIGHT, blockSize):
          rect = pygame.Rect(x, y, blockSize, blockSize)
          pygame.draw.rect(SCREEN, BLACK, rect, 1)


def showMap(data):
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
      string = FONT.render(square_text, True, BLACK if not square_text == 'Você' else RED)
      if len(square_text) > 1:
          SCREEN.blit(string, [data[square]['center_x'] - (2.5 * len(square_text)), data[square]['center_y']])
      else:
          SCREEN.blit(string, [data[square]['center_x'], data[square]['center_y']])
  drawGridLines(SCREEN)
  while True:
    pygame.display.update() 
    for event in pygame.event.get():
        if event.type == pygame.KEYDOWN or event.type == pygame.QUIT:
            del FONT
            pygame.quit()
            return



if __name__ == '__main__':
    main()
