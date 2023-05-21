%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RK4
% Final Project Problem 2
% 
% RK4 Numerically solves the differential equation using the fourth-order 
% Runge-Kutta algorithm
% Inputs:
%     f: function handle of f(t, y)
%     tspan: the time period for simulation (should be a 1x2 array  
%         containing start time and end time)
%     y0: the initial conditions for the differential equation
% Outputs:
%     t: corresponding time sequence as a T x 1 vector
%     y: the solution of the differential equation as a T x n matrix, where 
%         T is the number of time steps and n is the dimension of y
%
% Cory Chilton
% 605388291
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [t, y] = RK4(f, tspan, y0)

% Initializing variables, setting constants, and preallocating
h = 0.1; % Step size
nSteps = (tspan(2) - tspan(1)) / h + 1; % Total number of steps
t0 = tspan(1); % Starting time
t = zeros(nSteps,1); % Preallocating the time array
t(1) = t0; % Setting the first value of the time array to starting time
n = numel(y0); % Setting n to number of elements in y0 
y = zeros(nSteps, n); % Preallocating the y array
y(1,:) = y0(:)'; % Setting the first row of y to y0 (y0 is a column so we need ' to make it a row
k = 2; % Initializing k: Starts at 2 because index one is already set and the while loop goes up to nSteps

% Filling y using the fourth order runge kutta method
% Follows the pseudocode written in the problem statement
while k <= nSteps
    k1 = h .* f(t(k-1),y(k-1,:));
    k2 = h .* f(t(k-1) + h/2, y(k-1,:) + (k1(:)./2)'); % Uses ' because k1 is a column vector when it is returned from f and we want it to be a row.
    k3 = h .* f(t(k-1) + h/2, y(k-1,:) + (k2(:)./2)');  % Continue to use ' for the same reason
    k4 = h .* f(t(k-1) + h, y(k-1,:) + k3(:)');
    t(k) = t(k-1) + h; % filling t
    y(k,:) = y(k-1,:) + (k1(:)' + 2 .* k2(:)' + 2 .* k3(:)' + k4(:)')./6; % filling y
    k = k + 1;
end
end