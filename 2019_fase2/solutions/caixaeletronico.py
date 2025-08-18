bills = []

for i in range(3):
  VN, QTDE = map(int, input().split())
  bills.append( [VN, QTDE, chr(ord('A')+i)] )

bills.sort(key=lambda x:-x[0])
largeVN = bills[0][0]
mediumVN = bills[1][0]
smallVN = bills[2][0]

NSAQUES = int(input())

for _ in range(NSAQUES):
  targetValue = int(input())
  i = 0
  j = 0
  k = 0
  currentValue = i*largeVN + j*mediumVN + k*smallVN
  backtrackMedium = False
  backtrackLarge = False

  while currentValue != targetValue:
    if currentValue + largeVN <= targetValue and not backtrackLarge:
      i += 1
    elif currentValue + mediumVN <= targetValue and not backtrackMedium:
      j += 1
    elif currentValue + smallVN <= targetValue:
      k += 1
    else:
      if backtrackMedium and i > 0:
        i -= 1
        backtrackLarge = True
        backtrackMedium = False
      elif j > 0:
        j -= 1
        backtrackMedium = True
      else:
        backtrackMedium = True
      #backtrack

    currentValue = i*largeVN + j*mediumVN + k*smallVN

  #print( f"Target value: {targetValue}" )
  #print( f"{i}*{largeVN} + {j}*{mediumVN} + {k}*{smallVN}" )
  bills[0][1] -= i
  bills[1][1] -= j
  bills[2][1] -= k

bills.sort(key=lambda x:ord(x[2]))
#print("bills:",bills)
for _, QTDE, CHAR in bills:
  print( f"na bandeja {CHAR} restaram {QTDE} notas" )
