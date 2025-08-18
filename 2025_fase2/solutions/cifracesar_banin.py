# Usando list comprehension e d variável, passo variável e leitura da entrada

def defineDeslocamento(s):
    final = s[len(s)-4:len(s)]
    for i in range(1, 27):
        d = ''.join([chr(65+(ord(c)-65-i)%26) if ord(c) in range(65, 91) else c for c in final])
        if d == 'SPQR' or d[1:4] == 'AVE':
            return i
    return -1


sIn = input()
while sIn != '***':
    d = defineDeslocamento(sIn)
    # descriptografa
    sOut = ''.join([chr(65+(ord(c)-65-d)%26) if ord(c) in range(65, 91) else c for c in sIn])
    print(sOut)
    sIn = input()
