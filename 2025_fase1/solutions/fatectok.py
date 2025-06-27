import math

def bfs(grafo,inicio,fim):
  visitados = set()
  fila = [(inicio,0)]
  i=0

  while i<len(fila):
    atual, dist = fila[i]
    i+=1
    if atual == fim:
      return dist
    if atual not in visitados:
      visitados.add(atual)
      for vizinho in grafo.get(atual,[]):
        fila.append((vizinho,dist+1))
  return -1

def main():
  Qc = int(input())
  grafo = {}

  for _ in range(Qc):
    a,b = input().strip().split()
    if a not in grafo:
      grafo[a] = []
    grafo[a].append(b)
    if b not in grafo:
      grafo[b] = []
    grafo[b].append(a)
  while True:
    linha = input().strip()
    if linha == "-":
      break
  while True:
    linha = input().strip()
    if linha == "* *":
      break
    a, b =linha.split()
    distancia = bfs(grafo,a,b)
    if distancia == -1:
      print(f"{a}-{b} = sem conexao")
    else:
      print(f'{a}-{b} = {distancia}')

main()
