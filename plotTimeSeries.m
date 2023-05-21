%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plotTimeSeries
% Final Project Problem 2
% 
% plotTimeSeries: a function that plots and saves the local S.I.R 
% distribution at spatial coordinate (x, y).
% Inputs:
%     t: a vector of time steps
%     X: an M*N*3*length(t) matrix, where each point in the M*N space 
%         corresponds to a local S.I.R. model with states whose values are 
%         between 0 and 1. This 3D matrix is repeated for each time step, 
%         making it a 4D matrix.
%     x: the spatial x-coordinate on the grid
%     y: the spatial y-coordinate on the grid
% Outputs:
%     This function has no outputs
%
% Cory Chilton
% 605388291
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plotTimeSeries(t, X, x, y)

% Split X up into it's components to be plotted
% Each compenent is then vectorized so that it can be plotted
S = X(x,y,1,:); % x,y in the front plane
S = S(:); 
I = X(x,y,2,:); % x,y in the middle plane
I = I(:);
R = X(x,y,3,:); % x,y in the back plane
R = R(:);

% Customized pointer that kinda looks like dry bones when you move your
% mouse over the figure
% NaN is transparent, 1 is black, 2 is white
z = NaN;
drybones =    [z z z z z z z z z z z z z z z z; ...
               z z z z z z z z z z z z z z z z; ...
               z z z z 2 2 2 2 2 2 2 2 z z z z; ...
               z z z z 2 1 1 2 2 1 1 2 z z z z; ...
               z z z z 2 1 1 2 2 1 1 2 z z z z; ...
               z z z z 2 1 1 2 2 1 1 2 z z z z; ...
               z z z z 2 1 1 2 2 1 1 2 z z z z; ...
               z 2 2 2 2 1 1 2 2 1 1 2 2 2 2 z; ...
               z 2 1 2 2 2 2 2 2 2 2 2 2 1 2 z; ...
               z 2 1 1 2 2 2 1 1 2 2 2 1 1 2 z; ...
               z 2 2 1 1 1 2 2 2 2 1 1 1 2 2 z; ...
               z z 2 2 2 1 1 1 1 1 1 2 2 1 2 z; ...
               z z z z 2 2 2 2 2 2 1 1 2 1 2 z; ...
               z z z z z z z z z 2 2 1 1 1 2 z; ...
               z z z z z z z z z z 2 2 2 2 2 z; ...
               z z z z z z z z z z z z z z z z];
         
% Create new figure with the custom pointer
h1 = figure('Pointer', 'custom', 'PointerShapeCData', drybones);

% Plot each S, I, and R, all on the same figure using subplot
subplot(3,1,1)
plot(t, S, 'b', 'Linewidth', 2) % Plots S
% Aesthetics, labels and title
grid on;
xlabel('Time (s)');
ylabel('Susceptible (%)')
xlim([0,60])
title('Percent of Population Susceptible to Virus Over Time')

subplot(3,1,2)
plot(t, I, 'r', 'Linewidth', 2) % Plots I
% Aesthetics, labels and title
grid on;
xlabel('Time (s)');
ylabel('Infected (%)')
xlim([0,60])
title('Percent of Population Infected by Virus Over Time')

subplot(3,1,3)
plot(t, R, 'g', 'Linewidth', 2) % Plots R
% Aesthetics, labels and title
grid on;
xlabel('Time (s)');
ylabel('Recovered (%)')
xlim([0,60])
title('Percent of Population Recovered from Virus Over Time')

% Creates a title at the very top of the figure that says the coordinates
sgtitle(sprintf('SIR Model at Position (%d,%d)',x,y))

% Saves the figure with the specific coordinates
saveas(h1,sprintf('time_series_%d_%d.png', x, y));


end