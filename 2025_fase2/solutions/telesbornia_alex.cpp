#include <iostream>
#include <vector>
#include <string>
using namespace std;

struct TrieNode {
    bool is_end = false;
    TrieNode* children[10] = {nullptr};
};

TrieNode* insert(TrieNode* root, const string& word) {
    TrieNode* node = root;
    for (char c : word) {
        int d = c - '0';
        if (!node->children[d])
            node->children[d] = new TrieNode();
        node = node->children[d];
    }
    node->is_end = true;
    return root;
}

void free_trie(TrieNode* node) {
    for (int i = 0; i < 10; i++)
        if (node->children[i])
            free_trie(node->children[i]);
    delete node;
}

int main() {
    string S;
    cin >> S;
    int n;
    cin >> n;

    TrieNode* root = new TrieNode();
    for (int i = 0; i < n; ++i) {
        string pat;
        cin >> pat;
        insert(root, pat);
    }

    int len = S.length();
    vector<int> dp(len + 1, 0);
    dp[0] = 1;

    for (int i = 0; i < len; ++i) {
        if (dp[i] == 0) continue;
        TrieNode* node = root;
        for (int j = i; j < len && j - i < 5; ++j) {
            int d = S[j] - '0';
            if (!node->children[d]) break;
            node = node->children[d];
            if (node->is_end)
                dp[j + 1] += dp[i];
        }
    }

    cout << dp[len] << endl;
    free_trie(root);
    return 0;
}

