function [intpoints] = interp_Maker(endpoints, n, type)
if strcmp(type,'trig')
    for i=1:n+1
       intpoints(i) = min(endpoints)+((max(endpoints)-min(endpoints))*(i-1))/(n+1); 
    end
end
if strcmp(type,'ch')
    for i=1:n+1
        intpoints(i) = -(max(endpoints)-min(endpoints))*cos((i-1)*pi/n)/2;
    end
end
if strcmp(type,'eq')
    for i=1:n+1
        intpoints(i) = min(endpoints)+(max(endpoints)-min(endpoints))*(i-1)/(n);
    end
end
end