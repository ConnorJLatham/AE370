%% AE370 HW2 Jan. 27, 2018
%% P1a
clc
clear
% set up the n's we want and the chosen range
n = [3 6 12 24 48 96];
range = [0,1];
% Call the function to find out the condition numbers for a monomial basis
linConNum = vpa(linConNums(n,range))
% Call the function to find out the condition numbers for the lagrange
% basis
lagConNum = vpa(lagConNums(n,range))

%% P1b1
clear
clc
% set up the givens
n = 5;
range = [0,1];
fineness = 100;
% get the data for the plots
monoData = monoPlot2(n,range,fineness);
% create the plot range 
plotrange = linspace(range(1),range(2),fineness);
% plot the data
figure(); hold on
for i = 1:n+1
    plot(plotrange,monoData(i,:),'linewidth',1.75);
end
hold off
title('Six Monomial Basis Functions Evaluated from 0 to 1')
xlabel('x')
ylabel('f(x)')
legend('x^0','x^1','x^2','x^3','x^4','x^5','location','northwest');
%% P1b2
clear
clc
% given
n = 5;
% define some range
range = [0,1];
% number of points to plot on
fineness = 1000;
% call the lagrange function to find this stuff
lagData = lagPlot3(n,range,fineness);
% create the points that everything is being evaluated at
plotrange = linspace(range(1),range(2),fineness);
% plot
figure(); hold on
for i = 1:n+1
    plot(plotrange,lagData(i,:),'linewidth',1.75);
end
hold off
title('Six Lagrange Basis Functions Evaluated from 0 to 1')
xlabel('x')
ylabel('L(x)')
legend('L0','L1','L2','L3','L4','L5','location','northeastoutside');
%% P2a
clear
clc
% given function
f = @(x) 1/(1+x.^2);
% define range
range = [-5,5];
% define the vector of the # of points we want
n = [5 10 15 20];
% define some 'fineness' of the mesh we are plotting over and make the mesh
fine = 1000;
evalrange = linspace(range(1),range(2),fine);
%call the function to get the data
pdata = linPolyMaker1(n,range,fine,f)
% plot the data
hold on
for i = 1:length(n)
    plot(evalrange,pdata(i,:),'linewidth',1.75);
end
%plot the given func
fplot(f,range,'linewidth',1.75)
ylim([-.25,1.25]);
hold off
title('Lagrange Polynomial Interpolants for Various n')
xlabel('x')
ylabel('Pn(x)')
legend('Pn for n = 5','Pn for n = 10','Pn for n = 15','Pn for n = 20','Given f(x)','location','northeastoutside');
%% P2b
clear
clc

% given function
f = @(x) 1/(1+x.^2);
% define range
range = [-5,5];
% define the vector of the # of points we want
n = [5 10 15 20];
% define some 'fineness' of the mesh we are plotting over
fine = 1000;
% create the mesh
evalrange = linspace(range(1),range(2),fine);
% get the data
pdata = chebPolyMaker1(n,range,fine,f);
% plot the data
hold on
for i = 1:length(n)
    plot(evalrange,pdata(i,:),'linewidth',1.75);
end
ylim([-.25,1.25]);
fplot(f,range,'linewidth',1.75)
hold off
title('Lagrange Polynomial Interpolants for Various n')
xlabel('x')
ylabel('Pn(x)')
legend('Pn for n = 5','Pn for n = 10','Pn for n = 15','Pn for n = 20','Given f(x)','location','northeastoutside');

%% 2c
clear
clc
% set n, create range, and mesh fineness
n = 10;
range = [-3,3];
fineness = 1000;
% create the equispaced points
xeq = linspace(range(1),range(2),n+1);
% create the chebyshev points
xcheb = chebSpace([range(1),range(2)],n);\
% find the max for both sets of interp points by calling prodDiff
maxeq = prodDiff(range,xeq,fineness)
maxcheb = prodDiff(range,xcheb,fineness)
%% Functions

% Problem 1a
function [linConNum] = linConNums(nvec,range)
% linConNums finds the condition numbers of monomial basis matrix
k = 1;
    % iterates through all the n values, creates a equally space set of
    % points, fills the A matrix out, then evaluates condition number
    while k < length(nvec)+1
        n = nvec(k);
        int = linspace(range(1),range(2),n+1);
        A = zeros(length(int),length(int));
        i = 1;
        j = 1;
        while i < size(int,2) + 1
            while j < length(int) + 1
                A(i,j) = int(i)^(j-1);
                j = j+1;
            end
            i = i+1;
            j = 1;
        end
        linConNum(k) = cond(A);
        k = k+1;
    end
