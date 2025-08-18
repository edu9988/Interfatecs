#include <stdio.h>
#include <stdlib.h>

#define MAXN 100005

int cmp(const void *a, const void *b) {
    int x = *(const int *)a;
    int y = *(const int *)b;
    return x - y;
}

int main() {
    int n, d;
    int temp[MAXN];

    scanf("%d %d", &n, &d);
    for (int i = 0; i < n; i++) {
        scanf("%d", &temp[i]);
    }

    // Ordena as temperaturas
    qsort(temp, n, sizeof(int), cmp);

    int grupos = 0;
    int i = 0;

    // Varre as temperaturas agrupando as que cabem no intervalo
    while (i < n) {
        int j = i;
        while (j < n && temp[j] - temp[i] <= d) {
            j++;
        }
        grupos++;
        i = j; // pula para o próximo grupo
    }

    printf("%d\n", grupos);
    return 0;
}

