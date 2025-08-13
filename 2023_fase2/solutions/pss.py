N = int(input())

for i in range(1,N+1):
  G, E, A, D, T = [int(x) for x in input().split()]

  if A == 1 or (G == 1 and D == 1):
    if T == 2:
      print( f"Cand. {i}: INDEFERIDO (exp)" )
    else:
      print( f"Cand. {i}: deferido (comprovar 3 anos)" )

  elif G == 1 and E == 1:
    if T == 5:
      print( f"Cand. {i}: deferido (comprovar 5 anos)" )
    else:
      print( f"Cand. {i}: INDEFERIDO (exp)" )

  else:
    print( f"Cand. {i}: INDEFERIDO (acad)" )

