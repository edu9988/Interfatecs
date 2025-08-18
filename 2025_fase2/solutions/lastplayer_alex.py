import sys


def josephus(n, k):
    """Resolve o problema de Josephus retornando o último sobrevivente."""
    players = list(range(1, n + 1))
    idx = 0
    while len(players) > 1:
        idx = (idx + k - 1) % len(players)
        players.pop(idx)
    return players[0]


def main():
    # Lê a entrada do STDIN (ou de arquivo redirecionado)
    data = sys.stdin.read().strip().split()
    if not data:
        return
    n = int(data[0])
    k = int(data[1])

    print(josephus(n, k))


if __name__ == "__main__":
    main()
