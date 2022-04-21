from timer import timed

print("---fib-------")
def fib(n):
    print('calc fib({0})'.format(n))
    return 1 if n < 3 else fib(n-1) + fib(n-2)

fib(10)

print("---fib1-------")

def fib1():
    cache = {1:1, 2:1}
    def calc_fib(n):
        if n not in cache:
            print('calc fib({0})'.format(n))
            cache[n] = calc_fib(n-1) + calc_fib(n-2)
        return cache[n]
    return calc_fib

g = fib1()
g(10)

print("---fib2-------")

def memoize(fn):
    cache = dict()
    def inner(n):
        if n not in cache:
            print('calc fib({0})'.format(n))
            cache[n] = fn(n)
        return cache[n]
    return inner


@memoize
def fib2(n):
    return 1 if n < 3 else fib2(n-1) + fib2(n-2)

fib2(10)
fib2(10)


print("---fib3-------")

from functools import lru_cache
@lru_cache()
@timed
def fib3(n):
    print('calc fib({0})'.format(n))
    return 1 if n < 3 else fib3(n-1) + fib3(n-2)

fib3(10)
fib3(10)


