# ══════════════════════════════════════════════════════════
# Solucionador.....: Prof. Lucio Nunes de Lira
# ══════════════════════════════════════════════════════════
# Competição.......: InterFatecs 2025 - Fase Final
# Programa.........: N - Os Cheque do Mário
# Autor do problema: Prof. Lucio Nunes de Lira
# Linguagem........: Python 3
# Interpretador....: CPython (3.13.5)
# Versão...........: A (Rev. 0)
# ——————————————————————————————————————————————————————————
# Observações:
#   Versão inicial que ainda poderá ser otimizada.
# ══════════════════════════════════════════════════════════

def formata_moeda(reais, centavos):
    reais = str(reais)
    reais = reais[::-1]
    formatado = ''
    i = 0
    while i < len(reais):
        formatado = reais[i] + formatado
        if (i+1) % 3 == 0 and i < len(reais)-1:
            formatado = '.' + formatado
        i += 1
    return f'R$ {formatado},{centavos:02}'

def extenso_para_numerico(v):
    if v == '': return 0

    n = 0

    trilhao = ['trilhao', 'trilhoes', 'trilhão', 'trilhões']

    for palavra in trilhao:
        if palavra in v:
            qtd = extenso_para_numerico(v[:v.index(palavra) - 1])
            n += qtd * 1_000_000_000_000
            v = v[v.index(palavra) + len(palavra):].removeprefix(' e ')
            break

    bilhao = ['bilhao', 'bilhoes', 'bilhão', 'bilhões']

    for palavra in bilhao:
        if palavra in v:
            qtd = extenso_para_numerico(v[:v.index(palavra) - 1])
            n += qtd * 1_000_000_000
            v = v[v.index(palavra) + len(palavra):].removeprefix(' e ')
            break

    milhao = ['milhao', 'milhoes', 'milhão', 'milhões']

    for palavra in milhao:
        if palavra in v:
            qtd = extenso_para_numerico(v[:v.index(palavra) - 1])
            n += qtd * 1_000_000
            v = v[v.index(palavra) + len(palavra):].removeprefix(' e ')
            break

    if 'mil' in v:
        if v.index('mil') == 0:
            qtd = 1
        else:
            qtd = extenso_para_numerico(v[:v.index('mil') - 1])
        n += qtd * 1_000
        v = v[v.index('mil') + len('mil'):].removeprefix(' e ')

    centenas = [('novecentos', 9), ('oitocentos', 8), ('setecentos', 7),
                ('seiscentos', 6), ('quinhentos', 5), ('quatrocentos', 4),
                ('trezentos', 3), ('duzentos', 2), ('cento', 1), ('cem', 1)]

    for centena, qtd in centenas:
        if centena in v:
            n += qtd * 100
            v = v[v.index(centena) + len(centena):].removeprefix(' e ')
            break

    dezenas = [('noventa', 9), ('oitenta', 8), ('setenta', 7), ('sessenta', 6),
               ('cinquenta', 5), ('quarenta', 4), ('trinta', 3), ('vinte', 2)]

    for dezena, qtd in dezenas:
        if dezena in v:
            n += qtd * 10
            v = v[v.index(dezena) + len(dezena):].removeprefix(' e ')
            break

    unidades = [('dezenove', 19), ('dezoito', 18), ('dezessete', 17), ('dezesseis', 16),
                ('quinze', 15), ('quatorze', 14), ('treze', 13), ('doze', 12), 
                ('onze', 11), ('dez', 10), ('nove', 9), ('oito', 8), ('sete', 7), 
                ('seis', 6), ('cinco', 5), ('quatro', 4), ('tres', 3), ('dois', 2), 
                ('um', 1), ('zero', 0)]

    for unidade, qtd in unidades:
        if unidade in v:
            n += qtd
            v = v[v.index(unidade) + len(unidade):]
            break

    return n

def main():
    total_reais = 0
    total_centavos = 0
    while True:
        try:
            v = input().lower().removesuffix('.')
            v = v.replace('de reais', 'reais')
            if 'reais' in v and 'centavos' in v:
                reais, centavos = v.split('reais')
                reais = reais.rstrip()
                centavos = centavos.removeprefix(' e ').removesuffix(' centavos')
                total_reais += extenso_para_numerico(reais)
                total_centavos += extenso_para_numerico(centavos)
            elif 'reais' in v and 'centavo' in v:
                reais, centavos = v.split('reais')
                reais = reais.rstrip()
                centavos = centavos.removeprefix(' e ').removesuffix(' centavo')
                total_reais += extenso_para_numerico(reais)
                total_centavos += extenso_para_numerico(centavos)
            elif 'real' in v and 'centavos' in v:
                reais, centavos = v.split('real')
                reais = reais.rstrip()
                centavos = centavos.removeprefix(' e ').removesuffix(' centavos')
                total_reais += extenso_para_numerico(reais)
                total_centavos += extenso_para_numerico(centavos)
            elif 'real' in v and 'centavo' in v:
                reais, centavos = v.split('real')
                reais = reais.rstrip()
                centavos = centavos.removeprefix(' e ').removesuffix(' centavo')
                total_reais += extenso_para_numerico(reais)
                total_centavos += extenso_para_numerico(centavos)
            elif 'reais' in v:
                reais = v.removesuffix(' reais')
                total_reais += extenso_para_numerico(reais)
            elif 'real' in v:
                reais = v.removesuffix(' real')
                total_reais += extenso_para_numerico(reais)
            elif 'centavos' in v:
                centavos = v.removesuffix(' centavos')
                total_centavos += extenso_para_numerico(centavos)
            elif 'centavo' in v:
                centavos = v.removesuffix(' centavo')
                total_centavos += extenso_para_numerico(centavos)
            if total_centavos > 99:
                total_reais += total_centavos // 100
                total_centavos = total_centavos % 100
        except (EOFError, KeyboardInterrupt):
            break
    print(f'Minimo: {formata_moeda(total_reais, total_centavos)}.')

main()
