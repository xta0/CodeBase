import re

# find
def myfirst_yoursecond(p,q):
    myfirst = p[0:p.find(" ") ]
    yourSecond = q[q.find(" ")+1:]
    return myfirst == yourSecond

print(myfirst_yoursecond("c b", "b a"))

# split
str1 = "abc102#)*gdf"
print(str1.split('b'))
l = re.compile(r"[a-zA-Z]+").split(str1);
print(l)

#find all
print(re.findall(r"[0-9]+","1+23=3"))