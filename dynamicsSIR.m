%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dynamicsSIR
% Final Project Problem 2
% 
% Computes the rate of change of the model
% Inputs:
%     x: vectorized state
%     M, N: size of the grid
%     alpha, beta, gamma: model parameters
% Output:
%     dxdt: vectorized time derivative of state
%
% Cory Chilton
% 605388291
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dxdt = dynamicsSIR(x, M, N, alpha, beta, gamma)

grid = reshape(x,M,N,3); % Start by reshaping the grid to make it easier to work with

S = grid(:,:,1); % Susceptible: initalized to front plane of grid
I = grid(:,:,2); % Infected: initialized to middle plane of grid    
% R = grid(:,:,3); % Recovered: initialized to back plane of grid   (Unused)

dSdt = zeros(M,N); % Preallocating S rate of change
dIdt = zeros(M,N); % Preallocating I rate of change
dRdt = zeros(M,N); % Preallocating R rate of change

% Need to run through all of the points in the grid and calculate the rate
% of change
for xx = 1:N
    for yy = 1:M
        % Calculate sumWI: the weighting function that describes the
        % proximity of nearby neighbors
        
        sumWI = 0; % Initializes sumWI
        % Is increased based o nthe neighbors of the current box, also
        % treats boxes on the edge or corner accordingly (boxes not on the
        % grid count as 0)
        if xx > 1 % Left box
            sumWI = sumWI + I(yy,xx-1);
        end
        if yy > 1 % Bottom box
            sumWI = sumWI + I(yy-1,xx);
        end
        if xx < N % Right box
            sumWI = sumWI + I(yy,xx+1);
        end
        if yy < M % Top box
            sumWI = sumWI + I(yy+1,xx);
        end
        if xx > 1 && yy < M % Top left box
            sumWI = sumWI + (1/sqrt(2)) * I(yy+1,xx-1);
        end
        if xx < N && yy < M % Top right box
            sumWI = sumWI + (1/sqrt(2)) * I(yy+1, xx+1);
        end
        if xx < N && yy > 1 % Bottom right box
            sumWI = sumWI + (1/sqrt(2)) * I(yy-1,xx+1);
        end
        if xx > 1 && yy > 1 % Bottom left box
            sumWI = sumWI + (1/sqrt(2)) * I(yy-1,xx-1);
        end
        
        % Calculate derivatives at every point
        % Uses equations 4-6 in the problem statement and uses the sumWI we
        % calculated above
        dSdt(yy,xx) = -1 * (beta * I(yy,xx) + alpha * sumWI) * S(yy,xx);
        dIdt(yy,xx) = (beta * I(yy,xx) + alpha * sumWI) * S(yy,xx) ...
            - gamma * I(yy,xx);
        dRdt(yy,xx) = gamma * I(yy,xx);
    end
end

dxdt = zeros(M,N,3); % Preallocates dxdt
% Fill each plane of dxdt
dxdt(:,:,1) = dSdt; % Front plane is dSdt
dxdt(:,:,2) = dIdt; % Middle plane is dIdt
dxdt(:,:,3) = dRdt; % Back plane is dRdt
dxdt = dxdt(:); % Vectorizes dxdt because that is what this function is supposed to return
end