N = int(input())

min = 0
current = 0
for i in range(N):
  current += int(input())
  if current < min:
    min = current
print(-min)
