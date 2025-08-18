#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define MAX 1024

int pos(char letra) {
    return (toupper(letra) - 'A') % 26;
}

void decifrar(const char *texto, int chave) {
    for (int i = 0; texto[i]; i++) {
        char ch = texto[i];
        if (isalpha(ch)) {
            int novaPos = (pos(ch) - chave + 26) % 26;
            char novaLetra = 'A' + novaPos;
            putchar(isupper(ch) ? novaLetra : tolower(novaLetra));
        } else {
            putchar(ch);
        }
    }
    putchar('\n');
}

int main() {
    char linha[MAX];

    while (fgets(linha, sizeof(linha), stdin)) {
        linha[strcspn(linha, "\n")] = '\0'; // remove \n

        if (strcmp(linha, "***") == 0) break;
        int len = strlen(linha);
        if (len < 2 || !isalpha(linha[len-1])) continue;

        char c1 = linha[len-2], c2 = linha[len-1];
        int dif = (26 - ((pos(c1) - pos(c2) + 26) % 26)) % 26;

        char base = (dif == 9) ? 'E' : (dif == 1) ? 'R' : 0;
        if (base) {
            int chave = (pos(c2) - pos(base) + 26) % 26;
            decifrar(linha, chave);
        }
    }
    return 0;
}
