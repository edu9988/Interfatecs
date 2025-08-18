#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int xj, yj, R, N;
    cin >> xj >> yj >> R;
    cin >> N;

    long long R2 = 1LL * R * R;
    int count = 0;

    for (int i = 0; i < N; i++) {
        int xi, yi;
        cin >> xi >> yi;
        long long dx = xi - xj;
        long long dy = yi - yj;
        long long dist2 = dx * dx + dy * dy;
        if (dist2 <= R2) count++;
    }

    cout << count << "\n";
    return 0;
}

