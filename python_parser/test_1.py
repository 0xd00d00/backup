
file_path = 'example.txt'

result_list = []

with open(file_path, 'r') as file:
    current_date = None

    for line in file:
        if '년' in line and '월' in line and '일' in line:
            current_date = line.strip()
            print(current_date)


