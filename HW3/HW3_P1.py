# AE370 HW3 Connor Latham
# This is the python that creates the data for and plots the data for the problems

# sympy for the given function
import sympy as sy
# numpy for arrays and array ops
import numpy as np
# matplotlib for plotting
import matplotlib.pyplot as plt
# import Interp_Point_Maker for the interp_maker function to make the interpolation points
from Interp_Points_Maker import interp_maker

# create the 'x' symbol
x = sy.symbols('x')
# create the function to be interpolated
f = 1/(1+x**2)
# set up the bounds for the range
lbound = -5
ubound = 5
# set up the small matrix for the different n's
n = [5, 10, 25, 50]
# create the for loop to loop through n (index1)
for int,value in enumerate(n):
    # Section 1: Makes interp points, constants, and A matrix, empty
    # call interpmaker to make the interpolation points
    intpoints = interp_maker(lbound,ubound,value)
    # create a matrix to store the scaling constants
    consts = np.zeros([4*value,1])
    # create an A matrix to store the values when evaluated for different splines
    Amat = np.zeros([value,value])

    # Section 2: Evaluate the function at the interpolation points and make the column matrix
    # lambdify the function to help evaluate it faster
    lamf = sy.lambdify(x,f,"numpy")
    # create a matrix to store the values of the functions at the interpoints
    func = np.transpose(lamf(intpoints))

    # Section 3: Evaluate the various points in the A matrix
