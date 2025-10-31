//solution by prof. alex
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

#define MAX_N 10000000

static char is_prime[MAX_N + 1]; // 0 = não primo, 1 = primo

// Função para calcular soma de dígitos
int digit_sum(int n) {
    int sum = 0;
    while (n > 0) {
        sum += n % 10;
        n /= 10;
    }
    return sum;
}

// Crivo de Eratóstenes
void sieve() {
    memset(is_prime, 1, sizeof(is_prime));
    is_prime[0] = is_prime[1] = 0;
    int limit = (int)sqrt(MAX_N);
    for (int i = 2; i <= limit; i++) {
        if (is_prime[i]) {
            for (int j = i * i; j <= MAX_N; j += i) {
                is_prime[j] = 0;
            }
        }
    }
}

int main() {
    int A, B;
    if (scanf("%d %d", &A, &B) != 2) {
        return 1; // erro de leitura
    }

    sieve();

    int best_number = -1;
    int best_sum = -1;

    for (int n = A; n <= B; n++) {
        if (is_prime[n]) {
            int s = digit_sum(n);
            if (s > best_sum || (s == best_sum && n < best_number)) {
                best_sum = s;
                best_number = n;
            }
        }
    }

    printf("%d\n", best_number);
    return 0;
}



