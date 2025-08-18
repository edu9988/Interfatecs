#include <stdio.h>
#include <string.h>

int turno(char m1, char m2) {
    return (m1 == '*' && m2 == 'V') ||
           (m1 == 'V' && m2 == 'O') ||
           (m1 == 'O' && m2 == '*');
}

int main() {
    char m1, m2;
    int beatriz = 0, artur = 0;

    while (1) {
        scanf(" %c %c", &m1, &m2);

        if (m1 == '-' && m2 == '-')
            break;

        if (turno(m1, m2))
            beatriz++;
        else if (turno(m2, m1))
            artur++;
    }

    if (beatriz > artur)
        printf("BEATRIZ WIN\n");
    else if (artur > beatriz)
        printf("ARTUR WIN\n");
    else
        printf("TIE\n");

    return 0;
}

