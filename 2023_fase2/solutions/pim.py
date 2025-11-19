N = int(input())

ls = [str(i) if i%4 else 'pim' for i in range(1,N+1)]
print(' '.join(ls))
