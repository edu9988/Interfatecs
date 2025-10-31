#solution by prof. alex
import sys
import math

MAX_N = 10_000_000

# Crivo de Eratóstenes
def sieve():
    is_prime = [True] * (MAX_N + 1)
    is_prime[0] = is_prime[1] = False
    limit = int(math.isqrt(MAX_N))
    for i in range(2, limit + 1):
        if is_prime[i]:
            step = i
            start = i * i
            for j in range(start, MAX_N + 1, step):
                is_prime[j] = False
    return is_prime

# Soma dos dígitos
def digit_sum(n):
    return sum(int(d) for d in str(n))

def main():
    data = sys.stdin.read().strip().split()
    if len(data) != 2:
        return
    A, B = map(int, data)

    is_prime = sieve()

    best_num = -1
    best_sum = -1

    for n in range(A, B + 1):
        if is_prime[n]:
            s = digit_sum(n)
            if s > best_sum or (s == best_sum and n < best_num):
                best_sum = s
                best_num = n

    print(best_num)

if __name__ == "__main__":
    main()

