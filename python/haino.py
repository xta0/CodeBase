
count = 0
def move(n,src,mid,dst):
    print("move",n,"from",src,"to",dst)
    global count
    count = count+1
    if n == 1:
        print("Count:",count)
        return
    else:
        move(n-1,src,dst,mid)
        move(1,src,mid,dst)
        move(n-1,mid,src,dst)
    
move(3,'start','buffer','end')
