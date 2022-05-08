name = input("Enter file:")
if len(name) < 1:
    name = "mbox-short.txt"
handle = open(name)

hcount=dict()
for line in handle:
    line=line.rstrip()
    word=line.split()
    if len(word)>2 and word[0]=='From':
        hour=word[5].split(':')
        hcount[hour[0]]=hcount.get(hour[0],0)+1
    else:
        continue

tmp=list()
for k,v in hcount.items():
    tmp.append((k,v))

tmp.sort()
for k,v in tmp:
    print(k,v)
