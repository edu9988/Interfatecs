//solution by prof. alex
#include <iostream>
#include <string>
using namespace std;

string proxima_linha(const string &seq) {
    string resultado;
    int count = 1;

    for (size_t i = 1; i <= seq.size(); i++) {
        if (i < seq.size() && seq[i] == seq[i - 1]) {
            count++;
        } else {
            resultado += to_string(count) + seq[i - 1];
            count = 1;
        }
    }
    return resultado;
}

int main() {
    int n;
    cin >> n;

    string linha = "1";
    for (int i = 1; i < n; i++) {
        linha = proxima_linha(linha);
    }

    cout << linha << "\n";
}
