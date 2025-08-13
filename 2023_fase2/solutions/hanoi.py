N = int(input())
total = 2**N -1

line = [int(x) for x in input().split()]

binary = 0
base = 2**(N-1)
for i in range(N):
  binary += line[i]*base
  base = base // 2

print( total-binary )
