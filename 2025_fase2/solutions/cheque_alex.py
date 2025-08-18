import sys
import re

# Dicionário de valores por extenso para números básicos
UNITS = {
    "zero": 0, "um": 1, "uma": 1, "dois": 2, "duas": 2, "três": 3, "tres": 3, "quatro": 4, "cinco": 5,
    "seis": 6, "sete": 7, "oito": 8, "nove": 9, "dez": 10, "onze": 11, "doze": 12, "treze": 13,
    "quatorze": 14, "catorze": 14, "quinze": 15, "dezesseis": 16, "dezessete": 17, "dezoito": 18,
    "dezenove": 19
}

TENS = {
    "vinte": 20, "trinta": 30, "quarenta": 40, "cinquenta": 50, "sessenta": 60,
    "setenta": 70, "oitenta": 80, "noventa": 90
}

HUNDREDS = {
    "cem": 100, "cento": 100, "duzentos": 200, "duzentas": 200, "trezentos": 300, "trezentas": 300,
    "quatrocentos": 400, "quatrocentas": 400, "quinhentos": 500, "quinhentas": 500,
    "seiscentos": 600, "seiscentas": 600, "setecentos": 700, "setecentas": 700,
    "oitocentos": 800, "oitocentas": 800, "novecentos": 900, "novecentas": 900
}

MULTIPLIERS = {
    "mil": 10**3,
    "milhão": 10**6, "milhao": 10**6, "milhões": 10**6, "milhoes": 10**6,
    "bilhão": 10**9, "bilhao": 10**9, "bilhões": 10**9, "bilhoes": 10**9,
    "trilhão": 10**12, "trilhao": 10**12, "trilhões": 10**12, "trilioes": 10**12
}

def words_to_number(words):
    words = words.lower()
    words = re.sub(r"[^a-zà-ú\s]", "", words)  # remove pontuação
    tokens = words.split()

    total = 0
    current = 0

    for token in tokens:
        if token in UNITS:
            current += UNITS[token]
        elif token in TENS:
            current += TENS[token]
        elif token in HUNDREDS:
            current += HUNDREDS[token]
        elif token in MULTIPLIERS:
            mult = MULTIPLIERS[token]
            if current == 0:
                current = 1
            total += current * mult
            current = 0
        elif token == "e":
            continue

    total += current
    return total

def parse_line(line):
    line = line.strip().lower()
    if not line:
        return 0.0

    reais = 0
    centavos = 0

    if "real" in line or "reais" in line:
        reais_part = line.split("real")[0]
        reais = words_to_number(reais_part)

    if "centavo" in line:
        centavos_part = line.split("centavo")[0]
        if "real" in line or "reais" in line:
            centavos_part = centavos_part.split("reais")[-1]
        centavos = words_to_number(centavos_part)

    return reais + centavos / 100

total_sum = 0.0
for line in sys.stdin:
    total_sum += parse_line(line)

# Formata com vírgula para centavos no padrão brasileiro
print(f"minimo na conta: R$ {total_sum:,.2f}".replace(",", "X").replace(".", ",").replace("X", "."))
