import gspread
import locale 
import os
import re

import warnings

from datetime import datetime
from configparser import ConfigParser

parser = ConfigParser()
parser.read('dev.ini')

print(parser.sections())

FILE_PATH = parser.get('system', 'path')
print(FILE_PATH)
kakao_raw_data = None

# gspread deprecation warning 안나오게 하기.
warnings.filterwarnings("ignore", category=DeprecationWarning)

def read_file(file_path):
    global kakao_raw_data

    if kakao_raw_data is None:
        with open(file_path, 'r', encoding='utf-8') as file :
            kakao_raw_data = file.read()

def extract_dates_from_file(start_date = None, end_date = None):
    try:
        date_pattern = re.compile(r'\d{4}년 \d{1,2}월 \d{1,2}일')
      # '[월화수목금토일]요일')

        # print(kakao_raw_data)
        all_dates = date_pattern.findall(kakao_raw_data)
        # 문자열에서 날짜 부분을 추출하여 정렬
    
        unique_dates = []
        for date in all_dates:
            if date not in unique_dates:
                unique_dates.append(date)

        return sorted(unique_dates)

    except FileNotFoundError:
        print(f"파일 '{file_path}'을(를) 찾을 수 없습니다.")
    except Exception as e:
        print(f"오류 발생: {e}")

# 이거 날짜별 나눠서 정리할 수 있도록 해야함.
# 아니면, 이걸 호출해서 정리해서 list로 만들던지.

def authenticated_by_date(date_):
    #print("!!", date_) 
    senders = {} # 보낸 사람 리스트
    actions = ['✔️', '사진']

    for line in kakao_raw_data.split('\n'):
       #for date in date_:
        if date_ in line:
            # spec1. 이름의 구조는 01, 02 .. 99 까지 가능함.
            #        100 명은 안넘는다 가정.
            name_pattern = re.compile(r'\d{2}_([^\s/]+)')
            match = name_pattern.search(line)
            if match:
                name = match.groups(1)
            else:
                #print("!!!!!!!!!1 not match! ", line)
                continue

            # print("!@#@!#@!#@!!#@@!#", name)

            if ' : ' not in line:
                #print("나갔나? ")
                continue
            else: 
                action = line.split(' : ')[1].strip()

            if name is None:
                print("!!!!!!!!!!!!!!!!!! Name NOne!!!!!")
            
            # spec2. 사진, ✔️ 로 인증 처리함.
            #       * 사진의 갯수는 상관 없음.
            #       * '✔️' 문자 상관없음.

            # 제약사항 - 해당 사진이 인증을 위한 사진인지 구별x
            #          - 사진 + 훼이크 '✔️' 넣으면 구별 못함
            #            - 이정도 훼이크 정성이면 습관 첼린지를 하기로하자.
            #
            message_for_auth = None
            # 사진 구별
            # print(action)
            if re.match(r'사진$', action) or re.match(r'사진 \d+장$', action):
                message_for_auth = '사진'

            # check 표시 구별
            if message_for_auth == None and action.find('✔️') != -1:
                message_for_auth = '✔️' 

            if message_for_auth == None and action.find('✔') != -1:
                message_for_auth = '✔️' 

            # print(name, message_for_auth)
            # set dictionary로 중복제거.
            if message_for_auth != None:
                if name in senders:
                    senders[name].add(message_for_auth)
                else:
                    senders[name] = { message_for_auth }

    # 해당 날짜 검사하고, log 남기는 시스템 만들기.
    return senders

