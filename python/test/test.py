class Test:
    state = {}
def func():
    return {1: '1'}

t = Test
out = func()
t.state = out
print(id(t.state))
print(id(out))
t.state[2] = "2"
print(out)