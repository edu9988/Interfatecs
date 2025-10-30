//solution by prox. alex
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

#define INF LLONG_MAX
#define MAXN 100005
#define MAXK 35

typedef struct {
    int to, w, p;
    struct Edge *next;
} Edge;

typedef struct {
    int node, used, passed;
    long long dist;
} State;

typedef struct {
    State *arr;
    int size, cap;
} MinHeap;

Edge *adj[MAXN];
long long dist[MAXN][MAXK][2];
int in_cypria[MAXN];

// ====== Funções para o heap ======
MinHeap *createHeap(int cap) {
    MinHeap *h = malloc(sizeof(MinHeap));
    h->arr = malloc(sizeof(State) * (cap + 1));
    h->size = 0;
    h->cap = cap;
    return h;
}

int cmp(State a, State b) {
    if (a.dist < b.dist) return -1;
    if (a.dist > b.dist) return 1;
    return 0;
}

void swap(State *a, State *b) {
    State t = *a;
    *a = *b;
    *b = t;
}

void push(MinHeap *h, State val) {
    if (h->size >= h->cap) return;
    h->arr[++h->size] = val;
    int i = h->size;
    while (i > 1 && cmp(h->arr[i], h->arr[i/2]) < 0) {
        swap(&h->arr[i], &h->arr[i/2]);
        i /= 2;
    }
}

int empty(MinHeap *h) {
    return h->size == 0;
}

State pop(MinHeap *h) {
    State minv = h->arr[1];
    h->arr[1] = h->arr[h->size--];
    int i = 1;
    while (1) {
        int l = i*2, r = i*2+1, smallest = i;
        if (l <= h->size && cmp(h->arr[l], h->arr[smallest]) < 0) smallest = l;
        if (r <= h->size && cmp(h->arr[r], h->arr[smallest]) < 0) smallest = r;
        if (smallest != i) {
            swap(&h->arr[i], &h->arr[smallest]);
            i = smallest;
        } else break;
    }
    return minv;
}

// ====== Adicionar aresta ======
void add_edge(int u, int v, int w, int p) {
    Edge *e1 = malloc(sizeof(Edge));
    e1->to = v; e1->w = w; e1->p = p; e1->next = adj[u]; adj[u] = e1;
}

// ====== Dijkstra com estado triplo ======
long long dijkstra(int N, int K, int S, int T) {
    for (int i = 1; i <= N; i++)
        for (int k = 0; k <= K; k++)
            dist[i][k][0] = dist[i][k][1] = INF;

    int start_pass = in_cypria[S] ? 1 : 0;
    dist[S][0][start_pass] = 0;

    MinHeap *pq = createHeap(N * (K+1) * 2 + 5);
    push(pq, (State){S, 0, start_pass, 0});

    while (!empty(pq)) {
        State cur = pop(pq);
        if (cur.dist != dist[cur.node][cur.used][cur.passed]) continue;

        Edge *e = adj[cur.node];
        while (e) {
            int nused = cur.used + e->p;
            if (nused > K) { e = e->next; continue; }

            int npassed = cur.passed || in_cypria[e->to];
            long long ndist = cur.dist + e->w;

            if (ndist < dist[e->to][nused][npassed]) {
                dist[e->to][nused][npassed] = ndist;
                push(pq, (State){e->to, nused, npassed, ndist});
            }
            e = e->next;
        }
    }

    long long ans = INF;
    for (int k = 0; k <= K; k++)
        if (dist[T][k][1] < ans)
            ans = dist[T][k][1];
    return (ans == INF) ? -1 : ans;
}

// ====== Programa principal ======
int main() {
    int N, M, K, R;
    if (scanf("%d %d %d %d", &N, &M, &K, &R) != 4) return 0;

    for (int i = 0; i < R; i++) {
        int c;
        scanf("%d", &c);
        in_cypria[c] = 1;
    }

    int S, T;
    scanf("%d %d", &S, &T);

    for (int i = 0; i < M; i++) {
        int u, v, w, p;
        scanf("%d %d %d %d", &u, &v, &w, &p);
        add_edge(u, v, w, p);
        add_edge(v, u, w, p);
    }

    long long ans = dijkstra(N, K, S, T);
    printf("%lld\n", ans);

    return 0;
}

