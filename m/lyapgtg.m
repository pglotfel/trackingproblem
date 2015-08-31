function [v w] = lyapgtg(diff)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

%xdiff, ydiff, tdiff

dist = sqrt(diff(1)^2 + diff(2)^2);

v = dist * cos(diff(3));
w = dist * sin(diff(3));

end

