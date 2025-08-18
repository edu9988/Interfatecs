#include <stdio.h>
#include <string.h>

#define MAX 100000  // Tamanho máximo possível para armazenar a sequência

void proxima_linha(const char *seq, char *nova_seq) {
    int len = strlen(seq);
    int count = 1, pos = 0;

    for (int i = 1; i <= len; i++) {
        if (i < len && seq[i] == seq[i - 1]) {
            count++;
        } else {
            pos += sprintf(nova_seq + pos, "%d%c", count, seq[i - 1]);
            count = 1;
        }
    }
}

int main() {
    int n;
    scanf("%d", &n);

    char seq1[MAX] = "1";
    char seq2[MAX];

    for (int i = 1; i < n; i++) {
        proxima_linha(seq1, seq2);
        strcpy(seq1, seq2);
    }

    printf("%s\n", seq1);
    return 0;
}
