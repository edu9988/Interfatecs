def gcd_extended(a, b):
    if b == 0:
        return (a, 1, 0)
    d, x1, y1 = gcd_extended(b, a % b)
    x = y1
    y = x1 - (a // b) * y1
    return (d, x, y)

def ceil_div(a, b):
    return (a + (b if b > 0 else -b) - 1) // b

a, b, c = map(int, input().split())
d, x0, y0 = gcd_extended(a, b)

if c % d != 0:
    print("IMPOSSIVEL")
    exit()

x0 *= c // d
y0 *= c // d
k = b // d
l = a // d

t_min = ceil_div(-x0, k)
t_max = y0 // l

best_x = best_y = -1
best_sum = float('inf')

for t in range(t_min, t_max + 1):
    x = x0 + k * t
    y = y0 - l * t
    if x >= 0 and y >= 0:
        total = x + y
        if total < best_sum or (total == best_sum and x < best_x):
            best_sum = total
            best_x = x
            best_y = y

if best_x == -1:
    print("IMPOSSIVEL")
else:
    print(best_x, best_y)

