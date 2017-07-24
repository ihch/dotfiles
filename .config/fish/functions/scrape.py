import sys
import threading
import requests
from bs4 import BeautifulSoup

def init():
    for e in soup.find_all('a'):
        if "footer" in str(e):
            break

        if (e.string is not None) and (not ("tags" in str(e))) and (20 < len(e['href'])) and (5 < len(e.string)):
            show_list.append("{}: {}".format(e.string, "http://qiita.com" + e['href']))

def show():
    print("*********           今日の記事          *********")
    for i in show_list:
        print(i)
    print("*********                               *********")

def write_sc():
    with open('scrape.txt', 'w') as f:
        for i in show_list:
            f.write(i + "\n")

def main():
    th1 = threading.Thread(target=show)
    th2 = threading.Thread(target=write_sc)
    init()
    th1.start()
    th2.start()

if __name__ == '__main__':
    url = "http://qiita.com/tags/Python"
    res = requests.get(url)
    html = res.text
    soup = BeautifulSoup(html, 'html.parser')
    show_list = []

    if res.status_code is not 200:
        sys.exit(0)

    main()

