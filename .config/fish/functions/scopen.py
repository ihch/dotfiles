import os, sys

argl = [int(e) for i, e in enumerate(sys.argv) if i is not 0]
l = []

with open('scrape.txt', 'r') as f:
    for i in f:
        l.append(i.split()[-1])

for i in argl:
    # os.system('chrome {}'.format(l[i]))
    os.system('/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe {}'.format(l[i]))
    # print(l[i])

