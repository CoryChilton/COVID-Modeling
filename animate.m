%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% animate
% Final Project Problem 2
% 
% animate: a function that shows the change in the ratio of susceptible,
% infected, and recovered individuals in the grid as an image.
% Inputs:
%     X: an M*N*3*length(t) matrix, where each point in the M*N space
%         corresponds to a single grid with 3 numbers between 0 and 1 
%         showing the SIR result. this 3D matrix is repeated for each time 
%         step making it a 4D matrix.
% Output: 
%     This function has no outputs
%
% Cory Chilton
% 605388291
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function animate(X)

[~,~,~,T] = size(X); % Finds total number of time steps
colors = zeros(size(X)); % Preallocates colors array
colors(:,:,1,:) = X(:,:,2,:); % red for infected
colors(:,:,2,:) = X(:,:,3,:); % green for recovered
colors(:,:,3,:) = X(:,:,1,:); % blue for susceptible
colors(1,1,1,:) = X(1,1,1,:); % time steps added to colors

% Create animation
for t = 1:T % for all the time steps
    if mod(t,10) == 0 % if it is a tenth time step
        image(colors(:,:,:,t)); % Display the colors array
        pause(.1); % Pause for .1 seconds
    end
    
end

end