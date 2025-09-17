line = int(input())

seq = '1'
for _ in range(line-1):
  nextSeq = ''
  i = 0
  while i < len(seq):
    size = 1
    while i+size < len(seq) and seq[i+size] == seq[i]: 
      size += 1
    nextSeq = nextSeq + str(size) + str(seq[i])
    i += size
  seq = nextSeq

print(seq)
