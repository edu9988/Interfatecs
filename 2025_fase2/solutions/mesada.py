f, m, c = map(int, input().split())

mesada = ((m//f)//10)*10
resto = m - mesada*f
mesada_ultimo = mesada+resto

categoria = []
categoria_ultimo = []
for _ in range(c):
  if mesada >= 30:
    categoria.append(30)
    mesada -= 30
  elif mesada >= 20:
    categoria.append(20)
    mesada -= 20
  elif mesada >= 10:
    categoria.append(10)
    mesada -= 10
  else:
    categoria.append(0)

  if mesada_ultimo >= 30:
    categoria_ultimo.append(30)
    mesada_ultimo -= 30
  elif mesada_ultimo >= 20:
    categoria_ultimo.append(20)
    mesada_ultimo -= 20
  elif mesada_ultimo >= 10:
    categoria_ultimo.append(10)
    mesada_ultimo -= 10
  else:
    categoria_ultimo.append(0)

outString = ' '.join(map(str, categoria))
for _ in range(f-1):
  print(outString)
print(' '.join(map(str, categoria_ultimo)))
