#include <iostream>
#include <climits>
using namespace std;
using ll = long long;

// Euclides Estendido
ll gcd_extended(ll a, ll b, ll &x, ll &y) {
    if (b == 0) {
        x = 1;
        y = 0;
        return a;
    }
    ll x1, y1;
    ll d = gcd_extended(b, a % b, x1, y1);
    x = y1;
    y = x1 - (a / b) * y1;
    return d;
}

// ceil_div robusto (trata sinais opostos corretamente)
ll ceil_div(ll a, ll b) {
    if ((a ^ b) >= 0)  // mesmo sinal
        return (a + b - 1) / b;
    else               // sinais diferentes
        return a / b;
}

int main() {
    ll a, b, c;
    cin >> a >> b >> c;
    ll x0, y0;
    ll d = gcd_extended(a, b, x0, y0);

    if (c % d != 0) {
        cout << "IMPOSSIVEL\n";
        return 0;
    }

    x0 *= c / d;
    y0 *= c / d;
    ll k = b / d;
    ll l = a / d;

    ll t_min = ceil_div(-x0, k);
    ll t_max = y0 / l;

    ll best_x = -1, best_y = -1;
    ll best_sum = LLONG_MAX;

    for (ll t = t_min; t <= t_max; ++t) {
        ll x = x0 + k * t;
        ll y = y0 - l * t;
        if (x >= 0 && y >= 0) {
            ll total = x + y;
            if (total < best_sum || (total == best_sum && x < best_x)) {
                best_x = x;
                best_y = y;
                best_sum = total;
            }
        }
    }

    if (best_x == -1)
        cout << "IMPOSSIVEL\n";
    else
        cout << best_x << " " << best_y << "\n";

    return 0;
}

