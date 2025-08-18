pwd = input()

if len(pwd) < 6 or len(pwd) > 15:
  print( "False." )
else:
  lower = False
  upper = False
  digit = False
  weak = False

  for i in range(len(pwd)):
    if i+1 < len(pwd):
      if ord(pwd[i]) +1 == ord(pwd[i+1]):
        weak = True
        break
    if pwd[i] in ".,!?;:áéíóúâêôãàçÁÉíóÚÃÔÔÕÀÇ" or pwd[i] == ' ':
      weak = True
      break
    elif pwd[i] in "abcdefghijklmnopqrstuvwxyz":
      lower = True
    elif pwd[i] in "ABCDEFGHIJKLMNOPQRSTUVWXYZ":
      upper = True
    elif pwd[i] in "0123456789":
      digit = True

  if lower and upper and digit and not weak:
    print( "True." )
  else:
    print( "False." )
