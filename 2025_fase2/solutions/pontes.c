//solution by prof. banin
#include <stdio.h>
#include <stdlib.h>

int main() {
    int a, b, c;
    int resto, nE, nT, maxE;
    int solE = -1, solT = -1;

    scanf("%d %d %d", &a, &b, &c);

    maxE = c / a;
    for (nE = 0; nE <= maxE; nE++) {
        resto = c - nE * a;
        if (resto % b == 0) {
            nT = resto / b;
            if (solE == -1 || nE + nT < solE + solT) {
                solE = nE;
                solT = nT;
            }
        }
    }

    if (solE == -1)
        printf("IMPOSSIVEL\n");
    else
        printf("%d %d\n", solE, solT);

    return 0;
}

