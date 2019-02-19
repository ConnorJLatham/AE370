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
int_exact = int(fcn( x ), x, endp(1), endp(2));
% clear the symbolic
clear x

% ERROR STRUCT INITIATION

% equispaced lagrange
err.eqLag = [];
% chebyshev lagrange
err.chebLag = [];
% equispaced composite trapezoid
err.comTrap = [];

%% Part A (build up sym func, and integrate)

%  SETUP
% syms x
% err = zeros( length( nvect ), 1 );
% for j = 1 : length( nvect )
% n = ???;
% %xjs at which to define the L_i
% xj = ???
% %define Lagrange basis vectors
% intval = 0;
% for i = 1 : n + 1
% L_i = ???
% %vector indexing can’t start at zero, so go from 1 to n+1
% for k = 1 : n + 1
% if k ~= i
% %Don’t forget to define L_i symbolically so that you
% % can do the integral exactly later...
% L_i = ??? .* L_i;
% end
% end
% Li_int = int( ???, xs, ???, ??? );
% intval = intval + ???;
% end
% err( j ) = abs( ??? );
% end
% %plot error
% figure(100)
% semilogy( nvect, err, ’k.’, ’markersize’, 26 )

% SETUP

% declare another symbolic
syms x
