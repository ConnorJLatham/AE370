function [lagFunc] = lag_Func(n, fvals)
    % this function creates the data for the lagrange basis functions. It
    % creates 'n+1' functions. The interval points are defined by the
    % 'range' and 'n+1'. The fineness is determind by 'm' allows the basis 
    % functions to be graphed along
    % the range in a nice manner. 'n' is an integer, 'rang'e is the
    % bounding points in a array, and 'm' is the number of points to plot
    % on through the 'range'
    
    int = n;
    lagFunc = @(x) 0;
    for i=1:length(int)
        lagFunci = @(x) 1;
        for k=1:length(int)
            % if j ==  i, then num and den are just one again
            if i~=k
                lagFunci = @(x) lagFunci(x)*(x-int(k))/(int(i)-int(k));
            end
        end
        lagFunc = @(x) lagFunc(x) + fvals(i)*lagFunci(x);
    end
end
