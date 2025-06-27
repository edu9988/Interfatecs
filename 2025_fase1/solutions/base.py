ds, ys = [int(x) for x in input().split()]
dm, ym = [int(x) for x in input().split()]

pos_s = ys-ds
pos_m = ym-dm

while pos_s <= 5000 and pos_m <= 5000:
  if pos_s == pos_m:
    print(pos_s)
    break
  elif pos_s > pos_m:
    pos_m += ym
  else:
    pos_s += ys
