#include <stdio.h>

int main() {
    int xj, yj, R;
    int N;
    long long R2; // raio ao quadrado

    // Leitura da posição da casa e raio
    if (scanf("%d %d %d", &xj, &yj, &R) != 3) {
        return 1; // erro de leitura
    }

    // Leitura do número de Sneakys
    if (scanf("%d", &N) != 1) {
        return 1; // erro de leitura
    }

    R2 = (long long)R * (long long)R; // evita overflow

    int count = 0;

    for (int i = 0; i < N; i++) {
        int xi, yi;
        scanf("%d %d", &xi, &yi);

        long long dx = xi - xj;
        long long dy = yi - yj;
        long long dist2 = dx * dx + dy * dy;

        if (dist2 <= R2) {
            count++;
        }
    }

    printf("%d\n", count);
    return 0;
}

