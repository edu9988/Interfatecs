def getDiff(before, after):
  x = ord(before)-65
  y = ord(after)-65
  return (y-x)%26

def decrypt(after, diff):
  o = ord(after)
  if o<65 or o>90:
    return after
  o -= 65
  o -= diff
  return chr(65+(o%26))

while True:
  encrypted=input().strip()
  if encrypted == '***':
    break

  x = getDiff('A', encrypted[-3])
  y = getDiff('V', encrypted[-2])
  z = getDiff('E', encrypted[-1])

  if x != y or y != z:
    x = getDiff('R', encrypted[-1])

  for char in encrypted:
    print(decrypt(char, x),end='')
  print()
