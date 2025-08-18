N, L = map(int, input().split())

def getFriend( n ):
  Sum = 0
  for i in range(1,n//2+1):
    if n%i == 0:
      Sum += i
  return Sum

i=1
found = False
currentFriend = L

while i<=N:
  nextFriend = getFriend(currentFriend)
  #print( f"{i+1}th friend: {nextFriend}" )
  if nextFriend == L:
    found = True
    break
  currentFriend = nextFriend
  i += 1

print( "sim" if found else "nao" )
