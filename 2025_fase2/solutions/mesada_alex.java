import java.util.*;

public class mesada_alex {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int f = sc.nextInt();
        int m = sc.nextInt();
        int c = sc.nextInt();

        int valorBase = m / f;
        int resto = m % f;

        int[] categorias = new int[c];
        int valorRestante;

        // Para os primeiros f-1 filhos
        for (int filho = 0; filho < f - 1; filho++) {
            valorRestante = valorBase;
            for (int i = 0; i < c; i++) {
                if (valorRestante >= 30) {
                    categorias[i] = 30;
                    valorRestante -= 30;
                } else if (valorRestante >= 20) {
                    categorias[i] = 20;
                    valorRestante -= 20;
                } else if (valorRestante >= 10) {
                    categorias[i] = 10;
                    valorRestante -= 10;
                } else {
                    categorias[i] = 0;
                }
            }
            for (int i = 0; i < c; i++) {
                if (i > 0) System.out.print(" ");
                System.out.print(categorias[i]);
            }
            System.out.println();
        }

        // Último filho
        int gastoPrimeiros = 0;
        for (int v : categorias) gastoPrimeiros += v;
        resto = m - gastoPrimeiros * (f - 1);

        valorRestante = resto;
        for (int i = 0; i < c; i++) {
            if (valorRestante >= 30) {
                categorias[i] = 30;
                valorRestante -= 30;
            } else if (valorRestante >= 20) {
                categorias[i] = 20;
                valorRestante -= 20;
            } else if (valorRestante >= 10) {
                categorias[i] = 10;
                valorRestante -= 10;
            } else {
                categorias[i] = 0;
            }
        }
        for (int i = 0; i < c; i++) {
            if (i > 0) System.out.print(" ");
            System.out.print(categorias[i]);
        }
        System.out.println();
    }
}
