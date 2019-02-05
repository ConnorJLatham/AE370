# import numpy for arange
from numpy import *
# define the interp_maker function to make interpolation points
# takes an upper, lower bound, number of points, and a type of distribution
# this type could be equispaced or chebyshev
# define the function
def interp_maker(lbound,ubound,n,type='equispaced'):
    # create if statements to determine what type of points to create
    if type == 'equispaced' or type == 'Equispaced' or type == 'Eq':
        # create a zeros range the size we want
        range = zeros([1,(n+1)])
        # initialize the index to 0
        ind = 0
        # set up while loop to run from 0 to size(range)-1
        while ind<size(range):
            # assign the values in the range with the equispaced formula
            range[0,ind] = lbound+(ubound-lbound)*ind/n
            # increase the index
            ind+=1
        # return the created range
        return range
    # TODO
    # if type == 'chebyshev' or type == 'Chebyshev' or type == 'Ch':
    #     range =
