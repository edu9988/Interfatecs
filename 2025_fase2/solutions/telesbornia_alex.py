class TrieNode:
    def __init__(self):
        self.is_end = False
        self.children = {}

def insert(root, word):
    node = root
    for ch in word:
        if ch not in node.children:
            node.children[ch] = TrieNode()
        node = node.children[ch]
    node.is_end = True

def main():
    import sys
    input = sys.stdin.read
    data = input().splitlines()

    S = data[0]
    n = int(data[1])
    padroes = data[2:2+n]

    root = TrieNode()
    for pat in padroes:
        insert(root, pat)

    dp = [0] * (len(S) + 1)
    dp[0] = 1

    for i in range(len(S)):
        if dp[i] == 0:
            continue
        node = root
        for j in range(i, min(i + 5, len(S))):
            ch = S[j]
            if ch not in node.children:
                break
            node = node.children[ch]
            if node.is_end:
                dp[j + 1] += dp[i]

    print(dp[len(S)])

if __name__ == "__main__":
    main()

