from configparser import ConfigParser

config = ConfigParser()

# gmail 정보
config['gmail'] = {
    'id' : 'kkumhaha@gmail.com',
    'secret_key' : 'snrb zzob fijh nrka',
    'dir' : '/home/sundoo/python_parser'
}

with open('./dev.ini', 'w') as f:
    config.write(f)
