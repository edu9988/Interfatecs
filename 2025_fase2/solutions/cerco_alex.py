def main():
    xj, yj, R = map(int, input().split())
    N = int(input())

    R2 = R * R
    count = 0

    for _ in range(N):
        xi, yi = map(int, input().split())
        dx = xi - xj
        dy = yi - yj
        if dx * dx + dy * dy <= R2:
            count += 1

    print(count)

if __name__ == "__main__":
    main()

