function [val] = innerproduct(endp,func1,func2)
% set the bounds of the integral
a = endp(1);
b = endp(2);
% integrate the symbolic function
val = integral(@(x)func1(x).*func2(x),a,b);
end