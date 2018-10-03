# p=[0.2, 0.2, 0.2, 0.2, 0.2]
# world=['green', 'red', 'red', 'green', 'green']
# Z = 'red'
# measurements = ['red','green']
# pHit = 0.6
# pMiss = 0.2

# #sense
# def sense(p, Z):
# 	q = []
# 	for index,val in enumerate(p):
# 		color = world[index]
# 		if(color == Z):
# 			q.append( val*pHit )
# 		else:
# 			q.append(val*pMiss )

# 	total = sum(q)
# 	for i in range(len(q)):
# 		q[i] = q[i]/total

# 	return q

# for m in measurements:
# 	p = sense(p,m)

# print(p)

# move
p=[0, 1, 0, 0, 0]
def move(p, U):
	q = p
	for index in range(0,U):
		tmp = q[-1]
		for i in range(1,len(q)):
			q[-i] = q[-i-1]
		q[0] = tmp
	return q

print(move(p, 1))
move(p,1)

