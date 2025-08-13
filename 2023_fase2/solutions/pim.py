N = int(input())

if N > 0:
  print( '1', sep='', end='' )

for i in range(2,N+1):
  if i%4 == 0:
    print( ' pim', sep='', end='' )
  else:
    print( f" {i}", sep='', end='' )

print()
