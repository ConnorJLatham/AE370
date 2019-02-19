%% AE370 HW4
clear, clc
%% Problem 1
clear, clc
%% Problem 2
clear, clc

% set up interval endpoints
endp = [-5,5];
% set up the function symbolically
func = @(x) 1/(1+x.^2);
% set up the n array
n = [5 10 25 50];
% make a for loop for iterating through n
for i=1:length(n)
    % set the value of n for the iteration
    ni = n(i);
    % create the basis functions
    for basisind = 1:ni+1
        basis(basisind) = phifunc(basisind-1);
    % create the A matrix
    for row = 1:ni
        for column = 1:ni
            
    
