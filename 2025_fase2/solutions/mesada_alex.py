def distribuir_mesada():
    import sys
    # Ler entrada
    entrada = sys.stdin.read().split()
    f = int(entrada[0])  # número de filhos
    m = int(entrada[1])  # valor total da mesada
    c = int(entrada[2])  # número de categorias

    # Calcular valor base por filho e o resto
    valor_base = m // f
    resto = m % f

    # Para cada filho
    categorias = []
    valor_restante = valor_base
    for _ in range(c):
        if valor_restante >= 30:
            categorias.append(30)
            valor_restante -= 30
        elif valor_restante >= 20:
            categorias.append(20)
            valor_restante -= 20
        elif valor_restante >= 10:
            categorias.append(10)
            valor_restante -= 10
        else:
            categorias.append(0)
    for i in range(f-1):
        print(' '.join(map(str, categorias)))
    resto = m - sum(categorias)*(f-1)

    # Para ultimo filho
    categorias = []
    valor_restante = resto
    for _ in range(c):
        if valor_restante >= 30:
            categorias.append(30)
            valor_restante -= 30
        elif valor_restante >= 20:
            categorias.append(20)
            valor_restante -= 20
        elif valor_restante >= 10:
            categorias.append(10)
            valor_restante -= 10
        else:
            categorias.append(0)

    # Imprimir a linha do filho
    print(' '.join(map(str, categorias)))


# Chamar a função principal
distribuir_mesada()