import java.util.*;

public class telesbornia_alex {
    static class TrieNode {
        boolean isEnd = false;
        TrieNode[] children = new TrieNode[10];
    }

    static void insert(TrieNode root, String word) {
        TrieNode node = root;
        for (char c : word.toCharArray()) {
            int d = c - '0';
            if (node.children[d] == null)
                node.children[d] = new TrieNode();
            node = node.children[d];
        }
        node.isEnd = true;
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String S = sc.nextLine();
        int n = Integer.parseInt(sc.nextLine());

        TrieNode root = new TrieNode();
        for (int i = 0; i < n; i++) {
            String pat = sc.nextLine();
            insert(root, pat);
        }

        int[] dp = new int[S.length() + 1];
        dp[0] = 1;

        for (int i = 0; i < S.length(); i++) {
            if (dp[i] == 0) continue;
            TrieNode node = root;
            for (int j = i; j < S.length() && j - i < 5; j++) {
                int d = S.charAt(j) - '0';
                if (node.children[d] == null) break;
                node = node.children[d];
                if (node.isEnd) dp[j + 1] += dp[i];
            }
        }

        System.out.println(dp[S.length()]);
    }
}

