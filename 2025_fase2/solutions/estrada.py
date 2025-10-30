import sys
from heapq import heappush, heappop

N, M, K, R = [int(x) for x in input().split()]
cypria = [int(x) for x in input().split()]
S, T = [int(x) for x in input().split()]

roads = []
for _ in range(M):
  roads.append( [int(x) for x in input().split()] )

#cities = map( lambda x:{'links':[], 'cypria':False}, range(N+1) )
cities = [{'links':[], 'cypria':False} for _ in range(N+1)]
cities[0] = None

for i in cypria:
  cities[i]['cypria'] = True

for u, v, w, p in roads:
  cities[u]['links'].append({
    'from':u,
    'to':v,
    'weight':w,
    'safe':p
  })
  cities[v]['links'].append({
    'from':v,
    'to':u,
    'weight':w,
    'safe':p
  })

# float('inf') can fail with 9e+9999999999
dist = [[[float('inf')]*2 for _ in range(K+1)] for _ in range(N+1)]

startCy = 1 if cities[S]['cypria'] else 0
dist[S][0][startCy] = 0

# d, node, k, cy
pq = [[0, S, 0, startCy]]

while pq:
  d, node, k, cy = heappop(pq)

  if d != dist[node][k][cy]:
    continue

  if node == T and cy == 1:
    print(d)
    sys.exit()

  for road in cities[node]['links']:
    next_k = k + road['safe']
    if next_k > K:
      continue

    next_cy = 1 if (cy == 1 or cities[road['to']]['cypria']) else 0
    next_d = d + road['weight']

    if next_d < dist[road['to']][next_k][next_cy]:
      dist[road['to']][next_k][next_cy] = next_d
      heappush(pq, [next_d, road['to'], next_k, next_cy])

print(-1)
