import sys
from math import isqrt

X = int(input())

primes = [2]
primorials = [2]

i = 3
while primorials[-1] < X:
  found = False
  for p in primes:
    if i % p == 0:
      found = True
      break
  if not found:
    primes.append(i)
    nextPrimorial = primorials[-1]*i
    primorials.append(nextPrimorial)
  i += 2

print('S' if X in primorials else 'N')
