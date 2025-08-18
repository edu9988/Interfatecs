#include <stdio.h>

int main() {
    int f, m, c;
    scanf("%d %d %d", &f, &m, &c);

    int valor_base = m / f;
    int resto = m % f;

    int categorias[100]; // limite arbitrário
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
            if (i > 0) printf(" ");
            printf("%d", categorias[i]);
        }
        printf("\n");
    }

    // Último filho
    int gasto_primeiros = 0;
    for (int i = 0; i < c; i++) gasto_primeiros += categorias[i];
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
        if (i > 0) printf(" ");
        printf("%d", categorias[i]);
    }
    printf("\n");

    return 0;
}
