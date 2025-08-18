import java.util.*;

public class cerco_alex {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        int xj = sc.nextInt();
        int yj = sc.nextInt();
        int R = sc.nextInt();
        int N = sc.nextInt();

        long R2 = 1L * R * R;
        int count = 0;

        for (int i = 0; i < N; i++) {
            int xi = sc.nextInt();
            int yi = sc.nextInt();
            long dx = xi - xj;
            long dy = yi - yj;
            long dist2 = dx * dx + dy * dy;
            if (dist2 <= R2) count++;
        }

        System.out.println(count);
        sc.close();
    }
}

