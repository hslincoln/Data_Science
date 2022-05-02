fname = input("Enter file name: ")
try:
    fh = open(fname)
except:
    print('File cannot be opened:', fh)
    quit()

for line in fh:
    line=line.rstrip(fh)
print(upper(line))
