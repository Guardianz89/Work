with open('applicationlogs.txt', 'r') as f:
    for line in f:
        if 'error' in line:
            print(line.strip())
