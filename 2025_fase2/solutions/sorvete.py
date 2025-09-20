N, D = map(int, input().split())

clients = []

for _ in range(N):
  clients.append(int(input()))

clients.sort()

groups=0

i=0
while i < N:
  groups+=1
  j=i+1
  while j < N and clients[j] - clients[i] <= D:
    j+=1
  i=j

print(groups)
