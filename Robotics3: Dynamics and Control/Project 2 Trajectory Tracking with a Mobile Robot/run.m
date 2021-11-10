% simulate system
t_stop = 18;
[t, robot_path] = ode45(@controller, [0 t_stop], [0 0 0]');

% compute maximum error while painting
[max_error, max_idx] = compute_trajectory_error(t, robot_path);
disp(['Maximum error while painting: ' num2str(max_error) ' m']);

% plot results
visualize_robot_path(robot_path);