def makeLogFile(authenticated_people_list_):

    for date, authenticated_people in authenticated_people_list_.items():
        dir_name = datetime.strptime(date, "%Y. %m. %d.").strftime("%y.%m.%d")
        
        print(dir_name)
        print(authenticated_people)
       
        DIR = ('./log/' + dir_name + '/')
        try:
            if not os.path.exists(DIR):
                os.makedirs(DIR)
        except OSError:
            print('Error creating directory ' + dir_name)
        
        log_file = datetime.today().strftime("DateLog_%y.%m.%d_%H:%M")
        
        # "w+ 와 a 다른점 찾아봐"
        f = open(DIR + log_file,"a")
        f.writelines("*** 인증 날짜 : " + dir_name + "*** \n\n") 
        # 이거 넣는거 기억하고
        if authenticated_people:
            f.writelines(" == 인증 완료자 리스트 == \n")
            for sender, actions in authenticated_people.items():
                if len(actions) == 2:
                    f.write(sender[0] + "\n")
        
            f.writelines("\n == 인증 미 완료자 리스트 == \n")
            for sender, actions in authenticated_people.items():
                if len(actions) != 2:
                    f.write(sender[0] + "\n")
                    f.write("  ** "+ ", ".join(actions) + " 만 인증함. \n\n")



class GSpreadHelper:
    SHEET_FILE_NAME = "24년_미라클"
    NAME_COL_START = 2
    NAME_VALUE_START = 3
    ROW_NUMBER_FOR_DATE = 3

    # 넉넉하게 잡아둬라.
    NAME_CELL_END_LIST = '30'

    name_list = {}

    # spread에 접근하는 걸 도와주는 class
    def __init__(self):
        print("GSpread connecting.. ")
        self.gc = gspread.service_account() # 수정할 부분. 
        self.sh = self.gc.open(self.SHEET_FILE_NAME)
        self.worksheet = self.sh.get_worksheet(0)

        try:
            date_row_list = self.worksheet.row_values(self.ROW_NUMBER_FOR_DATE)
            self.last_date_value = date_row_list[-1]
            print(self.last_date_value)
            self.last_date_col = len(date_row_list)
            print(self.last_date_col)
        except IndexError:
            self.last_date_value = None
            self.last_date_col = 4 # this is start point
        
        gspread_name_list = self.worksheet.col_values(self.NAME_COL_START)
        print(gspread_name_list)

        value_idx = self.NAME_VALUE_START
        for name in gspread_name_list[self.NAME_VALUE_START:]:
            print(name)
            if name in self.name_list:
                self.name_list[name].add(name)
            else:
                value_idx += 1
                self.name_list[name] = value_idx
                print("!!!!!!", value_idx)

        print(self.name_list)
        
        if self.last_date_value is None:
            print(" this is last date none")

        print("Gspread connect!")

        # gc 같은거 박으면 될듯.
        # 날짜 등록, o등록 정도만 일단 해보자. <- 요게 핵심기능.
        #  이름 리스트를 먼저 가지고 와도 괜찮겠는데?
        #       번호와 이름을 매치해서 set으로 구현하면됨.
        #           이름을 검색하면 번호가 나오면 되고, + NAME_START_POINT로 위치 계산하고, 정해진 날짜에 o 표시만 하면 될듯.
        #   몇번떨어져있는지만 기록한다면. 상수로.


    def getLastDateValue(self):
        # print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ', self.last_date_value)
        return self.last_date_value

    def getLastDateCol(self):
        return self.last_date_col

    def updateDate1(self, date_list_):
        print(date_list_, " @@@ ", self.last_date_col + 1)
        
        tmp = self.last_date_col

        # Date 업데이트 하고,
        for date in date_list_:
            new_notation = f"{chr(tmp+ 1 + 64)}{self.ROW_NUMBER_FOR_DATE}"
            print(new_notation)
            tmp += 1
            self.worksheet.update(new_notation, date)

            # 이름 쭉 읽어서 일단. ok 표시부터
            # 시작할 때 이름 리스트 가지고 있고, 픽해서 바로 찾을 수 있도록.

    def UpdateDate(self, my_date):
        print(self.worksheet.row_values(2))

        last_date = self.worksheet.row_values(self.ROW_NUMBER_FOR_DATE)[-1]

        print(last_date)

        print(self.sh.sheet1.get('A1'))
        # 여기서 마지막 날짜를 가져와서, 그걸 기록하면됨.
        # 마지막 날짜를 업데이트하고, 그 날짜 받아서 인증 돌리면됨
        # 파일 경로와 시작일, 종료일 입력 받기

    def UpdateAuth(self, auth_list):
        #print(auth_list)
        
        #print(self.name_list.values())
        for name, actions in auth_list.items(): 
            if len(actions) == 2:
                print(type(name))
                print(name, self.name_list)
                value = self.name_list.get(name[0])
                if value is None:
                    print ("name nono..!!!!!!!!!!! ", name)
                    #self.name_list[name].add(name)
                else:
                    print ("name ok ", name)

    # 구현5. 정의
    def UpdateForAuth(self, date, auth_list):
        # 날짜먼저 넣고
        col1 = f"{chr(self.last_date_col + 64)}"
        # print(col1)
        new_date_dir = f"{col1}{self.ROW_NUMBER_FOR_DATE}"

        #print(new_date_dir)
        self.worksheet.update(range_name=new_date_dir, values=[[date]])
        # 이러면 날짜 들어감.

        current_cell_list = f"{col1}1:{col1}{self.NAME_CELL_END_LIST}" 
        print(current_cell_list)
        # 인증리스트 구현
        cell_list = self.worksheet.range(current_cell_list)
        cell_values = []
    
        for name, actions in auth_list.items():
            #print("@@@@@@@@@@@@ ", self.name_list.get(name[0]))
            if len(actions) == 2:
                if name[0] in self.name_list :
                    tmp = self.name_list[name[0]] - 1
                    print(tmp)
                    cell_values.append(tmp)
                    # print("!@#@!# !@##! @ ", tmp)
                else:
                    print("이름 없어..")
                    
        for i,val in enumerate(cell_values):
            print(i, val, type(i), type(val))
            cell_list[val].value = "O"

        # 덮어쓰기
        self.worksheet.update_cells(cell_list)
        self.last_date_col += 1
        #self.worksheet.update(range_name=tmp, values=[["O"]])

