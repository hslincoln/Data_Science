name = input("Enter file:")
if len(name) < 1:
    name = "mbox-short.txt"
handle = open(name)

di=dict()
for line in handle:
    line=line.rstrip()
    if not line.startswith("From "):
        continue
    word=line.split()
    email=word[1]
    di[email]=di.get(email,0)+1

max=None
maxkey=None
for key in di:
    if max is None or max < di[key]:
        max=di[key]
        maxkey=key
print(maxkey,max)
