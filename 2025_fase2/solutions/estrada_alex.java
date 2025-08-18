import java.util.*;

public class estrada_alex {
    static class Edge {
        int to, w, p;
        Edge(int to, int w, int p) {
            this.to = to;
            this.w = w;
            this.p = p;
        }
    }

    static class State implements Comparable<State> {
        long dist;
        int node, used, passed;
        State(long dist, int node, int used, int passed) {
            this.dist = dist;
            this.node = node;
            this.used = used;
            this.passed = passed;
        }
        public int compareTo(State o) {
            return Long.compare(this.dist, o.dist);
        }
    }

    static final long INF = Long.MAX_VALUE;
    static final int MAXK = 35;
    static List<Edge>[] adj;
    static boolean[] inCypria;
    static long[][][] dist;

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int N = sc.nextInt();
        int M = sc.nextInt();
        int K = sc.nextInt();
        int R = sc.nextInt();

        inCypria = new boolean[N + 1];
        for (int i = 0; i < R; i++) {
            int c = sc.nextInt();
            inCypria[c] = true;
        }

        int S = sc.nextInt();
        int T = sc.nextInt();

        adj = new ArrayList[N + 1];
        for (int i = 1; i <= N; i++) adj[i] = new ArrayList<>();

        for (int i = 0; i < M; i++) {
            int u = sc.nextInt();
            int v = sc.nextInt();
            int w = sc.nextInt();
            int p = sc.nextInt();
            adj[u].add(new Edge(v, w, p));
            adj[v].add(new Edge(u, w, p));
        }

        dist = new long[N + 1][K + 1][2];
        for (int i = 1; i <= N; i++)
            for (int k = 0; k <= K; k++)
                Arrays.fill(dist[i][k], INF);

        int startPassed = inCypria[S] ? 1 : 0;
        dist[S][0][startPassed] = 0;

        PriorityQueue<State> pq = new PriorityQueue<>();
        pq.add(new State(0, S, 0, startPassed));

        while (!pq.isEmpty()) {
            State cur = pq.poll();
            if (cur.dist != dist[cur.node][cur.used][cur.passed]) continue;

            for (Edge e : adj[cur.node]) {
                int nused = cur.used + e.p;
                if (nused > K) continue;
                int npassed = cur.passed | (inCypria[e.to] ? 1 : 0);
                long nd = cur.dist + e.w;

                if (nd < dist[e.to][nused][npassed]) {
                    dist[e.to][nused][npassed] = nd;
                    pq.add(new State(nd, e.to, nused, npassed));
                }
            }
        }

        long ans = INF;
        for (int k = 0; k <= K; k++)
            ans = Math.min(ans, dist[T][k][1]); // 1 => passou por Cypria

        System.out.println(ans == INF ? -1 : ans);
        sc.close();
    }
}

