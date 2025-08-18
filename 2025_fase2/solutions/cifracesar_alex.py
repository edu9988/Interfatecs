import sys
import string

A = string.ascii_uppercase

def pos(letra): return (ord(letra.upper()) - 65) % 26

def decifrar(texto, chave):
    res = []
    for ch in texto:
        if ch.upper() in A:
            res.append(A[(pos(ch) - chave) % 26])
        else:
            res.append(ch)
    return "".join(res)

for linha in sys.stdin:
    linha = linha.strip("\n")
    if linha == "***":  # encerra
        break
    if len(linha) < 2 or not linha[-1].isalpha():
        continue

    c1, c2 = linha[-2], linha[-1]
    dif = (26 - ((pos(c1) - pos(c2)) % 26)) % 26
    base = "E" if dif == 9 else "R" if dif == 1 else None
    if base:
        chave = (pos(c2) - pos(base)) % 26
        print(decifrar(linha, chave))
