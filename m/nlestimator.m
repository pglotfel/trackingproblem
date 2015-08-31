function [ Y ] = nlestimator(Xs, Ys, sigma, X)
%UNTITLED2 A non-linear estimator based on the Specht paper.
%   A general regression non-linear estimator

    [n, m] = size(Ys);

    result = zeros(n, m);
    temp = zeros(1, m);  

    for i = 1:m 
        temp(i) = exp(-(((X - Xs(:, i))' * (X - Xs(:, i))) / (2 * sigma^2)));
    end

    for i = 1:m
       result(:, i) = Ys(:, i) * temp(i);
    end
    
    Y = sum(result, 2) / sum(temp);   
end

