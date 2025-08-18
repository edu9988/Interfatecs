import java.util.Scanner;

public class pontes_alex {
    static long gcdExtended(long a, long b, long[] xy) {
        if (b == 0) {
            xy[0] = 1;
            xy[1] = 0;
            return a;
        }
        long[] xy1 = new long[2];
        long d = gcdExtended(b, a % b, xy1);
        xy[0] = xy1[1];
        xy[1] = xy1[0] - (a / b) * xy1[1];
        return d;
    }

    static long ceilDiv(long a, long b) {
        if ((a ^ b) >= 0) {
            return (a + b - 1) / b;
        } else {
            return a / b;
        }
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        long a = sc.nextLong(), b = sc.nextLong(), c = sc.nextLong();

        long[] xy = new long[2];
        long d = gcdExtended(a, b, xy);
        if (c % d != 0) {
            System.out.println("IMPOSSIVEL");
            return;
        }

        long x0 = xy[0] * (c / d);
        long y0 = xy[1] * (c / d);
        long k = b / d;
        long l = a / d;

        long t_min = ceilDiv(-x0, k);
        long t_max = y0 / l;

        long best_x = -1, best_y = -1, best_sum = Long.MAX_VALUE;

        for (long t = t_min; t <= t_max; t++) {
            long x = x0 + k * t;
            long y = y0 - l * t;
            if (x >= 0 && y >= 0) {
                long total = x + y;
                if (total < best_sum || (total == best_sum && x < best_x)) {
                    best_sum = total;
                    best_x = x;
                    best_y = y;
                }
            }
        }

        if (best_x == -1)
            System.out.println("IMPOSSIVEL");
        else
            System.out.println(best_x + " " + best_y);
    }
}

