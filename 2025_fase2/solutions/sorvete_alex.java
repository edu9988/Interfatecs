import java.util.*;

public class sorvete_alex {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        int n = sc.nextInt();
        int d = sc.nextInt();

        int[] temp = new int[n];
        for (int i = 0; i < n; i++) {
            temp[i] = sc.nextInt();
        }

        Arrays.sort(temp);

        int grupos = 0;
        int i = 0;
        while (i < n) {
            int j = i;
            while (j < n && temp[j] - temp[i] <= d) {
                j++;
            }
            grupos++;
            i = j;
        }

        System.out.println(grupos);
    }
}
