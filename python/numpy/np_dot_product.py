import numpy as np 
from datetime import datetime

a = np.random.randn(100)
b = np.random.randn(100)
T = 100000

def slow_dot_product(a,b ):
    result = 0
    for e,f in zip(a,b):
        result += e*f
    return result

dt0 = datetime.now()
for t in range(T): 
    slow_dot_product(a,b)
dt1 = datetime.now() - dt0

dt0 = datetime.now()
for t in range(T):
    #numpy dot product
    a.dot(b)
dt2 = datetime.now() - dt0

print("dt1/dt2: ", dt1.total_seconds() / dt2.total_seconds()) #~40