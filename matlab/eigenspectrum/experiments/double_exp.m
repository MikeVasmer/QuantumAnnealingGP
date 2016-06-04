function [ y ] = double_exp( x, a, b, c,d )
%DOUBLE_EXP Summary of this function goes here
%   Detailed explanation goes here

y = a*exp(x-d).^2+b*exp(x-d)+c;

end

