import sys
import heapq

INF = 10**18

def dijkstra(N, M, K, cypria_set, S, T, edges):
    # Grafo como lista de adjacência
    adj = [[] for _ in range(N + 1)]
    for u, v, w, p in edges:
        adj[u].append((v, w, p))
        adj[v].append((u, w, p))

    # dist[node][used_vigilancia][passou_cypria]
    dist = [[[INF] * 2 for _ in range(K + 1)] for _ in range(N + 1)]

    start_passed = 1 if S in cypria_set else 0
    dist[S][0][start_passed] = 0

    pq = [(0, S, 0, start_passed)]  # (dist, node, usadas, passou)
    
    while pq:
        d, u, used, passed = heapq.heappop(pq)
        if d != dist[u][used][passed]:
            continue

        for v, w, p in adj[u]:
            nused = used + p
            if nused > K:
                continue
            npassed = passed or (v in cypria_set)
            nd = d + w
            if nd < dist[v][nused][npassed]:
                dist[v][nused][npassed] = nd
                heapq.heappush(pq, (nd, v, nused, npassed))

    ans = min(dist[T][k][1] for k in range(K + 1))
    return -1 if ans >= INF else ans

def main():
    data = sys.stdin.read().strip().split()
    if not data:
        return
    it = iter(data)
    N = int(next(it))
    M = int(next(it))
    K = int(next(it))
    R = int(next(it))

    cypria_cities = [int(next(it)) for _ in range(R)]
    cypria_set = set(cypria_cities)

    S = int(next(it))
    T = int(next(it))

    edges = []
    for _ in range(M):
        u = int(next(it))
        v = int(next(it))
        w = int(next(it))
        p = int(next(it))
        edges.append((u, v, w, p))

    ans = dijkstra(N, M, K, cypria_set, S, T, edges)
    print(ans)

if __name__ == "__main__":
    main()

