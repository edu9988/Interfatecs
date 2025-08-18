import java.util.*;

public class sequencia_alex {
    static String proximaLinha(String seq) {
        StringBuilder resultado = new StringBuilder();
        int count = 1;

        for (int i = 1; i <= seq.length(); i++) {
            if (i < seq.length() && seq.charAt(i) == seq.charAt(i - 1)) {
                count++;
            } else {
                resultado.append(count).append(seq.charAt(i - 1));
                count = 1;
            }
        }
        return resultado.toString();
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();

        String linha = "1";
        for (int i = 1; i < n; i++) {
            linha = proximaLinha(linha);
        }

        System.out.println(linha);
    }
}
