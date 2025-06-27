from math import sin, pi
while True:
  a, b, theta = [float(x) for x in input().split()]
  if (a,b,theta) == (0,0,0):
    break
  area = a*b*sin(pi*theta/180)/2
  print(f"{area:.4f}")
