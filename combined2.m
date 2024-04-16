clc;
% Given values
ra = 7000; % periapsis radius (km)
mu = 398600; % gravitational parameter of Earth (km^3/s^2)

% Define range of rc/ra values
rc_ra_values = linspace(0, 100, 1000); % adjust the range as needed

% Define different rb/ra ratios
rb_ra_ratios = [5, 11.94, 14, 15.58, 20, 30, inf]; % adjust as needed

% Initialize arrays to store vbe/v1a and vh/v1a values for each rb/ra ratio
vbe_v1a_values_all = zeros(numel(rb_ra_ratios), numel(rc_ra_values));


% Calculate vh/v1a and vbe/v1a for each rb/ra ratio and rc/ra value
for j = 1:numel(rb_ra_ratios)
    % Initialize array to store vbe/v1a values for current ratio
    vbe_v1a_values = zeros(size(rc_ra_values));
    
    % Calculate vbe/v1a for each rc/ra value
    for i = 1:numel(rc_ra_values)
        % Calculate rb and rc using rb/ra and rc/ra ratios
        rb = rb_ra_ratios(j) * ra;
        rc = rc_ra_values(i) * ra;

        % Calculate vbe using the given formula
        vbe = (abs(sqrt((2*mu)/ra - mu/((ra+rb)/2)) - sqrt(mu/ra)) + ...
              abs(sqrt((2*mu)/rb - mu/((rb+rc)/2)) - sqrt((2*mu)/rb - mu/((ra+rb)/2)))) + ...
              abs(sqrt((2*mu)/rc - mu/((rb+rc)/2)) - sqrt(mu/rc));

        % Calculate v1a using the given formula
        v1a = sqrt(mu/ra);

        % Calculate vbe/v1a ratio
        vbe_v1a_values(i) = vbe / v1a;
    end
    
    % Store vbe/v1a values for current ratio
    vbe_v1a_values_all(j, :) = vbe_v1a_values;

end


vh_v1a_values = zeros(size(rc_ra_values));
filtered_rc_ra_values = [];

% Calculate vh/v1a for each rc/ra value and filter values >= 0.2 and rc/ra >= 1.59
for i = 1:numel(rc_ra_values)
    % Calculate vh using the given formula
    vh = (abs(sqrt((2*mu)/ra - mu/((ra+rc_ra_values(i)*ra)/2)) - sqrt(mu/ra)) + ...
          abs(sqrt(mu/(rc_ra_values(i)*ra)) - sqrt((2*mu)/(rc_ra_values(i)*ra) - mu/((ra+rc_ra_values(i)*ra)/2))));
    
    % Calculate v1a using the given formula
    v1a = sqrt(mu/ra);
    
    % Calculate vh/v1a ratio
    vh_v1a_ratio = vh / v1a;
    
    % Check if vh/v1a ratio is >= 0.2 and rc/ra is >= 1.59
    if vh_v1a_ratio >= 0.1 && rc_ra_values(i) >= 1.59
        vh_v1a_values(i) = vh_v1a_ratio;
        filtered_rc_ra_values = [filtered_rc_ra_values, rc_ra_values(i)];
    end
end

% Plot vh/v1a vs rc/ra for filtered values
figure;
plot(filtered_rc_ra_values, vh_v1a_values(vh_v1a_values >= 0.1), 'k-', 'LineWidth', 2);
xlabel('r_C/r_A');
ylabel('\Deltav/v_A');
title('Hohmann vs Bielliptic');
legend('Location', 'southeast');
grid on;
xlim([0,100]);
ylim([0.2,0.8]);

hold on

for j = 1:numel(rb_ra_ratios)
    plot(rc_ra_values, vbe_v1a_values_all(j, :), '-', 'LineWidth', 2, 'DisplayName', sprintf('vbe/v1a, rb/ra = %d', rb_ra_ratios(j)));
end
hold off;

txt = {'r_B/r_A = 5'};
text(40,0.73,txt);

txt2 = {'11.94'};
text(60,0.69,txt2);

txt3 = {'Hohmann'};
text(80,0.52,txt3,"HorizontalAlignment","center");

y_stop = 15.5964; % Set the y value where the line will stop
line([15.58, 15.58], [0, y_stop],'Color', 'k', 'LineStyle', '--','LineWidth',1);
txt5 = {'\leftarrow r_C/r_A = 15.58'};
text(15.7,.4,txt5);

y_stop = 11.94; % Set the y value where the line will stop
line([11.94, 11.94], [0, y_stop],'Color', 'k', 'LineStyle', '--','LineWidth',1);
txt7 = {'\leftarrow r_C/r_A = 11.94'};
text(12,.3,txt7);