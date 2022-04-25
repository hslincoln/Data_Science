hrs = input("Enter Hour:")
rate = input("Enter Rate: ")

h = float(hrs)
r = float(rate)

def computepay(h,r):
       if h <= 40 :
           pay=h*r
       else:
           pay=40 * r + (h - 40) * r * 1.5
       return pay

p = computepay(h,r)
print("Pay",p)
