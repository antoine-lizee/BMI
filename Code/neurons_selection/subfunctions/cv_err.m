function [ err ] = cv_err( e_stack_a )
%CV_ERR Summary of this function goes here
%   Detailed explanation goes here

err=sqrt(mean((mean(e_stack_a,1)).^2,3))/9; % Compute performance for each angle, then add squares.

end

