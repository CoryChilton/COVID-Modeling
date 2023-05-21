%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% solveSpatialSIR
% Final Project Problem 2
% 
% solveSpatialSIR Solves the spatial SIR model
% Inputs:
%     tFinal: end time for the simulation (assuming start is t=0)
%     initialCondition: a MxNx3 matrix that sums to 1 in third dimension
%     alpha, beta, gamma: model parameters
%     odeSolver: a function handle for an ode45-compatible solver
% Outputs:
%     t: a vector of the time-steps
%     x: MxNx3xlength(t) matrix representing the state vs. time
%
% Cory Chilton
% 605388291
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [t, x] = solveSpatialSIR(tFinal, initialCondition, alpha, ...
beta, gamma, odeSolver)

tspan = [0 tFinal]; % Setting tspan based on the tFinal input and assuming time starts at 0
M = numel(initialCondition(:,1,1)); % Figuring out number of rows from initialCondition
N = numel(initialCondition(1,:,1)); % Figuring out number of cols from intialCondition

dSIRdt = @(t,y) dynamicsSIR(y, M, N, alpha, beta, gamma); % Creates a function handle that only takes a t and a y so that it can be used in the odeSolver

[t,x] = odeSolver(dSIRdt,tspan,initialCondition); % Solves the spatial SIR model using odeSolver
% Right now x is vectorized in rows with each row being a time step
x = reshape(x',M,N,3,length(t)); % Reshapes because the return is MxNx3xlength(t) 
                                    % use x' because reshape does things columnwise

end