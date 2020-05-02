import os, sys
import requests
import time

default_ip = '10.108.216.207'
default_port = '9002'

if len(sys.argv) != 3:
    print(f'Using default configuration.')
    ip, port = default_ip, default_port
else:
    ip, port = sys.argv[1:]

url = f'http://{ip}:{port}'
print(f'Polling url: {url}')

last_kr = ''
while True:
    try:
        response = requests.get(url, timeout = 2)
        resp_text = response.text
    except Exception as e:
        print(f'Exception: {e}')
        time.sleep(1)
        continue

    if len(last_kr) != len(resp_text) or  last_kr != resp_text:
        print(f'New kr: {resp_text[:10]} ...')
        last_kr = resp_text
        os.system(f'echo "{resp_text}" | pbcopy')

    else:
        pass
    time.sleep(1)

