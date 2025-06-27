T = int(input())

data = []

for _ in range(3):
  tecido, lucro = [int(x) for x in input().split()]
  lucroPorComprimento = lucro/tecido
  data.append([tecido,lucro,lucroPorComprimento])

data.sort(key= lambda x: -x[0])
data.sort(key= lambda x: -x[2])

valor = 0

for line in data:
  tecido, lucro, _ = line
  valor += (T//tecido)*lucro
  T -= (T//tecido)*tecido

print(valor)
