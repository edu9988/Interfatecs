from decimal import Decimal, getcontext

getcontext().prec = 30

total = Decimal('0')

x = Decimal('0')
while True:
  try:
    line = input()
  except EOFError:
    break

  line = line.strip('.').split()

  #print(line)
  for i in line:
    #print(i,end=' ')
    match i.lower():
      case 'um':
        x += Decimal('1')
      case 'dois':
        x += Decimal('2')
      case 'tres':
        x += Decimal('3')
      case 'quatro':
        x += Decimal('4')
      case 'cinco':
        x += Decimal('5')
      case 'seis':
        x += Decimal('6')
      case 'sete':
        x += Decimal('7')
      case 'oito':
        x += Decimal('8')
      case 'nove':
        x += Decimal('9')
      case 'dez':
        x += Decimal('10')
      case 'onze':
        x += Decimal('11')
      case 'doze':
        x += Decimal('12')
      case 'treze':
        x += Decimal('13')
      case 'quatorze':
        x += Decimal('14')
      case 'quinze':
        x += Decimal('15')
      case 'dezesseis':
        x += Decimal('16')
      case 'dezessete':
        x += Decimal('17')
      case 'dezoito':
        x += Decimal('18')
      case 'dezenove':
        x += Decimal('19')
      case 'vinte':
        x += Decimal('20')
      case 'trinta':
        x += Decimal('30')
      case 'quarenta':
        x += Decimal('40')
      case 'cinquenta':
        x += Decimal('50')
      case 'sessenta':
        x += Decimal('60')
      case 'setenta':
        x += Decimal('70')
      case 'oitenta':
        x += Decimal('80')
      case 'noventa':
        x += Decimal('90')
      case 'cento' | 'cem':
        x += Decimal('100')
      case 'duzentos':
        x += Decimal('200')
      case 'trezentos':
        x += Decimal('300')
      case 'quatrocentos':
        x += Decimal('400')
      case 'quinhentos':
        x += Decimal('500')
      case 'seiscentos':
        x += Decimal('600')
      case 'setecentos':
        x += Decimal('700')
      case 'oitocentos':
        x += Decimal('800')
      case 'novecentos':
        x += Decimal('900')
      case 'mil':
        x = Decimal('1000') if x == 0 else x*Decimal('1000')
        total += x
        x = Decimal('0')
      case 'milhao' | 'milhoes':
        x *= Decimal('1000000')
        total += x
        x = Decimal('0')
      case 'bilhao' | 'bilhoes':
        x *= Decimal('1000000000')
        total += x
        x = Decimal('0')
      case 'trilhao' | 'trilhoes':
        x *= Decimal('1000000000000')
        total += x
        x = Decimal('0')
      case 'real' | 'reais':
        total += x
        x = Decimal('0')
      case 'centavo' | 'centavos':
        x /= Decimal('100')
        total += x
        x = Decimal('0')
    #print('total:',total,'x:',x)

print("Minimo: R$ ", end='')

print(f"{total:,.2f}".replace('.','X').replace(',','.').replace('X',','),end='')
print('.',sep='')
