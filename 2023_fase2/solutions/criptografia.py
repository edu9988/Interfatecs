from math import isqrt

table = []

def getSieve(N):
  isPrime = [True]*(N+1)
  isPrime[0] = isPrime[1] = False
  limit = isqrt(N)+1
  for i in range(2,limit):
    if isPrime[i]:
      for j in range(i*i, N+1, i):
        isPrime[j] = False
  return isPrime

sieve = getSieve(5050*122+1)
primes = [i for i, isPrime in enumerate(sieve) if isPrime]

def factors(N):
  ls = []
  i = 0
  while primes[i] <= N:
    if N % primes[i] == 0:
      N = N // primes[i]
      ls.append(primes[i])
      if N == 1:
        break
    else:
      i += 1
  return ls

def hash( pwd ):
  Sum = 0
  for i in range( len(pwd) ):
    pos = i+1
    Sum += ord(pwd[i])*pos
  Factors = factors(Sum)
  output = str(Sum)
  for i in Factors:
    output += str(i)
  return output

while True:
  line = input()
  if line == "ACABOU":
    break

  U, S = line.split()
  V = hash(S)
  table.append( [U,V] )

table.sort( key=lambda x:x[0] )
for user, hashValue in table:
  print( f"usuario...: {user}" )
  print( f"valor hash: {hashValue}" )
  print( f"------------------------------" )
