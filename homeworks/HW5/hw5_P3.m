%% AE370 Homework 5 Feb. 17, 2019
%% Problem 3
clear all, close all, clc

% SETUP

% declare the different n values to eval at
nvect = [4 16 24 48];
% define the function to appx.
fcn = @(x) sin(10*pi*x);
% set up the endpoints of the range
endp = [0,2];

% EXACT INTEGRAL VALUE

% declare a sym
syms x
% eval the integral
int_exact = double(int(fcn(x), x, endp(1), endp(2)))
% clear the symbolic
clear x

% ERROR STRUCT INITIATION

% equispaced composite trapezoid
err = [];

%% Part A

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
    err(i) = norm(int_appx-int_exact);
end
% display the final errors found
disp("Uniform Composite Trapezoid = " + num2str(err));

%% Plotting A, B, C
semilogy(nvect,err,'r.',...
    'markersize',26);
h = legend('Equispaced Lagrange Interpolant',...
    'Chebyshev Lagrange Interpolant',...
    'Composite Trapezoid');
set( h, 'location', 'NorthEast', 'interpreter', 'latex', 'fontsize', 10)
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