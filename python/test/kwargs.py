def func1(x, **kwargs):
    print(kwargs)

def func2(y, **kwargs):
    func1(y, **kwargs)
    
func2(y=10, asd="123")