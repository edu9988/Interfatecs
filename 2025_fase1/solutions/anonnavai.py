Q = int(input())

for i in range(Q):
  dorothy = int(input())
  dagmar = int(input())

  print( "DOROTHY" if dorothy > dagmar else "DAGMAR", end="" )
  print( " DECIDE", end="" )
  if dorothy + dagmar > 40:
    print( " E A NONNA VAI",end="" )
  print()
