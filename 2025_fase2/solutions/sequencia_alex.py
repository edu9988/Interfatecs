def proxima_linha(seq):
    resultado = []
    cont = 1
    for i in range(1, len(seq)):
        if seq[i] == seq[i - 1]:
            cont += 1
        else:
            resultado.append(str(cont))
            resultado.append(seq[i - 1])
            cont = 1
    # adiciona o último grupo
    resultado.append(str(cont))
    resultado.append(seq[-1])
    return "".join(resultado)

def sequencia_conway(n):
    linha = "1"
    for _ in range(1, n):
        linha = proxima_linha(linha)
    return linha

if __name__ == "__main__":
    n = int(input().strip())  # lê o número da linha
    print(sequencia_conway(n))
