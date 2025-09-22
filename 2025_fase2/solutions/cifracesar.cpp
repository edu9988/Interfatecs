//solution by prof. alex
#include <iostream>
#include <string>
#include <cctype>
using namespace std;

int pos(char letra) {
    return (toupper(letra) - 'A') % 26;
}

string decifrar(const string &texto, int chave) {
    string res;
    for (char ch : texto) {
        if (isalpha(static_cast<unsigned char>(ch))) {
            int novaPos = (pos(ch) - chave + 26) % 26;
            char novaLetra = 'A' + novaPos;
            res.push_back(isupper(static_cast<unsigned char>(ch)) ? novaLetra : tolower(novaLetra));
        } else {
            res.push_back(ch);
        }
    }
    return res;
}

int main() {
    string linha;
    while (getline(cin, linha)) {
        if (linha == "***") break;
        if (linha.size() < 2 || !isalpha(static_cast<unsigned char>(linha.back()))) continue;

        char c1 = linha[linha.size() - 2];
        char c2 = linha.back();
        int dif = (26 - ((pos(c1) - pos(c2) + 26) % 26)) % 26;

        char base = (dif == 9) ? 'E' : (dif == 1) ? 'R' : 0;
        if (base) {
            int chave = (pos(c2) - pos(base) + 26) % 26;
            cout << decifrar(linha, chave) << "\n";
        }
    }
}
