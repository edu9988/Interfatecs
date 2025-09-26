#solution by prof. banin
solucao = None
a, b, c = map(int, input().split())
maxE = c // a
for nE in range(maxE):
    nT = (c - nE * a) / b
    if nT.is_integer() and (solucao == None or nE+nT < sum(solucao)):
        solucao = (nE, int(nT))
print('IMPOSSIVEL') if solucao == None else print(f'{solucao[0]} {solucao[1]}')

