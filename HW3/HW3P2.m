%% HW3 Problem 2 
clear all, close all, clc
% given endpoints
endp = [0,2*pi];
% number of splines
n = [5,25,50];
% fineness of plot
fine = 1000;
%% Part A
% make the function to interp
f = @(x) exp(cos(x)+sin(3*x));
% set up for loop to go through the different n's
for a=1:length(n)
    % define what n is
    na = n(a);
    % create the equispaced interpolation points
    intpoints = double(interp_Maker(endp,2*na,'trig'))
    % obtain the coefficients from the fast fourier transform
    feval = double(f(intpoints));
    % perform the fast fourier transform
    coeffs = (1/(2*na+1))*fft(feval);
    % rearrange the coeffs 
    cbot = coeffs(1:na+1);
    ctop = coeffs(na+2:2*na+1);
    coeffs2 = [ctop cbot]
    clear cbot ctop coeffs
    % create the set of points to plot over
    points = linspace(min(endp),max(endp),fine);
    % create the linspace for making the function
    expos = linspace(-na,na,2*na+1)
    % create the function
    g = @(x) 0;
    for b=1:2*na+1
        g = @(x) g(x)+coeffs2(b)*exp(1i*x*expos(b));
    end
    evalpoints = g(points);
   % if a <= 4
figure(a)
        plot( points, f(points), 'b-', 'linewidth', 2 ), hold on
        plot( points, evalpoints, 'r--', 'linewidth', 2 )
        plot( intpoints, f(intpoints), 'k.', 'markersize', 16 )
        %make plot pretty
        title( ['$n = ', num2str( n(a) ),'$'] ,'interpreter', 'latex',...
        'fontsize', 16)
        xlabel( '$x$', 'interpreter', 'latex', 'fontsize', 16)
        h = legend( '$f(x)$', '$S(x)$', '$f(x_j)$');
        set(h, 'location', 'NorthEast', 'Interpreter', 'Latex', 'fontsize', 16 )
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
%% Part B
% make the function to interp
f = @(x) x;
% set up for loop to go through the different n's
for a=1:length(n)
    % define what n is
    na = n(a);
    % create the equispaced interpolation points
    intpoints = double(interp_Maker(endp,2*na,'trig'))
    % obtain the coefficients from the fast fourier transform
    feval = double(f(intpoints));
    % perform the fast fourier transform
    coeffs = (1/(2*na+1))*fft(feval);
    % rearrange the coeffs 
    cbot = coeffs(1:na+1);
    ctop = coeffs(na+2:2*na+1);
    coeffs2 = [ctop cbot]
    clear cbot ctop coeffs
    % create the set of points to plot over
    points = linspace(min(endp),max(endp),fine);
    % create the linspace for making the function
    expos = linspace(-na,na,2*na+1)
    % create the function
    g = @(x) 0;
    for b=1:2*na+1
        g = @(x) g(x)+coeffs2(b)*exp(1i*x*expos(b));
    end
    evalpoints = g(points);
   % if a <= 4
figure(a)
        plot( points, f(points), 'b-', 'linewidth', 2 ), hold on
        plot( points, evalpoints, 'r--', 'linewidth', 2 )
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

