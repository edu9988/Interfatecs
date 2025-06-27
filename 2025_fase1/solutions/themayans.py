while True:
  try:
    line = input().split()
  except EOFError:
    break

  sum = 0
  length = line.__len__()
  for i in range(length):
    for symbol in line[i]:
      if symbol == '.':
        sum += (20**(length-i-1))
      elif symbol == '-':
        sum += (20**(length-i-1))*5
  print(sum)

