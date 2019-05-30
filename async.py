def generator():
    yield 1

print(generator().send(None))

# 如果一函数用async声明，则这个函数的返回值类型为coroutine
async def async_function():
    return 1
print(type(async_function())) #<class 'coroutine'>

# async函数不能直接调用，需要和其它asyn函数进行配合调用
# 如果想要但使用，可以直接使用send方法，但是会抛异常
def run(coroutine):
    try:
        coroutine.send(None) #抛异常
    except StopIteration as e:
        return e.value

run(async_function())

# 另一种驱动async函数的方法是使用await关键字
# await可以将一个async函数挂起
# await只能修饰async函数或者是返回Awaitable对象的函数
async def await_function():
    result = await async_function()
    print(result)

class Potato:
    @classmethod
    def make(cls, num, *args, **kws):
        potatos = []