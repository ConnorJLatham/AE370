%% HW3 Problem 1
clear all, close all, clc
% given function
f = @(x) 1./(1+x.^2);
% endpoints
endp = [-5,5];
% number of cubic splines
n = [5 10 25 50];
% fineness of plot
fine = 1000;
% create the for loop to iterate through spline number
for a=1:length(n)
    % set some ni = n(i) 
    na = n(a);
    % make the interpolation points
    intpoints = interp_Maker(endp,na,'eq');
    % initialize the A and f matrix (f is the function evaluated at the
    % points and other conditions
    A = zeros(4*na); % A matrix, 4n x 4n
    g = zeros(4*na,1); % f matrix, represents my grade, 
    % for loop for filling out the two matrices
    for b = 1:na
        % the index that fills out the matrices
        ind = 4*(b-1)+1;
        % first row, from the 3rd condition
        A(ind,ind) = (1/6)*(intpoints(b)-intpoints(b+1)).^2;
        A(ind,ind+1) = 0;
        A(ind,ind+2) = intpoints(b);
        A(ind,ind+3) = 1;
        g(ind) = f(intpoints(b));
        % second row, from the 4th condition
        A(ind+1,ind) = 0;
        A(ind+1,ind+1) = (1/6)*(intpoints(b+1)-intpoints(b)).^2;
        A(ind+1,ind+2) = intpoints(b+1);
        A(ind+1,ind+3) = 1;
        g(ind+1) = f(intpoints(b+1));
        if b < na
            % third row, from condition 5, f=0 for all
            A(ind+2,ind) = 0;
            A(ind+2,ind+1) = (1/2)*(intpoints(b+1)-intpoints(b));
            A(ind+2,ind+2) = 1;
            A(ind+2,ind+3) = 0;
            A(ind+2,ind+4) = (-1/2)*(intpoints(b+1)-intpoints(b+2));
            A(ind+2,ind+5) = 0;
            A(ind+2,ind+6) = -1;
            A(ind+2,ind+7) = 0;
            % fourth row, condition 6, f=0 for all
            A(ind+3,ind) = 0;
            A(ind+3,ind+1) = 1;
            A(ind+3,ind+2) = 0;
            A(ind+3,ind+3) = 0;
            A(ind+3,ind+4) = -1;
            A(ind+3,ind+5) = 0;
            A(ind+3,ind+6) = 0;
            A(ind+3,ind+7) = 0;
        else
            % s_1''(x_0) = 0
            A(ind+2,1) = 1;
            A(ind+2,2) = 0;
            A(ind+2,3) = 0;
            A(ind+2,4) = 0;
            % s_n''(x_n) = 0
            A(ind+3,ind) = 0;
            A(ind+3,ind+1) = 1;
            A(ind+3,ind+2) = 0;
            A(ind+3,ind+3) = 0;
        end
        % row three and four, equal to zero since they are subtracting
        g(ind+2) = 0;
        g(ind+3) = 0;
    end
    % solve for the coefficients with matrix left division
    coeffs = A \ g;
    % make points to evaluate at
    points = linspace(min(endp),max(endp),fine);
    % initialize the matrix for values of S at each point
    S = zeros(size(points));
    for c = 1:na
        ind = 4*(c-1)+1;
        indxx = (points>=intpoints(c) & points<=intpoints(c+1));
        xxc = points(indxx ~=0);
        S(indxx~=0) = coeffs(ind)*(xxc-intpoints(c+1)).^3/(6*(intpoints(c)-intpoints(c+1)))+...
            coeffs(ind+1)*(xxc-intpoints(c)).^3/(6*(intpoints(c+1)-intpoints(c)))+...
            coeffs(ind+2)*xxc+coeffs(ind+3); %GOTTA SMAAASH;)
    end
    if a <= 4
        figure(a)
        plot( points, f(points), 'b-', 'linewidth', 2 ), hold on
        plot( points, S, 'r--', 'linewidth', 2 )
        plot( intpoints, f(intpoints), 'k.', 'markersize', 16 )
        %make plot pretty
        title( ['$n = ', num2str( n(a) ),'$'] ,'interpreter', 'latex',...
        'fontsize', 16)
        xlabel( '$x$', 'interpreter', 'latex', 'fontsize', 16)
        h = legend( '$f(x)$', '$S(x)$', '$f(x_j)$');
        set(h, 'location', 'NorthWest', 'Interpreter', 'Latex', 'fontsize', 16 )
        set(gca, 'TickLabelInterpreter','latex', 'fontsize', 16 )
        set(gcf, 'PaperPositionMode', 'manual')
        set(gcf, 'Color', [1 1 1])
        set(gca, 'Color', [1 1 1])
        set(gcf, 'PaperUnits', 'centimeters')
        set(gcf, 'PaperSize', [15 15])
        set(gcf, 'Units', 'centimeters' )
        set(gcf, 'Position', [0 0 15 15])
        set(gcf, 'PaperPosition', [0 0 15 15])
        svnm = ['pic_', num2str(a)];
        print( '-dpdf', svnm, '-r200' )
    end
end
    
