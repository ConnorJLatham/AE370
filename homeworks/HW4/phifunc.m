function [phi] = phifunc(endp,k)
% define the k = 0 case
if k == 0
    phi = 1/innerproduct(endp,1,1);
end
% define the k = 1 case
if k == 1
    phi =@(x) x-innerproduct(endp,x,1)/innerproduct(endp,1,1);
end
% define the k > 1 case
if k > 1
    phi =@(x) x*phifunc(endp,k-1)-...
        (innerproduct(endp,x*phifunc(endp,k-1),phifunc(endp,k-1))/innerproduct(endp,phifunc(endp,k-1),phifunc(endp,k-1)))*phifunc(endp,k-1)...
        -(innerproduct(endp,x*phifunc(endp,k-1),phifunc(endp,k-2))/innerproduct(endp,phifunc(endp,k-2),phifunc(endp,k-2)))*phifunc(endp,k-2);
end