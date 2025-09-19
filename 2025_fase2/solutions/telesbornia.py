S = input().strip()

N = int(input())

pattern, size = [], []

for _ in range(N):
  newPattern = input()
  pattern.append(newPattern)
  size.append(len(newPattern))

def recursive(i):
  if i == len(S):
    return 1

  total = 0
  for j in range( len(pattern) ):
    if pattern[j] == S[i:i+size[j]]:
      total += recursive(i+size[j])

  return total

print(recursive(0))
