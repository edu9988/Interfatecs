N = int(input())

count_ones = 0

for _ in range(N):
  P = int(input())
  if P == 1:
    count_ones += 1

print( "par" if (N+count_ones)%2 == 0 else "impar" )
