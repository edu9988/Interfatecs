//solution by prof. alex
#include <bits/stdc++.h>
using namespace std;

int main() {
    int n, d;
    cin >> n >> d;

    vector<int> temp(n);
    for (int i = 0; i < n; i++) {
        cin >> temp[i];
    }

    sort(temp.begin(), temp.end());

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

    cout << grupos << "\n";
    return 0;
}
