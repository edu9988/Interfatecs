def calculaAcertosTempo(solucoes):
    acertos = tempo = 0
    for i in range(0, 2*NP, 2):
        if solucoes[i+1] > 0:
            acertos += 1
            tempo += solucoes[i+1]
            if solucoes[i] > 1:   # acertou em 2 tentativas ou mais, penaliza em 20 minutos
                tempo += 20 * (solucoes[i] - 1)
    return acertos, tempo

def rev(s):
    a = ''
    for i in range(len(s)):
        a = a + chr(65+ord('z')-ord(s[i]))
    return a

def chave(a):
    return (a[4], a[0])

Times = []
NP = int(input())
QT = int(input())
for i in range(QT):
    Time, Fatec = input().split('|')
    solucoes = list(map(int, input().split()))
    acertos, tempo = calculaAcertosTempo(solucoes)
    Times.append([Time, Fatec, acertos, tempo, acertos*100000+10000-tempo])
#Times.sort(key=chave, reverse = True)
Times = sorted(Times, key = lambda x: (x[4], rev(x[0])), reverse=True)
for t in Times:
    print(f'{t[0]} - {t[1]} ({t[2]},{t[3]})')
