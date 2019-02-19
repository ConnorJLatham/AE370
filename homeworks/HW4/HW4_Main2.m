%% AE370 HW4
%% Problem 2
clear, clc

% set up interval endpoints
endp = [-5,5];
% set up mesh fineness
m = 1000;
% set up points to evaluate at
X = linspace(endp(1),endp(2),m);
% set up the function symbolically
func = @(x) 1./(1+x.^2);
% set up the n array
n = [5 10 25 50];
% make a for loop for iterating through n
for i=1:length(n)
    % set the value of n for the iteration
    ni = n(i);
    % evaluate phihat0
    phi0hat = 1./trapz(X,ones(size(X)));
    % evaluate phi0
    phi0 = phi0hat/sqrt(trapz(X,phi0hat^2*ones(size(X))))*ones(size(X));
    % evaluate phi1hat
    phi1hat = X-(trapz(X,X)/trapz(X,ones(size(X))));
    % evaluate phi1
    phi1 = phi1hat./sqrt(trapz(X,phi1hat.^2));
    % assign these to a matrix to store the values of the basis functions
    % at each point
    basisvals = [phi0;phi1];
    % create a for loop that evaluates for the other basis functions up to
    % n
    for j = 3:ni+1
        % write out the long recursive function for hat{phi_{n}}
        phihat = X.*basisvals(j-1,:)-...
            trapz(X,X.*basisvals(j-1,:).*basisvals(j-1,:)).*basisvals(j-1,:)./...
            trapz(X,basisvals(j-1,:).*basisvals(j-1,:))-...
            trapz(X,X.*basisvals(j-1,:).*basisvals(j-2,:)).*basisvals(j-2,:)./...
            trapz(X,basisvals(j-2,:).*basisvals(j-2,:));
        % solve for phi
        phi = phihat/sqrt(trapz(X,phihat.^2));
        % add this to the next row in the basis values matrix
        basisvals(j,:) = phi(1,:);
    end
    % create the "A" matrix (or G, or whatever)
    A = [];
    % create a for loop to fill out each spot in the A matrix
    for row = 1:ni+1
        for column = 1:ni+1
            % do the inner product, approximated by a trapezoidal
            % integration along X
            A(row,column) = trapz(X,basisvals(row,:).*basisvals(column,:));
        end
    end
    % get rid of tiny components in A, so that it actually looks like the
    % identity matrix as found in 2b, (rounding to 10 digits)
    A = round(A,10);
    % create the "b" matrix
    b = [];
    % iterate through and solve the values in b, approximating with trapz
    % again, not rounding because we know A should be the ID matrix
    for row = 1:ni+1
        b(row) = trapz(X,basisvals(row,:).*func(X));
    end
    % solve for c using left division
    c = A \ b';
    % set up a for loop to sum up all the bases multiplied by their
    % coefficients, initialize Pn first though
    Pn = 0;
    for k = 1:ni+1
        Pn = Pn + c(k)*basisvals(k,:)
    end
    % plotting stuff
    figure(i)
    plot( X, func(X), 'b-', 'linewidth', 2 ), hold on
    plot( X, Pn, 'r--', 'linewidth', 2 )
    %make plot pretty
    title( ['$n = ', num2str( n(i) ),'$'] ,'interpreter', 'latex',...
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
    svnm = ['2B_', num2str(ni)];
    print( '-dpdf', svnm, '-r200' )
end
        