end
% p1a
function [lagConNum] = lagConNums(nvec,range)
% lagConNums finds the condition numbers of lagrangian basis
k = 1;
    % simply iterates through, but it is all 1
    while k < length(nvec)+1
        n = nvec(k);
        int = linspace(range(1),range(2),n+1);
        A = eye(length(int),length(int));
        lagConNum(k) = cond(A);
        k = k+1;
    end
end

% p1b
function [monoPlotData] = monoPlot2(n,range,m)
% creates the data for the monomial basis
    range = linspace(range(1),range(2),m);
    for i=1:n+1
        for j=1:length(range)
            monoPlotData(i,j) = range(j)^(i-1);
        end
    end
end
% p1b
function [lagPlotData] = lagPlot3(n,range,m)
    % this function creates the data for the lagrange basis functions. It
    % creates 'n+1' functions. The interval points are defined by the
    % 'range' and 'n+1'. The fineness is determind by 'm' allows the basis 
    % functions to be graphed along
    % the range in a nice manner. 'n' is an integer, 'rang'e is the
    % bounding points in a array, and 'm' is the number of points to plot
    % on through the 'range'
    
    % set up the interval, n+1 evenly spaced points
    int = linspace(range(1),range(2),n+1);
    % set up 'm' # of points to evaluate at 
    range = linspace(range(1),range(2),m);
    for i=1:length(int)
        f = @(x) 1;
        % iterate through the 6 points
        for k=1:length(int)
            % if j ==  i, then num and den are just one again
            if i~=k
                f = @(x) f(x)*(x-int(k))/(int(i)-int(k));
            end
        end
        % once the function is made, iterate through the 1000 points and
        % store them
        for j=1:length(range)
%                 lagPlotData(i,j) = subs(num,x,range(j))/subs(den,x,range(j));
            lagPlotData(i,j) = f(range(j));
        end
    end
end

% p2a
function [polyPlotData] = linPolyMaker1(n,range,m,f)
    % this function creates the polynomial interpolant and evaluates it for
    % the points on the range
    
    % set up 'm' # of points to evaluate the interpolant at 
    evalrange = linspace(range(1),range(2),m);
    % set up the parent for loop to iterate through the different n's
    for i = 1:length(n)
    % create the interpolation points and the polynomial interpolant
    % function
    int = linspace(range(1),range(2),n(i)+1);
    Pn = @(x) 0;
    % for loop that builds the interpolant
        for j=1:length(int)
            % create a scalar for the basis
            d = f(int(j));
            % create the unit lagrange basis
            L = @(x) 1;
            % iterate through the 6 points
            for k=1:length(int)
                % if j ==  i, then num and den are just one again
                if j~=k
                % build the lagrange basis function
                L = @(x) L(x)*(x-int(k))/(int(j)-int(k));
                end
            end
            % append the lagrange basis function to the total interpolant
            Pn = @(x) Pn(x) + d*L(x);
        end
        for d=1:length(evalrange)
            polyPlotData(i,d) = Pn(evalrange(d));
        end
    end
end

function [polyPlotData] = chebPolyMaker1(n,range,m,f)
    % this function creates the polynomial interpolant and evaluates it for
    % the points on the range
    
    % set up 'm' # of points to evaluate the interpolant at 
    evalrange = linspace(range(1),range(2),m);
    % set up the parent for loop to iterate through the different n's
    for i = 1:length(n)
    % create the interpolation points and the polynomial interpolant
    % function
    int = chebSpace(range,n(i)+1);
    Pn = @(x) 0;
    % for loop that builds the interpolant
        for j=1:length(int)
            % create a scalar for the basis
            d = f(int(j));
            % create the unit lagrange basis
            L = @(x) 1;
            % iterate through the 6 points
            for k=1:length(int)
                % if j ==  i, then num and den are just one again
                if j~=k
                % build the lagrange basis function
                L = @(x) L(x)*(x-int(k))/(int(j)-int(k));
                end
            end
            % append the lagrange basis function to the total interpolant
            Pn = @(x) Pn(x) + d*L(x);
        end
        for d=1:length(evalrange)
            polyPlotData(i,d) = Pn(evalrange(d));
        end
    end
end

function [chebPoints] = chebSpace(range,n)
    for i=1:n+1
        chebPoints(i) = -(max(range)-min(range))*cos((i-1)*pi/n)/2;
    end
end

function [maximum] = prodDiff(range,points,fine)
range = linspace(range(1),range(2),fine);
for i=1:length(range)
    prodDiffMat(i) = 1;
    for j=1:length(points)
        prodDiffMat(i) = prodDiffMat(i)*(range(i)-points(j));
    end
end
maximum = max(prodDiffMat);
end