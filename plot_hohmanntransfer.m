function plot_hohmanntransfer(rb,ra)
% Define constants
mu = 398600;

a = (ra+rb)/2;
%za = ra-6378;
%zb = rb-6378;

% Calculate velocities
vb = abs(sqrt(mu/rb) - sqrt(mu*((2/rb)-(1/a)))); % Velocity in final orbit
va = abs(sqrt(mu*((2/ra)-(1/a)))-sqrt(mu/ra)); %Velocity in initial orbit

% Plot circular orbits
theta = linspace(0, 2*pi, 100);
x_b = rb * cos(theta);
y_b = rb * sin(theta);
x_a = ra * cos(theta);
y_a = ra * sin(theta);
plot(x_b, y_b, 'b', x_a, y_a, 'r');
hold on;

% Plot transfer orbit
rp = rb;  % Periapsis radius of transfer orbit (same as initial orbit)
rap = ra;  % Apoapsis radius of transfer orbit (same as final orbit)
a_transfer = (rp + rap) / 2;  % Semi-major axis of transfer orbit
e_transfer = (rap - rp) / (rap + rp);  % Eccentricity of transfer orbit

% Calculate transfer orbit points
theta_transfer = linspace(0, pi, 100);
r_transfer = a_transfer * (1 - e_transfer^2) ./ (1 + e_transfer * cos(theta_transfer));
x_transfer = r_transfer .* cos(theta_transfer);
y_transfer = r_transfer .* sin(theta_transfer);
plot(x_transfer, y_transfer, 'g');

% Define center and radius of the circle
center = [0, 0];  % Center of the circle (x, y)
radius = 6378;       % Radius of the circle

% Generate points for the circle
theta = linspace(0, 2*pi, 100);
x_circle = center(1) + radius * cos(theta);
y_circle = center(2) + radius * sin(theta);

% Plot the filled circle
fill(x_circle, y_circle, 'b');  % Fill the circle with blue color

% Set aspect ratio
axis equal;
%plot(0, 0, 'k.', 'MarkerSize', 20); % Black dot at the center

% Add labels and legend
xlabel('X-axis (km)');
ylabel('Y-axis (km)');
title('Hohmann Transfer Orbit');
legend('Initial Orbit', 'Final Orbit', 'Transfer Orbit', 'Earth', 'Location', 'northwest');

text(rb*cos(0), 0, sprintf('r_C = %d km', rb), 'HorizontalAlignment', 'center');
text(0, ra*sin((3*pi)/2), sprintf('r_A = %d km', ra), 'HorizontalAlignment', 'center');


% Set equal aspect ratio
axis equal;

% Hold off to end plotting
hold off;