#solution by prof. banin
cont1 = cont2 = 0
m1, m2 = input().split()
while m1 != '-' and m2 != '-':
    if m1=='*' and m2=='V' or m1=='V' and m2=='O' or m1=='O' and m2=='*':
        cont1+=1
    if m2=='*' and m1=='V' or m2=='V' and m1=='O' or m2=='O' and m1=='*':
        cont2+=1
    m1, m2 = input().split()

if cont1 > cont2:
    print(f'BEATRIZ WIN')
elif cont1 < cont2:
    print(f'ARTUR WIN')
else:
    print('TIE')
