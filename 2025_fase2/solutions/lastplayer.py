n, k = map(int, input().split())

players = list(range(1,n+1))

j=0
while len(players) > 1:
  j = (j+k-1)%len(players)
  del players[j]

print(players[0])
