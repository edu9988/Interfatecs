X, Y, R = map(float, input().split())

N = int(input())

R2 = R*R
count = 0
for _ in range(N):
    xi,yi = map(float, input().split())
    dist = ((X-xi)**2 + (Y-yi)**2)
    if dist <= R2:
        count += 1

print(count)
