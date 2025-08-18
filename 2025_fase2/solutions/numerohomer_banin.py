Epsilon = 0.001
N = int(input())
while N != 0:
    Max = 1
    while Max ** Max < N:
        Max += 1
    Min = Max - 1
    if Max ** Max == N:
        print(f'{Max}:00:000')
    else:
        HS = (Max + Min) / 2
        while abs(HS ** HS - N) >= Epsilon:
            if HS ** HS > N:
                Max = HS
            else:
                Min = HS
            HS = (Max + Min) / 2
        m = int(HS)
        s = (HS - m) * 60
        mil = (s - int(s)) * 1000
        print(f'{m}:{int(s):02}:{int(mil):03}')
    N = int(input())