obj = GSpreadHelper()

# google spreadsheet에서 필요한 날짜를 구하면 될듯.
read_file(FILE_PATH)

# 필요한 날짜 넣고, 혹시 뒷편에 더있다면 더 출력해주는 형식으로 가면 될 듯.
# 아무것도 없다면, 그냥 다 출력.
founded_date_list = extract_dates_from_file()

#print(founded_date_list)

# kakao talk parsing에 필요한 날짜.
#formatted_date_list = [re.sub(r'\s[월화수목금토일]요일', '', date) for date in founded_date_list]

formatted_date_list_for_auth = [datetime.strptime(date_entry, "%Y년 %m월 %d일").strftime('%Y. %m. %d.').replace(' 0', ' ') for date_entry in founded_date_list]

# 구글이나 날짜 입력받는다면 여기서 해야함.
# 해서 날짜를 제거해.
#  gspread에서 날짜를 받으면 형식 변환해서 날짜보다 큰 부분만 배열에 정리하면됨.

# gspread에서 어떻게 받는지만 확인
# kakaotalk data로 비교해서 인증되는 사람 구하기.
# 날짜 별 데이터를 담아야함.

# 날짜 : 인증 목록
# nested dictionary 구하기.

# 여기 주석 처리하고 있음.

#  
authenticated_person_list = {}

for date in formatted_date_list_for_auth:
    if date in authenticated_person_list:
        print('ERROR : 날짜가 중복돼?', date)
        authenticated_person_list[date].add(authenticated_by_date(date))
    else:
        #print(date)
        authenticated_person_list[date] = authenticated_by_date(date)
        locale.setlocale(locale.LC_TIME,'ko_KR.UTF-8')
        reference_last_date = datetime.strptime(obj.getLastDateValue(),"%m/%d (%a)")
        #print(reference_last_date)
        formatted_date_for_gspread = datetime.strptime(date, "%Y. %m. %d.").strftime("%m/%d (%a)")

        #print(reference_last_date)
        if datetime.strptime(formatted_date_for_gspread, "%m/%d (%a)") >= reference_last_date:
            #print("!!!!!!!!!!@!@# ", formatted_date_for_gspread)
            obj.UpdateForAuth(formatted_date_for_gspread,authenticated_person_list[date])
