clc;
% Given values
ra = 7000;
mu = 398600;

% Define the objective function
objective_function = @(rb, rc) abs(sqrt((2*mu)/ra - mu/((ra+rb)/2)) - sqrt(mu/ra)) + ...
                           abs(sqrt((2*mu)/rb - mu/((rb+rc)/2)) - sqrt((2*mu)/rb - mu/((ra+rb)/2))) + ...
                           abs(sqrt((2*mu)/rc - mu/((rb+rc)/2)) - sqrt(mu/rc)) ...
                           - (abs(sqrt((2*mu)/ra - mu/((ra+rc)/2)) - sqrt(mu/ra)) + ...
                              abs(sqrt(mu/rc) - sqrt((2*mu)/rc - mu/((ra+rc)/2))));

% Define range of rc values
rc_values = linspace(11.94*ra, 15.58*ra, 1e4); % Adjust the range as needed
rc1 = linspace(0,30,1e4);

y=rc1;

% Initialize array to store rb solutions
rb_solutions = zeros(size(rc_values));

% Iterate over rc values and find corresponding rb solutions
for i = 1:numel(rc_values)
    % Initial guess for rb
    rb_initial_guess = 119000;
    
    % Solve for rb using fzero
    rb_solution = fzero(@(rb) objective_function(rb, rc_values(i)), rb_initial_guess);
    
    

    % Store rb solution
    rb_solutions(i) = rb_solution;
end
y_x_values = linspace(0, 30, numel(rc_values_orig));
% Plot rc/ra vs. rb/ra
figure;
plot(rc_values/ra, rb_solutions/ra,'k', 'LineWidth', 2);

hold on


xlabel('r_C/r_A');
ylabel('r_B/r_A');
title('Hohmann Transfer vs Bielliptic Transfer');
xlim([0,30]);
ylim([0,100]);

% Graph y/x function
plot(rc1, rc1,'k', 'LineWidth',2);


% Fill area from 0 to the curve bounded by y/x
fill([0, rc_values_orig/ra, rc_values_orig(end)/ra], ...
     [0, rb_solutions_orig/ra, rb_solutions_orig(end)/ra], 'r', 'FaceAlpha', 0.5);

% Fill the area from the curve to rc/ra = 30 bounded by y/x
fill([rc_values_orig/ra, 30], ...
     [rb_solutions_orig/ra, 30], 'g', 'FaceAlpha', 0.7);

% Fill the area under the y/x curve
area([0, 30], [0, 30], 'FaceColor', 'blue', 'FaceAlpha', 0.3)

% Text for Bielliptic Transfer region
txt = {'Hohmann Transfer','more efficient'};
text(6,50,txt,"HorizontalAlignment","center");

% Text for Hohmann Transfer region
txt2 = {'Bielliptic Transfer','more efficient'};
text(20,50,txt2,"HorizontalAlignment","center");

txt3 = {'r_B = r_C \rightarrow'};
text(20,26,txt3);

% Text related to the asymptote at rc/ra = 11.94
txt4 = {'r_C/r_A = 11.94 \rightarrow'};
text(5.4,20,txt4);
xline(11.94,'--','LineWidth',2);

% Text related to the line at rc/ra = 15.58
y_stop = 15.5964; % Set the y value where the line will stop
line([15.58, 15.58], [0, y_stop],'Color', 'b', 'LineStyle', '--','LineWidth',2);
txt5 = {'\leftarrow r_C/r_A = 15.58'};
text(15.7,8,txt5);

% Text for v_BE = v_H
txt7 = {'\leftarrow \Deltav_{BE} = \Deltav_H'};
text(12.5,81,txt7);


hold off