#include <stdio.h>
#include <stdlib.h>

typedef long long ll;

// Algoritmo de Euclides Estendido
ll gcd_extended(ll a, ll b, ll *x, ll *y) {
    if (b == 0) {
        *x = 1;
        *y = 0;
        return a;
    }
    ll x1, y1;
    ll d = gcd_extended(b, a % b, &x1, &y1);
    *x = y1;
    *y = x1 - (a / b) * y1;
    return d;
}

// ceil(a / b) com suporte a sinais
ll ceil_div(ll a, ll b) {
    if (b == 0) return 0; // prevenção
    if ((a ^ b) >= 0) {
        return (a + b - 1) / b;
    } else {
        return a / b;
    }
}

// floor(a / b) com suporte a sinais
ll floor_div(ll a, ll b) {
    if (b == 0) return 0;
    if ((a ^ b) >= 0) {
        return a / b;
    } else {
        return (a - b + 1) / b;
    }
}

int main() {
    ll a, b, c;
    scanf("%lld %lld %lld", &a, &b, &c);

    ll x0, y0;
    ll d = gcd_extended(a, b, &x0, &y0);

    if (c % d != 0) {
        printf("IMPOSSIVEL\n");
        return 0;
    }

    // Solução particular
    x0 *= c / d;
    y0 *= c / d;

    // deslocamentos
    ll k = b / d;
    ll l = a / d;

    // intervalo de t que mantém x, y >= 0
    ll t_min = ceil_div(-x0, k);
    ll t_max = floor_div(y0, l);

    if (t_min > t_max) {
        printf("IMPOSSIVEL\n");
        return 0;
    }

    ll best_x = -1, best_y = -1;
    ll best_sum = 1e18;

    for (ll t = t_min; t <= t_max; ++t) {
        ll x = x0 + k * t;
        ll y = y0 - l * t;
        if (x >= 0 && y >= 0) {
            ll total = x + y;
            if (total < best_sum || (total == best_sum && x < best_x)) {
                best_sum = total;
                best_x = x;
                best_y = y;
            }
        }
    }

    if (best_x == -1) {
        printf("IMPOSSIVEL\n");
    } else {
        printf("%lld %lld\n", best_x, best_y);
    }

    return 0;
}

