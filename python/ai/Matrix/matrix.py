import math
from math import sqrt
import numbers

def zeroes(height, width):
        """
        Creates a matrix of zeroes.
        """
        g = [[0.0 for _ in range(width)] for __ in range(height)]
        return Matrix(g)

def identity(n):
        """
        Creates a n x n identity matrix.
        """
        I = zeroes(n, n)
        for i in range(n):
            I.g[i][i] = 1.0
        return I
    
def dot_product(vector_one, vector_two):
    sum = 0;
    for i in range(len(vector_one)):
        sum += vector_one[i] * vector_two[i]
    return sum

class Matrix(object):

    # Constructor
    def __init__(self, grid):
        self.g = grid
        self.h = len(grid)
        self.w = len(grid[0])

    #
    # Primary matrix math methods
    #############################
 
    def determinant(self):
        """
        Calculates the determinant of a 1x1 or 2x2 matrix.
        """
        if not self.is_square():
            raise(ValueError, "Cannot calculate determinant of non-square matrix.")
        if self.h > 2:
            raise(NotImplementedError, "Calculating determinant not implemented for matrices largerer than 2x2.")
        
        # TODO - your code here
        if self.h == 1:
            return self.g[0][0]
       
        if self.h == 2:
            return self.g[0][0]*self.g[1][1] - self.g[0][1]*self.g[1][0]

    def trace(self):
        """
        Calculates the trace of a matrix (sum of diagonal entries).
        """
        if not self.is_square():
            raise(ValueError, "Cannot calculate the trace of a non-square matrix.")

        # TODO - your code here
        sum = 0;
        for i in range(self.h):
            for j in range(self.w):
                if i == j:
                    sum += self.g[i][j]
        return sum

    def inverse(self):
        """
        Calculates the inverse of a 1x1 or 2x2 Matrix.
        """
        if not self.is_square():
            raise(ValueError, "Non-square Matrix does not have an inverse.")
        if self.h > 2:
            raise(NotImplementedError, "inversion not implemented for matrices larger than 2x2.")

        # TODO - your code here
        inverse = []
        if self.h == 1:
            vec = [self.g[0][0]]
            inverse.append(vec)
        
        if self.h == 2:
            det = self.determinant()
            if det==0:
                return []
            co = 1.0/x
            for i in range(2):
                vec = []
                for j in range(2):
                    val = co * g[i][j]
                    if i!=j:
                        val *= -1
                        vec.append(val)    
                inverse.append(vec)
            
            #swap
            inverse[0][0],inverse[1][1] = inverse[1][1], inverse[0][0]

            
        return Matrix(inverse)

    def T(self):
        """
        Returns a transposed copy of this Matrix.
        """
        matrix_transpose = []
        for j in range(len(g[0])):
            vec = []
            for i in range(len(g)):
                vec.append(g[i][j])
            matrix_transpose.append(vec)
    
        return Matrix(matrix_transpose)

    def is_square(self):
        return self.h == self.w

    #
    # Begin Operator Overloading
    ############################
    def __getitem__(self,idx):
        """
        Defines the behavior of using square brackets [] on instances
        of this class.

        Example:

        > my_matrix = Matrix([ [1, 2], [3, 4] ])
        > my_matrix[0]
          [1, 2]

        > my_matrix[0][0]
          1
        """
        return self.g[idx]

    def __repr__(self):
        """
        Defines the behavior of calling pr siu on an instance of this class.
        """
        s = ""
        for row in self.g:
            s += " ".join(["{} ".format(x) for x in row])
            s += "\n"
        return s

    def __add__(self,other):
        """
        Defines the behavior of the + operator
        """
        if self.h != other.h or self.w != other.w:
            raise(ValueError, "Matrices can only be added if the dimensions are the same") 
        #   
        # TODO - your code here
        #
        matrixSum = []
        row = []
        for i in range(self.h):
            for j in range(self.w):
                row.append(self.g[i][j] + other[i][j])
            matrixSum.append(row)
            row = []
    
        return Matrix(matrixSum)

    def __neg__(self):
        """
        Defines the behavior of - operator (NOT subtraction)

        Example:

        > my_matrix = Matrix([ [1, 2], [3, 4] ])
        > negative  = -my_matrix
        > print(negative)
          -1.0  -2.0
          -3.0  -4.0
        """
        #   
        # TODO - your code here
        #
        matrix = []
        row = []
        for i in range(self.h):
            for j in range(self.w):
                row.append(-self.g[i][j])
            matrix.append(row)
            row = []
    
        return Matrix(matrix)

    def __sub__(self, other):
        """
        Defines the behavior of - operator (as subtraction)
        """
        matrixSum = []
        row = []
        for i in range(self.h):
            for j in range(self.w):
                row.append(self.g[i][j] - other[i][j])
            matrixSum.append(row)
            row = []
    
        return Matrix(matrixSum)

    def __mul__(self, other):
        """
        Defines the behavior of * operator (matrix multiplication)
        """
        otherTransMatrix = other.T()
        product = []
        rowsA = self.h
        rowsB = len(otherTransMatrix)
        rows_result = []
        for i in range(rowsA):
            for j in range(rowsB):
                val = dot_product(self.g[i], otherTransMatrix[j])
                rows_result.append(val)
            product.append(rows_result)
            rows_result = []

        return Matrix(product)
        
        

    def __rmul__(self, other):
        """
        Called when the thing on the left of the * is not a matrix.

        Example:

        > identity = Matrix([ [1,0], [0,1] ])
        > doubled  = 2 * identity
        > print(doubled)
          2.0  0.0
          0.0  2.0
        """
        if isinstance(other, numbers.Number):
            pass
             
            matrix = []
            row = []
            for i in range(self.h):
                for j in range(self.w):
                    row.append(self.g[i][j] * other)
                matrix.append(row)
                row = []
            return Matrix(matrix)
            

print(4*identity(5))
# assert (4*identity(5)).trace() == 20