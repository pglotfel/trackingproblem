


dt = 0.1;

robot_pose = [0 0 0]';
goal = [-0.5 0.5 0]';
diff = [0 0 0]';

n = 50000; 

robot_history = zeros(2, n);
v_history = zeros(1, n);
w_history = zeros(1, n);


for i = 1:n 
    
robot_history(:, i) = [robot_pose(1) robot_pose(2)];
    
diff = goal - robot_pose;
theta_desired = atan2(diff(2), diff(1)) - robot_pose(3);
diff(3) = atan2(sin(theta_desired), cos(theta_desired));

[v, w] = lyapgtg(diff);

v_history(i) = v;
w_history(i) = w;

robot_pose(1) = robot_pose(1) + dt * (v * cos(robot_pose(3)));
robot_pose(2) = robot_pose(2) + dt * (v * sin(robot_pose(3)));
robot_pose(3) = robot_pose(3) + dt * w;
%robot_pose(3) = atan(sin(robot_pose(3))/cos(robot_pose(3)));

end

%Use non-linear estimator.  Second experiment!

clf

figure(1)

plot(robot_history(1, :), robot_history(2, :));

% figure(2)
% 
% plot(v_history)
% 
% figure(3)
% 
% plot(w_history)


%SECOND EXPERIMENT

robot_pose = [0 0 0]';
goal = [-0.5 0.5 0]';
diff = [0 0 0]';

robot_history_nl = zeros(2, n);
v_history = zeros(1, n);
w_history = zeros(1, n);

%Get some samples...

[Xs, Ys] = training_data(1, 0.1, pi / 6);

for i = 1:(n)
    
    robot_history_nl(:, i) = [robot_pose(1) robot_pose(2)];
    
    diff = goal - robot_pose;
    theta_desired = atan2(diff(2), diff(1)) + diff(3); %goal - robot pos
    diff(3) = atan2(sin(theta_desired), cos(theta_desired));

    next = nlestimator(Xs, Ys, 0.8, diff);
    v = next(1);
    w = next(2);
    
    v_history(i) = v;
    w_history(i) = w;
    
    robot_pose(1) = robot_pose(1) + dt * (v * cos(robot_pose(3)));
    robot_pose(2) = robot_pose(2) + dt * (v * sin(robot_pose(3)));
    robot_pose(3) = (robot_pose(3) + dt * w);
    %robot_pose(3) = atan(sin(robot_pose(3)) / cos(robot_pose(3)));

end

figure(4)

plot(robot_history_nl(1, :), robot_history_nl(2, :));

normr = zeros(1, n);

for i = 1:n
   normr(i) = norm(robot_history(:, i) - robot_history_nl(:, i)); 
end

figure(5)

plot(normr)
% figure(5) 
% 
% plot(v_history)
% 
% figure(6)
% 
% plot(w_history)




