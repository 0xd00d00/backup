import email
import imaplib
import smtplib
import os
import re
import shutil # 압축푸는 모듈
import subprocess # process shellscript 수행

from datetime import datetime
from email.mime.text import MIMEText
from pathlib import Path

from configparser import ConfigParser

#  smtp = smtplib.SMTP('smtp.gmail.com', 587)
#  smtp.starttls()
#  
#  smtp.login('kkumhaha@gmail.com', 'snrb zzob fijh nrka')
#  
#  msg = MIMEText('하하ㅏㅎ')
#  
#  msg['Subject'] = '제목이다 자식'
#  
#  smtp.sendmail('kkumhaha@gmail.com','sksioi1234@gmail.com',msg.as_string())
#  

# Gmail의 첨부파일을 가져오는 클래스
class GmailAttachment:
    attach_dir = None

    def __init__(self):
        parser = ConfigParser()
        parser.read('dev.ini')

        print(parser.sections())
        self.gm_id = parser.get('gmail', 'id')
        self.gm_pw = parser.get('gmail', 'secret_key')

        self.gm_dir = parser.get('gmail', 'dir')
        self.attach_dir = self.gm_dir + '/attachments'
        self.gm_subject = parser.get('gmail', 'subject')
        self.latest_file = Path(self.attach_dir) / 'latest_miracle.txt'

        if 'attachments' not in os.listdir(self.gm_dir):
            os.mkdir('attachments')

        self.imap = imaplib.IMAP4_SSL('imap.gmail.com', 993)
        typ, accountDetail = self.imap.login(self.gm_id, self.gm_pw)

        if typ :
            print("ok")
        else :
            print("not ok")

        for i in self.imap.list()[1]:
            l = i.decode().split(' "/" ')
            print(l[0] + " = " + l[1])

        # status, msg = imap.uid('search', None,'ALL')

        if typ != 'OK':
            print('로그인 불가')
            raise # try 넣고 돌리면 됨.
        else:
            print('로그인 성공')


        if os.path.exists(self.latest_file):
            os.remove(self.latest_file)
            print("latest_file.txt 파일 제거완료")

        kakaoMSG = Path(self.attach_dir) / 'KakaoTalkChats.txt'

        if os.path.exists(kakaoMSG):
            os.remove(kakaoMSG)
            print('KakaoTalkChats.txt 파일 제거완료')
    
    #  def __del__(self):
    #      self.imap.logout()
    #      self.imap.close()

    def search(self):
        print(self.gm_subject)
        self.imap.select("INBOX", readonly=True)
        self.imap.literal = f'{self.gm_subject}'.encode('utf-8')
        typ, data = self.imap.uid('search','CHARSET', 'UTF-8', 'SUBJECT')

        print(data)
        if typ != 'OK':
            print ('검색중 에러 발생')

        msgId = data[0].split()
        recentMsgId = msgId[-1]

        typ, messageParts = self.imap.uid('fetch',recentMsgId, '(RFC822)')
    
        print(messageParts)
        emailBody = messageParts[0][1]
        if emailBody is None:
            print("!!!!!!!!!!! none")
            raise
        mail = email.message_from_string(emailBody.decode('utf-8'))

        print ("FROM:",mail['FROM'])
        b, encode = self.findEncodingInfo(mail['Subject'])
        print ("Subject: ",b)
        print ("Subject: ",encode)
        print ("Date : ", mail['DATE'])

        mail = email.message_from_bytes(emailBody)

        return mail

    # logging을 위해
    def findEncodingInfo(self, txt):
        info = email.header.decode_header(txt)
        s, encoding = info[0]
        return s, encoding

    def storedFile(self, mail):
        print("!!!!!!!!!!!!!!!!!")
        for part in mail.walk():
            if part.get_content_maintype() == 'multipart':
                print("multipart")
                continue
            if part.get('Content-Disposition') is None:
                continue
        
            print("!@@#!#!@")
            fileName = part.get_filename()
            print("@@@", fileName)

            filePath = os.path.join(self.attach_dir, fileName)

            if not os.path.isfile(filePath) :
                print(fileName)
                fp = open(filePath, 'wb')
                fp.write(part.get_payload(decode=True))
                fp.close()
            
        return filePath
        
    def unpack(self, zipPath, output_dir, merge = False):

        # unzip 압축파일
        shutil.unpack_archive(zipPath, output_dir)
        
        output_file = Path(output_dir) / 'miracle.txt'
        
        print(output_file)
        if os.path.exists(output_file):
            os.remove(output_file)
            print(" 파일 존재해서 제거완료!")

        if merge :
            with open(output_file, 'wb') as output:
                # 오름차순
                for file_name in sorted(os.listdir(output_dir)):
                    print(file_name)
                    local_file_path = Path(output_dir) / file_name
                    with open(local_file_path, 'rb') as file:
                        output.write(file.read())
        else :
            files = os.listdir(output_dir)
            first_file = sorted(files, reverse=True)[0]
            print("old file ", first_file)
            shutil.move(Path(output_dir) / first_file, output_file)
            shutil.copy(output_file, Path(self.attach_dir) / 'latest_miracle.txt')
            print("new file ", output_file)
        
        if os.path.exists(zipPath):
            os.remove(zipPath)
            print("zip파일 제거완료")

    def hub(self, stored_file):
        current_date = datetime.now() 
        date_format = "%Y-%m-%d"
        formatted_date = current_date.strftime(date_format)
        output_dir = self.attach_dir + f"/{formatted_date}"

        if not os.path.exists(output_dir):
            os.mkdir(output_dir)

        if '.zip' in stored_file:
            self.unpack(stored_file, output_dir)
        elif '.txt' in stored_file:
            print("!!!", stored_file)

            with open(stored_file, 'r', encoding='utf-8') as file:
                    lines = file.readlines()

            # 정규표현식을 사용하여 ','가 없는 문장을 찾아서 년, 월, 일을 각각 "."으로 대체
            modified_lines = []
            for line in lines:
                if ',' in line:
                    line = re.sub(r'(\d{4}년 \d{1,2}월 \d{1,2}일)', lambda x: x.group().replace('년', '.').replace('월', '.').replace('일', '.'), line)
                modified_lines.append(line)

            with open(self.latest_file, 'w', encoding='utf-8') as file:
                file.writelines(modified_lines)

            shutil.copy(self.latest_file, Path(output_dir) / 'latest_miracle.txt')

    def report(self, test):
        smtp = smtplib.SMTP('smtp.gmail.com', 587)
        smtp.starttls()
        smtp.login(self.gm_id, self.gm_pw)
        a = '[오늘의 인증자] \n\n'
        a += '람\n'
        a += '최지\n'

        a += '\n ================= \n\n'
        a += '[오늘의 미인증자] \n\n'
        a += '널두\n'

       
        for name in test:
            print(name)

        listEmail = 'lg97694952@gmail.com, sugar_jwl@naver.com'
        msg = MIMEText(a)
        msg['Subject'] = '2023.12.22일 인증자 리포트'
        smtp.sendmail('kkumhaha@gmail.com',listEmail.split(','),msg.as_string())

        print("Report complete!")

at = GmailAttachment()
received_mail = at.search()
file_path = at.storedFile(received_mail)
at.hub(file_path)
#at.report('[철규, 널두, 최지, 람, 단풍, bluesk]')
