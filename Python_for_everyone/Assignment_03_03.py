score = input("Enter Score: ")
fs=float(score)
if fs >= 0.9 and fs <= 1.0:
    print("A")
elif fs >= 0.8 and fs <= 1.0:
    print("B")
elif fs >= 0.7 and fs <= 1.0:
    print("C")
elif fs >= 0.6 and fs <= 1.0:
    print("D")
elif fs < 0.6 and fs >= 0.0:
    print("F")
else:
    print("Error")
