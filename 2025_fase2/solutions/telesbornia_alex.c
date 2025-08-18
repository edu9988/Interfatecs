#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_S 100005
#define MAX_PAT 10005
#define MAX_PAT_LEN 6   // +1 for '\0'

typedef struct TrieNode {
    int is_end;
    struct TrieNode *children[10];
} TrieNode;

// Cria novo nó da Trie
TrieNode* new_node() {
    TrieNode *node = (TrieNode*)malloc(sizeof(TrieNode));
    node->is_end = 0;
    for (int i = 0; i < 10; i++) node->children[i] = NULL;
    return node;
}

// Insere padrão na Trie
void insert(TrieNode *root, char *word) {
    TrieNode *cur = root;
    for (int i = 0; word[i]; i++) {
        int d = word[i] - '0';
        if (!cur->children[d])
            cur->children[d] = new_node();
        cur = cur->children[d];
    }
    cur->is_end = 1;
}

// Libera memória da Trie
void free_trie(TrieNode *node) {
    for (int i = 0; i < 10; i++)
        if (node->children[i])
            free_trie(node->children[i]);
    free(node);
}

char S[MAX_S];
int dp[MAX_S];

int main() {
    scanf("%s", S);
    int n;
    scanf("%d", &n);

    TrieNode *root = new_node();

    for (int i = 0; i < n; i++) {
        char pat[MAX_PAT_LEN];
        scanf("%s", pat);
        insert(root, pat);
    }

    int len = strlen(S);
    dp[0] = 1; // base: 1 forma de decompor a string vazia

    for (int i = 0; i < len; i++) {
        if (dp[i] == 0) continue;

        TrieNode *cur = root;
        for (int j = i; j < len && j - i < 5; j++) {
            int d = S[j] - '0';
            if (!cur->children[d])
                break;
            cur = cur->children[d];
            if (cur->is_end)
                dp[j + 1] += dp[i];
        }
    }

    printf("%d\n", dp[len]);
    free_trie(root);
    return 0;
} 
