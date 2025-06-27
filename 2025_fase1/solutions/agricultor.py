N = int(input())

for i in range(N):
  line = input().split()
  T = float(line[0])
  U = float(line[1])
  P = int(line[2])

  if P == 1:
    print("NAO REGAR")
  else:
    if T > 30.0 and U < 50:
      print("REGAR")
    else:
      print("NAO REGAR")
