#include <iostream>
#include <vector>
using namespace std;

int main() {
    int f, m, c;
    cin >> f >> m >> c;

    int valor_base = m / f;
    int resto = m % f;

    vector<int> categorias(c);
    int valor_restante;

    // Para os primeiros f-1 filhos
    for (int filho = 0; filho < f - 1; filho++) {
        valor_restante = valor_base;
        for (int i = 0; i < c; i++) {
            if (valor_restante >= 30) {
                categorias[i] = 30;
                valor_restante -= 30;
            } else if (valor_restante >= 20) {
                categorias[i] = 20;
                valor_restante -= 20;
            } else if (valor_restante >= 10) {
                categorias[i] = 10;
                valor_restante -= 10;
            } else {
                categorias[i] = 0;
            }
        }
        for (int i = 0; i < c; i++) {
            if (i) cout << " ";
            cout << categorias[i];
        }
        cout << "\n";
    }

    // Último filho
    int gasto_primeiros = 0;
    for (int v : categorias) gasto_primeiros += v;
    resto = m - gasto_primeiros * (f - 1);

    valor_restante = resto;
    for (int i = 0; i < c; i++) {
        if (valor_restante >= 30) {
            categorias[i] = 30;
            valor_restante -= 30;
        } else if (valor_restante >= 20) {
            categorias[i] = 20;
            valor_restante -= 20;
        } else if (valor_restante >= 10) {
            categorias[i] = 10;
            valor_restante -= 10;
        } else {
            categorias[i] = 0;
        }
    }
    for (int i = 0; i < c; i++) {
        if (i) cout << " ";
        cout << categorias[i];
    }
    cout << "\n";

    return 0;
}
