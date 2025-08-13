from math import inf

NComp = int(input())

names = dict()

for _ in range(NComp):
  line = input()
  starting_at = line.index(' ') + 1
  names[line.split()[0]] = line[starting_at:]

print( ".Id.Nome.......................Media......Melhor" )
while True:
  prova = input()
  if prova == 'FIM':
    break

  starting_at = prova.index(' ') + 1
  print( prova[starting_at:] )

  NPart = int(prova.split()[0])
  comps = []
  for _ in range(NPart):
    line = input().split()
    filtered = list(filter(lambda x: x != '0:00:000', line[1:]))
    if len(filtered) == 5 or len(filtered) == 4:
      filtered.sort()
      MenorTempo = filtered[0]
      a,b,c = MenorTempo.split(':')
      if int(a) == 0:
        MenorTempo = f"{b}:{c}"
      best_ms = int(a)*1000*60 + int(b)*1000 + int(c)
      milisecs = 0
      for x in filtered[1:4]:
        m, s, mili = x.split(':')
        milisecs += int(mili)
        milisecs += int(s) * 1000
        milisecs += int(m) * 1000*60
      milisecs = milisecs//3
      sum_ms = milisecs
      secs = milisecs // 1000
      mins = secs // 60
      secs = secs % 60
      milis = milisecs % 1000
      Media = f"{secs:02}:{milis:03}" if mins == 0 else f"{mins}:{secs:02}:{milis:03}"
    elif len(filtered) == 0:
      Media = 'DNF'
      MenorTempo = 'DNF'
      sum_ms = inf
      best_ms = inf
    else:
      filtered.sort()
      Media = 'DNF'
      sum_ms = inf
      MenorTempo = filtered[0]
      a,b,c = MenorTempo.split(':')
      if int(a) == 0:
        MenorTempo = f"{b}:{c}"
      best_ms = int(a)*1000*60 + int(b)*1000 + int(c)
    comps.append( [line[0], Media, MenorTempo, sum_ms, best_ms] )

  comps.sort(key=lambda x:(x[3], x[4], names[x[0]]))

  for comp in comps:
    index, media, tempo, sum_ns, best_ns = comp
    print( f"{index:>3} {names[index]:20}{media:>12}{tempo:>12}" )
