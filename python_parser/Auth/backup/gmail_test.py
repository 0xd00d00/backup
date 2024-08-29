import email
import imaplib
import smtplib
import os
import shutil # 압축푸는 모듈

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
        gm_id = parser.get('gmail', 'id')
        gm_pw = parser.get('gmail', 'secret_key')

        self.gm_dir = parser.get('gmail', 'dir')
        self.attach_dir = self.gm_dir + '/attachments'
        self.gm_subject = parser.get('gmail', 'subject')

        if 'attachments' not in os.listdir(self.gm_dir):
            os.mkdir('attachments')

        self.imap = imaplib.IMAP4_SSL('imap.gmail.com', 993)
        typ, accountDetail = self.imap.login(gm_id, gm_pw)

        # print(imap.list())

        for i in self.imap.list()[1]:
            l = i.decode().split(' "/" ')
            print(l[0] + " = " + l[1])

        # status, msg = imap.uid('search', None,'ALL')

        if typ != 'OK':
            print('로그인 불가')
            raise # try 넣고 돌리면 됨.
        else:
            print('로그인 성공')
    
    #def __del__(self):
        #self.imap.close()
        #self.imap.logout()

    def search(self):
        print(self.gm_subject)
        self.imap.select("INBOX", readonly=True)
        self.imap.literal = f'{self.gm_subject}'.encode('utf-8')
        typ, data = self.imap.uid('search','CHARSET', 'UTF-8', 'SUBJECT')
        #  
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

        mail = email.message_from_bytes(emailBody)

        return mail

    # logging을 위해
    def findEncodingInfo(self, txt):
        info = email.header.decode_header(txt)
        s, encoding = info[0]
        return s, encoding

    def storedZIP(self, mail):
        print("!!!!!!!!!!!!!!!!!")
        for part in mail.walk():
            if part.get_content_maintype() == 'multipart':
                print("multipart")
                continue
            if part.get('Content-Disposition') is None:
                continue
        
            print("!@@#!#!@")
            fileName = part.get_filename()
            print(fileName)
            
            if fileName == '.zip':
                filePath = os.path.join(self.attach_dir, 'miracle.zip')
                if not os.path.isfile(filePath) :
                    print(fileName)
                    fp = open(filePath, 'wb')
                    fp.write(part.get_payload(decode=True))
                    fp.close()
            else:
                filePath = os.path.join(self.attach_dir, 'latest_miracle.txt')
                print("!!!!!!!!!!", filePath)
                if os.path.isfile(filePath) :
                    print(fileName)
                    fp = open(filePath, 'wb')
                    fp.write(part.get_payload(decode=True))
                    fp.close()

        return filePath
        
    def unpack(self, zipPath, merge = False):
        current_date = datetime.now() 
        date_format = "%Y-%m-%d"
        formatted_date = current_date.strftime(date_format)

        # unzip 압축파일
        shutil.unpack_archive(zipPath, self.attach_dir + f"/{formatted_date}")
        
        output_dir = self.attach_dir + f"/{formatted_date}"
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

at = GmailAttachment()
received_mail = at.search()
zipPath = at.storedZIP(received_mail)

if zipPath == '.zip':
    at.unpack(zipPath)


# 받은 편지함.
#  imap.select("INBOX")
#  search_criteria = '(FROM "0xd00d00b@gmail.com")'
#  typ, data = imap.uid('search',None, search_criteria)
#  
#  print(data)
#  if typ != 'OK':
#      print ('검색중 에러 발생')
#  
#  
#  # 가장 마지막 메세지만 가져오면 됨.
#  
#  msgId = data[0].split()
#  recentMsgId = msgId[-1]
#  
#  typ, messageParts = imap.uid('fetch',recentMsgId, '(RFC822)')
#  
#  if typ != 'OK':
#      print('메일 가져오는 데 에러 발생')
#  
#  
#  print(messageParts)
#  emailBody = messageParts[0][1]
#  
#  if emailBody is None:
#      print("!!!!!!!!!!! none")
#      raise
#  mail = email.message_from_bytes(emailBody)
#  
#  for part in mail.walk():
#      if part.get_content_maintype() == 'multipart':
#          continue
#      if part.get('Content-Disposition') is None:
#          continue
#  
#      fileName = part.get_filename()
#      print(fileName)
#  
#      if bool(fileName):
#          filePath = os.path.join(detach_dir, 'attachments', 'e.zip')
#          if not os.path.isfile(filePath) :
#              print(fileName)
#              fp = open(filePath, 'wb')
#              fp.write(part.get_payload(decode=True))
#              fp.close()
#  
#  # 함수화 가능
#  current_date = datetime.now()
#  
#  date_format = "%Y-%m-%d"
#  
#  formatted_date = current_date.strftime(date_format)
#  
#  
#  #if f"{formatted_date}" not in os.listdir(attach_dir):
#  #    os.mkdir(f"{formatted_date}")
#  
#  shutil.unpack_archive(detach_dir + '/attachments/e.zip', attach_dir + f"/{formatted_date}")
#  
#  output_dir = attach_dir + f"/{formatted_date}"
#  output_file = Path(output_dir) / 'e.txt'
#  
#  print(output_file)
#  if os.path.exists(output_file):
#      os.remove(filePath)
#      print(" 파일 존재해서 제거완료!")
#  
#  with open(output_file, 'wb') as output:
#      # 오름차순
#      for file_name in sorted(os.listdir(output_dir)):
#          print(file_name)
#          local_file_path = Path(output_dir) / file_name
#          with open(local_file_path, 'rb') as file:
#              output.write(file.read())
#  
#  imap.close()
#  imap.logout()


# msg = msg[0].split()

#  recent_email = msg[-1]
#  print(recent_email)
#  
#  res, msg = imap.uid('fetch', recent_email, "(RFC822)")
#  
#  raw = msg[0][1]
#  
#  raw_readable = msg[0][1].decode('utf-8')
#  
#  print(raw_readable)
