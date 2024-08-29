import gspread
import re
import os

from datetime import datetime, timedelta

def extract_dates_from_file(file_path):
    try:
        date_pattern = re.compile(r'\d{4}년 \d{1,2}월 \d{1,2}일 [월화수목금토일]요일')

        with open(file_path, 'r', encoding='utf-8') as file :
            file_content = file.read()

            all_dates = date_pattern.findall(file_content)
            print(all_dates)
        
        return all_dates

    except FileNotFoundError:
        print(f"파일 '{file_path}'을(를) 찾을 수 없습니다.")
    except Exception as e:
        print(f"오류 발생: {e}")



def extract_dates_with_weekdays_from_file(file_path, start_date=None, end_date=None):
    try:
        # 정규표현식 패턴 설정 (날짜와 요일을 모두 찾기 위해 수정)
        date_pattern = re.compile(r'\d{4}년 \d{1,2}월 \d{1,2}일 [월화수목금토일]요일')

        # 파일 열기
        with open(file_path, 'r', encoding='utf-8') as file:
            # 파일 내용 읽기
            file_content = file.read()

            # 정규표현식으로 날짜와 요일 찾기
            all_dates_with_weekdays = date_pattern.findall(file_content)
            print(all_dates_with_weekdays)
            dates_without_weekdays = [re.sub(r'\s[월화수목금토일]요일', '', date) for date in all_dates_with_weekdays]

        print('@@@@ ', dates_without_weekdays)
        return dates_without_weekdays

    except FileNotFoundError:
        print(f"파일 '{file_path}'을(를) 찾을 수 없습니다.")
    except Exception as e:
        print(f"오류 발생: {e}")

def generate_date_range(start, end):
    #start_date = datetime.strptime(start 
    date_range = []

    start_date = datetime.strptime(start, '%y.%m.%d')
    end_date = datetime.strptime(end, '%y.%m.%d')

    current_date = start_date
    while current_date <= end_date:
        # %d 가 아니라 %e를 사용하면 2자리가 아니라 한 자리로..
        #  %e는 공백이 생겨 이상하게 출력되고, 10의 자리로 넘어갈 경우 싱크가 안 맞음
        # 아래와 같이 replace를 활용해 지우면 됨.
        date_range.append(current_date.strftime('%y. %m. %d.').replace(' 0', ' '))
        current_date += timedelta(days=1)

    return date_range

def check_dates_in_files(date_array):
    file_path = 'e.txt'

    # 어떤 동작을 했는지 dic만듬.
    senders = {} # 보낸 사람 리스트
    actions = ['✔️', '사진']
    
    with open(file_path, 'r', encoding='utf-8') as file:
        for line in file:
            for date in date_array:
                if date in line:
                    message_pattern = re.compile(r'\d{2}_([^\s/]+)')
                    print(line)
                    match = message_pattern.search(line)
                    if match:
                        name = match.groups(1)
                    # 이름을 구별해야함.
                    # 어떤 자료구조로 갈건가? -> set

                    # 문자열 처리를 위해 strip 활용
                    action = line.split(' : ')[1].strip()

                    print("@@@@ ", action)
                    print("@@@@ actions ", actions, len(actions[0]), " ", len("📔✔️")) 

                    # 메세지
                    if any([vaild_keyword in action for vaild_keyword in actions]):
                        # 특정 문자가 보이면 해당 메세지는 v로 변경.
                        if action.find('✔️') != -1:
                            action = '✔️'

                        if action.find('사진') != -1:
                            print("@@@@@@@@@@@@@@@@ "  +name + " " + action)

                        print("!!! ", action)
                        if name in senders:
                            senders[name].add(action)
                        else:
                            senders[name] = {action}
                    break

    # 해당 날짜 검사하고, log 남기는 시스템 만들기.
    return senders


