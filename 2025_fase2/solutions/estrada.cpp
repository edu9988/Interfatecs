//solution by prof. alex
#include <bits/stdc++.h>
using namespace std;

struct Edge {
    int to, w, p;
};

struct State {
    long long dist;
    int node, used, passed;
    bool operator>(const State &o) const {
        return dist > o.dist;
    }
};

const long long INF = LLONG_MAX;
const int MAXN = 100000 + 5;
const int MAXK = 35;

vector<Edge> adj[MAXN];
bool in_cypria[MAXN];
long long dist[MAXN][MAXK][2];

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int N, M, K, R;
    if (!(cin >> N >> M >> K >> R)) return 0;

    // Marca cidades de Cypria
    for (int i = 0; i < R; i++) {
        int c;
        cin >> c;
        in_cypria[c] = true;
    }

    int S, T;
    cin >> S >> T;

    // Lê arestas
    for (int i = 0; i < M; i++) {
        int u, v, w, p;
        cin >> u >> v >> w >> p;
        adj[u].push_back({v, w, p});
        adj[v].push_back({u, w, p});
    }

    // Inicializa distâncias
    for (int i = 1; i <= N; i++)
        for (int k = 0; k <= K; k++)
            dist[i][k][0] = dist[i][k][1] = INF;

    // Estado inicial
    int start_passed = in_cypria[S] ? 1 : 0;
    dist[S][0][start_passed] = 0;

    priority_queue<State, vector<State>, greater<State>> pq;
    pq.push({0, S, 0, start_passed});

    // Dijkstra com estado triplo
    while (!pq.empty()) {
        auto cur = pq.top();
        pq.pop();

        if (cur.dist != dist[cur.node][cur.used][cur.passed]) continue;

        for (auto &e : adj[cur.node]) {
            int nused = cur.used + e.p;
            if (nused > K) continue;
            int npassed = cur.passed || in_cypria[e.to];
            long long nd = cur.dist + e.w;

            if (nd < dist[e.to][nused][npassed]) {
                dist[e.to][nused][npassed] = nd;
                pq.push({nd, e.to, nused, npassed});
            }
        }
    }

    long long ans = INF;
    for (int k = 0; k <= K; k++)
        ans = min(ans, dist[T][k][1]); // 1 => passou por Cypria

    if (ans == INF) cout << -1 << "\n";
    else cout << ans << "\n";

    return 0;
}

