NP = int(input())
QT = int(input())

teams = []
for _ in range(QT):
    nome, unidade = input().split('|')
    probs = list(map(int, input().split()))
    score = 0
    balloons = 0
    for i in range(NP):
        if probs[2*i+1] > 0:
            balloons += 1
            score += probs[2*i+1] + (probs[2*i]-1)*20
    teams.append([nome,unidade,balloons,score])

teams.sort(key=lambda x: (-x[2], x[3], x[0]))
for team in teams:
    print(f"{team[0]} - {team[1]} ({team[2]},{team[3]})")
