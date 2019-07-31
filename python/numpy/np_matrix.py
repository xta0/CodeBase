import numpy as np

# Python's two dimension array
L = [ [1,2], [3,4] ]
L[0] #[1,2]
L[0][0] #1

# Numpy's two dimension matrix
M = np.array([1,2], [3,4])
M[0] #[1,2]
M[0,0] #1

# numpy's matrix API
M2 = np.matrix([ [1,2],[3,4] ])
#convert matrix to np array
M = np.array(M2)