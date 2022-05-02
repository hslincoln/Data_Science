# Use the file name mbox-short.txt as the file name
fname = input("Enter file name: ")
try:
    fh = open(fname)
except:
    print('File cannot be opened:',fname)
    quit()

count=0
number=0
for line in fh:
    if not line.startswith("X-DSPAM-Confidence:"):
        continue
    count=count+1
    number=number+float(line[20:])
mean=number/count
print("Average spam confidence:", mean)
