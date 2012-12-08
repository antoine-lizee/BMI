function [ param ] = getparam( act_neur, method )
%GETPARAM Summary of this function goes here
%   Detailed explanation goes here


switch method
    case{'gauss', 'binom','gamma','mixte'}
        param=getparam_LL(act_neur, method);
    case 'cos'
        param=getparam_cos(act_neur, method);
    case 'cos135'
        param=getparam_cos135(act_neur, method);
    case 'kgauss'
        param=getparam_kernel(act_neur, method);
    case 'multi'
        param=getparam_multi(act_neur, method);
end

end

