%% AE370 Homework 5 Feb. 17, 2019
%% Problem 1
clear all, close all, clc

% SETUP

% declare the different n values to eval at
nvect = [2 8 16 20];
% define the function to appx.
fcn = @(x) 1 ./ (1 + x.^2);
% set up the endpoints of the range
endp = [-5,5];

% EXACT INTEGRAL VALUE

% declare a sym
syms x
% eval the integral
int_exact = double(int(fcn(x), x, endp(1), endp(2)))
% clear the symbolic
clear x

% ERROR STRUCT INITIATION

% equispaced lagrange
err.eqLag = [];
% chebyshev lagrange
err.chebLag = [];
% equispaced composite trapezoid
err.comTrap = [];

%% Part A

% SETUP

% create a symbolic x
syms x
% set up a for loop to go through nvect
for i = 1:length(nvect)
    % assign a variable the specific number of n
    ni = nvect(i);
    
    % INTERPOLATION
    
    % create the interpolation points
    intPoints = interp_Maker(endp,ni,'eq');
    % evaluate the given function at the interpolation points to get coeffs
    intVals = fcn(intPoints);
    % create the lagrangian function
    func = lag_Func(intPoints,intVals);
    
    % EVALUATION
    
    % evaluate the integral with the approximating function
    int_appx = double(int(func(x),x,endp(1),endp(2)));
    % find the error between the appx and the exact answer
    err.eqLag(i) = norm(int_appx-int_exact);
end
disp("Equispaced Lagrange = " + num2str(err.eqLag))
% clear the symbolic just in case
clear x i func int_appx intPoints intVals ni

%% Part B 

% SETUP

% declare a symbolic x for integrating
syms x
% set up a for loop to go through nvect
for i = 1:length(nvect)
    % assign a variable the specific number of n
    ni = nvect(i);
    
    % INTERPOLATION
    
    % create the interpolation points
    intPoints = interp_Maker(endp,ni,'ch');
    % evaluate the given function at the interpolation points to get coeffs
    intVals = fcn(intPoints);
    % create the lagrangian function
    func = lag_Func(intPoints,intVals);
    
    % EVALUATION
    
    % evaluate the integral with the approximating function
    int_appx = double(int(func(x),x,endp(1),endp(2)));
    % find the error between the appx and the exact answer
    err.chebLag(i) = norm(int_appx-int_exact);
end
disp("Chebspaced Lagrange = " + num2str(err.chebLag))
% clear the symbolic just in case
clear x i func int_appx intPoints intVals ni

%% Part C

% SETUP

% for loop to iterate through nvect
for i = 1:length(nvect)
    % assign a variable the n
    ni = nvect(i);
    % create the uniformly spaced points
    intpoints = interp_Maker(endp,ni,'eq');
    % find delta, should be equal everywhere so use first two points
    delta = intpoints(2)-intpoints(1);
    % assign the first value to comp trap, f(x0)
    comptrap = fcn(intpoints(1));
    % iterate and add to comp trap, the sigma from j=1 to n-1 of f(xj)
    for j = 2:length(intpoints)-1
        comptrap = comptrap + 2*fcn(intpoints(j));
    end
    % add the last part f(xn) and multiply through the .5 and delta
    int_appx = .5*delta*(comptrap + fcn(intpoints(length(intpoints))));
    % assign the error
    err.comTrap(i) = norm(int_appx-int_exact);
end
% display the final errors found
disp("Uniform Composite Trapezoid = " + num2str(err.comTrap));

%% Plotting A, B, C
semilogy(nvect,err.eqLag,'r.',...
    nvect,err.chebLag,'b.',...
    nvect,err.comTrap,'g.',...
    'markersize',26);
h = legend('Equispaced Lagrange Interpolant',...
    'Chebyshev Lagrange Interpolant',...
    'Composite Trapezoid');
set( h, 'location', 'NorthWest', 'interpreter', 'latex', 'fontsize', 10)
xlabel( 'n', 'interpreter', 'latex', 'fontsize', 12)
ylabel( 'max error', 'interpreter', 'latex', 'fontsize', 12)
title( 'Error vs. n', 'interpreter', 'latex', 'fontsize', 12);
set(gca, 'TickLabelInterpreter','latex', 'fontsize', 16 )
set(gcf, 'PaperPositionMode', 'manual')
set(gcf, 'Color', [1 1 1])
set(gca, 'Color', [1 1 1])
set(gcf, 'PaperUnits', 'centimeters')
set(gcf, 'PaperSize', [15 15])
set(gcf, 'Units', 'centimeters' )
set(gcf, 'Position', [0 0 15 15])
set(gcf, 'PaperPosition', [0 0 15 15])