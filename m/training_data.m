function [ Xs, Ys ] = training_data(radius, step, spacing)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

angles = 0:spacing:pi;
angles = [angles fliplr(-angles)];
steps = 0:step:radius;

nangles = length(angles) - 1; %go to -1 of this
nsteps = length(steps);

Xs = zeros(3, (nangles * nsteps));
Ys = zeros(2, (nangles * nsteps));

for j = 1:nangles
    
   angle = angles(j);
    
   for i = 1:nsteps
       
      x = steps(i) * cos(angle);
      y = steps(i) * sin(angle);
      
      train = [x y angle];
      Xs(:, ((j*nsteps) + i)) = train;
      [v, w] = lyapgtg(train);
      Ys(:, ((j*nsteps) + i)) = [v w]';
   end
end
end

