clc;
% Given values
ra = 7000; % periapsis radius of initial circular orbit (km)
rb = 210e3;
rc = (ra*70.0701);% apoapsis radius of final circular orbit (km)
mu = 398600; % gravitational parameter of Earth (km^3/s^2)

% Calculate velocities at periapsis and apoapsis
va = abs(sqrt((2*mu)/ra - mu/((ra+rb)/2)) - sqrt(mu/ra)); % velocity at periapsis
vb = abs(sqrt((2*mu)/rb - mu/((rb+rc)/2)) - sqrt((2*mu)/rb - mu/((ra+rb)/2))); % velocity at apoapsis
vc = abs(sqrt((2*mu)/rc - mu/((rb+rc)/2)) - sqrt(mu/rc)); % velocity at intermediate orbit

% Calculate intermediate orbit radii for maximum efficiency
at1 = (ra+rb)/2;
at2 = (rb+rc)/2;

% Calculate velocities at intermediate orbits
et1 = (rb-ra)/(rb+ra); % eccentricity for transfer orbit 1
et2 = (rb-rc)/(rb+rc); % eccentricity for transfer orbit 2

% Generate angles for plotting
% theta = linspace(0, pi, 100);
% 
% r_transfer = at1 * (1 - et1^2) ./ (1 + et1 * cos(theta));
% x_transfer = r_transfer .* cos(theta);
% y_transfer = r_transfer .* sin(theta);
% plot(x_transfer, y_transfer, 'g');

theta2 = linspace(0, 2*pi, 100);
x_c = rc * cos(theta2);
y_c = rc * sin(theta2);
x_a = ra * cos(theta2);
y_a = ra * sin(theta2);
plot(x_c, y_c, 'b', x_a, y_a, 'r');
hold on;

theta_transfer = linspace(0, pi, 100);
rt1 = at1 * (1 - et1^2) ./ (1 + et1 * cos(theta_transfer));
x_transfer = rt1 .* cos(theta_transfer);
y_transfer = rt1 .* sin(theta_transfer);
plot(x_transfer, y_transfer, 'g');

tt2 = linspace(pi, 2*pi, 100);
rt2 = at2 * (1 - et2^2) ./ (1 + et2 * cos(tt2));
x_transfer2 = rt2 .* cos(tt2);
y_transfer2 = rt2 .* sin(tt2);
plot(x_transfer2, y_transfer2, 'k');

center = [0, 0];  % Center of the circle (x, y)
radius = 6378;       % Radius of the circle

% Generate points for the circle
theta = linspace(0, 2*pi, 100);
x_circle = center(1) + radius * cos(theta);
y_circle = center(2) + radius * sin(theta);
fill(x_circle, y_circle, 'b');
hold off

yline(0,'--');


axis equal;

% Set labels and title
xlabel('x (km)');
ylabel('y (km)');
title('Bielliptic Hohmann Transfer Orbit');
legend('Final Orbit','Initial Orbit', 'Transfer Orbit1','Transfer Orbit 2', 'Earth', 'Location', 'northwest');
grid on;

text(rb*cos((3*pi)/4), 0, sprintf('r_B = %d km', rb), 'HorizontalAlignment', 'center');
text(0, ra*sin((3*pi)/2), sprintf('r_A = %d km', ra), 'HorizontalAlignment', 'center');
text(0, rc*sin((3*pi)/2), sprintf('r_C = %f km', rc), 'HorizontalAlignment', 'center');