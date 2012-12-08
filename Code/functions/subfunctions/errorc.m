function [ e ea ] = errorc( a_test, a_giv )
%ERRORC Summary of this function goes here
%   Detailed explanation goes here

e=(a_test~=a_giv);
ea=a_test-a_giv;
ea=ea+(ea<0)*8;

end

