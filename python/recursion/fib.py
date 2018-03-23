def fib1(n):
    if n==0 or n==1:
        return n
    else:
        return fib1(n-1)+fib1(n-2)

print(fib1(30))

def fib2(n):
    l = list(range(0,n+1))
    l[0] = 0
    l[1] = 1
    for i in range(2,n+1):
        l[i] = l[i-1]+l[i-2]

    return l[n]

print(fib2(30))
