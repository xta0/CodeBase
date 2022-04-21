from time import perf_counter
from functools import wraps
from typing import Callable, Optional, TypeVar

T = TypeVar("T")
# -> Callable[...,T
#  -> Callable[[ Callable[[T], T] ], Callable[...,T]:
def timed(prefix: Optional[str]=None):
    def dec(fn): 
        @wraps(fn)
        def closure(*args, **kwargs):
            start = perf_counter()
            result = fn(*args, **kwargs)
            end = perf_counter()
            elaspsed = end - start
            args_ = [str(a) for a in args]
            kwargs_ = ['{0}={1}'.format(k, v) for (k, v) in kwargs.items()]
            all_args = args_ + kwargs_
            args_str = ','.join(all_args)
            print(prefix + ' {0}({1}) took: {2: .6f}s to run.'.format(fn.__name__, args_str, elaspsed))
            return result
        return closure
    return dec

    
@timed('[]')
def fib(n):
    return 1 if n < 3 else fib(n-1) + fib(n-2)

fib(10)

@timed('[]')
def func(x):
    return x

x = """
[cxx]
    link_groups_enabled = true
"""
func(x)