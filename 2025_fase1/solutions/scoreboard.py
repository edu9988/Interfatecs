sede = input()
vagas, extras = [int(x) for  x in input().split()]

total = int(input())

tabela = []
desclassificados = [] 

for i in range(total):
  nome, unidade, baloes, tempo = input().split('|')
  baloes = int(baloes)
  tempo = int(tempo)
  linha = [nome, unidade, baloes, tempo]
  if baloes == 0:
    desclassificados.append( linha )
  else:
    tabela.append( linha )

desclassificados.sort(key=lambda x:x[0])
tabela.sort(key=lambda x:x[3])
tabela.sort(key=lambda x:-x[2])

tabela_sede = list( filter( lambda x: x[1] == sede , tabela ))

#print( '========= debug ==========' )
#print( 'tabela:' )
#for x in tabela:
  #print( '  ', x )
#print( '========= debug ==========' )

classificados = []
for i in range(1+extras):
  if i >= tabela_sede.__len__():
    break
  classificados.append( tabela_sede[i] )
  tabela.remove( tabela_sede[i] )

unidades_classificadas = [sede]
for equipe in tabela:
  if equipe[1] not in unidades_classificadas:
    #print( 'debug: appending ', equipe[0], 'to classificados' ) 
    classificados.append( equipe )
    unidades_classificadas.append( equipe[1] )

i = min(1+extras, tabela_sede.__len__())
while i < classificados.__len__():
  tabela.remove( classificados[i] )
  i += 1

while classificados.__len__() < vagas :
  classificados.append( tabela.pop(0) )
    
classificados.sort(key=lambda x: x[0])

print("Classificados para a Final")
for i in classificados:
    print( i[0] , ' - ',i[1],' (',i[2],',',i[3],')' ,sep='')

print()

print("Lista de Espera")
for i in tabela:
    print( i[0] , ' - ',i[1],' (',i[2],',',i[3],')' ,sep='')

print()
print("Desclassificados")
for i in desclassificados:
    print( i[0] , ' - ',i[1],' (',i[2],',',i[3],')' ,sep='')

print()
print("Apuracao concluida!")

