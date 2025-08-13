n = int(input())

deps = []
for _ in range(n):
  a, b = input().split()
  if a in deps:
    print( "usar injecao tardia" )
    exit(0)
  deps.append(a)

print( "ok" )