class GSpreadHelper:
    SHEET_FILE_NAME = "꿈이룬하루테스트"
    NAME_START_POINT = 3
    ROW_NUMBER_FOR_DATE = 2

    # spread에 접근하는 걸 도와주는 class
    def __init__(self, date_row_line):
        print("GSpread connecting.. ")
        self.date_row_line = date_row_line
        self.gc = gspread.service_account() # 수정할 부분. 
        self.sh = self.gc.open(self.SHEET_FILE_NAME)
        self.worksheet = self.sh.get_worksheet(0)
        print("Gspread connect!")

        # gc 같은거 박으면 될듯.
        # 날짜 등록, o등록 정도만 일단 해보자. <- 요게 핵심기능.
        #  이름 리스트를 먼저 가지고 와도 괜찮겠는데?
        #       번호와 이름을 매치해서 set으로 구현하면됨.
        #           이름을 검색하면 번호가 나오면 되고, + NAME_START_POINT로 위치 계산하고, 정해진 날짜에 o 표시만 하면 될듯.
        #   몇번떨어져있는지만 기록한다면. 상수로.

    def UpdateDate(self, my_date):
        #print(date)

        #if not isinstance(my_date, date):
        #    print(" my date.. ", my_date)
        #else:
        #    print ("date ok.0")
        # 특정 날짜를 입력받고, 마지막 날짜와 동일하면.. 체크 아니라면 엑셀 확인해봐 돌려주자.
        print(self.worksheet.row_values(2))

        last_date = self.worksheet.row_values(self.ROW_NUMBER_FOR_DATE)[-1]

        print(last_date)

        print(self.sh.sheet1.get('A1'))
        # 여기서 마지막 날짜를 가져와서, 그걸 기록하면됨.
        # 마지막 날짜를 업데이트하고, 그 날짜 받아서 인증 돌리면됨
        # 파일 경로와 시작일, 종료일 입력 받기

#obj = GSpreadHelper(3)

def makeLogFile(date, result_senders):
# 출력 날짜. 출력하는 날짜와 시간 으로 로그 만들기.
#  출력 날짜로 파일을 만들고
# 파일이 있으면, 지금 시간을 파일명으로 하고, 로그를 넣어주면 됨.
    DIR = ('./log/' + date + '/')
    try:
        if not os.path.exists(DIR):
            os.makedirs(DIR)
    except OSError:
        print('Error creating directory ' + date)

    log_file = datetime.today().strftime("DateLog_%y.%m.%d_%H:%M")

    # "w+ 와 a 다른점 찾아봐"
    f = open(DIR + log_file,"a")

    # 이거 넣는거 기억하고
    if result_senders:
        f.writelines(" == 인증 완료자 리스트 == \n")
        for sender, actions in result_senders.items():
            if len(actions) == 2:
                f.write(sender[0] + "\n")

        f.writelines("\n == 인증 미 완료자 리스트 == \n")
        for sender, actions in result_senders.items():
            if len(actions) != 2:
                f.write(sender[0] + "\n")
                f.write("  ** "+ ", ".join(actions) + " 만 인증함. \n\n")
            #    f.writelines(sender[0] + "인증 부족 : " + actions)


file_path = input("파일 경로를 입력하세요: ")
# 파일이름을 입력하지 않은 경우 예외 처리
if not file_path:
    print("파일 경로를 반드시 입력해야 합니다.")
else:
    start_date = input("시작 날짜를 입력하세요 (xxxx년 x월 x일 형식, 입력하지 않으려면 엔터): ")
    end_date = input("종료 날짜를 입력하세요 (xxxx년 x월 x일 형식, 입력하지 않으려면 엔터): ")

    # 파일에서 시작일과 종료일 사이의 날짜 및 요일 추출
    # found_dates_with_weekdays = extract_dates_with_weekdays_from_file(file_path, start_date, end_date)

    found_dates_with_weekdays = generate_date_range(start_date, end_date)

    print(found_dates_with_weekdays)

    result_senders = check_dates_in_files(found_dates_with_weekdays)

    print(result_senders)

    makeLogFile(start_date, result_senders)

    #obj.UpdateDate(start_date)
    # 어떤 자료구조로 가야하는게 맞는지?
    # 1. 일치하는 날짜의 메세지인가?
    #   맞다면, / 기준으로 이름 먼저 읽어
    #       -> 여기서 확인할 점. 공백제거
    #   : 기준으로 사진인지? 스티커인지? 배열로 두개를 넣고
    #   배열에 중복제거를 할 수 있나?
    #   순서 기록해서 중복제거하면 될듯.
    #   그리고 비교하면 되는거같은데?
    #       사진, 인증

    # 몇개의 테스트를 돌려보자.
    #   ok하면 된다.
    #   1. 중복인증하면?
    #   2. 사진을 다른걸 올리면?
    #   3. 파일 다운 받는게 좀 귀찮음.
    #       3.1. (최적화)이걸 쉽게 할 수 있는 방법이 있을까?
    #   4. 구글 스프레드 연동해서 보내는 것 까지
    #   5. PoC
    #   6. 코드 리펙토링.

    # 구글 드라이브 연동 ㄱ
    #formatted_dates = [date.replace('년', '.').replace('월', '.').replace('일', '.') for date in found_dates_with_weekdays]

    # 추출된 날짜 및 요일 출력
    #if found_dates_with_weekdays:
    #    print("@@@@ " ,found_dates_with_weekdays, " @@@ ", formatted_dates)

    # 해당 날짜를 가지고, 관련된 메세지 뽑기


