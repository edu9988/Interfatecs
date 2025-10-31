//solution by prof. alex
#include <bits/stdc++.h>
using namespace std;

const int MAX_N = 10000000; // limite do problema

vector<bool> is_prime(MAX_N + 1, true);

// Calcula soma dos dígitos de um número
inline int digit_sum(int n) {
    int sum = 0;
    while (n > 0) {
        sum += n % 10;
        n /= 10;
    }
    return sum;
}

// Crivo de Eratóstenes
void sieve() {
    is_prime[0] = is_prime[1] = false;
    int limit = sqrt(MAX_N);
    for (int i = 2; i <= limit; i++) {
        if (is_prime[i]) {
            for (int j = i * i; j <= MAX_N; j += i) {
                is_prime[j] = false;
            }
        }
    }
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int A, B;
    if (!(cin >> A >> B)) return 0;

    sieve(); // pré-processa todos os primos até MAX_N

    int best_num = -1;
    int best_sum = -1;

    for (int n = A; n <= B; n++) {
        if (is_prime[n]) {
            int s = digit_sum(n);
            if (s > best_sum || (s == best_sum && n < best_num)) {
                best_sum = s;
                best_num = n;
            }
        }
    }

    cout << best_num << "\n";
    return 0;
}

