%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% myPCA
% Final Project Problem 1
% 
% Analyzes the principal components of given COVID-19 statistical data from
% multiple countries
% Inputs:
%     data: A nxp matrix representing only the numerical parts of the
%        dataset
% Outputs:
%     coeffOrth: a pxp matrix whose columns are the eigenvectors
%        corresponding to the sorted eigenvalues
%     pcaData: a nxp matrix representing the data projected onto the
%        principal components.
%
% Cory Chilton
% 605388291
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [coeffOrth,pcaData] = myPCA(data)

n = numel(data(:,1)); % Stores the number of rows in data
p = numel(data(1,:)); % Stores the number of cols in data

% Step 1: Normalizing data
normalizedData = zeros(n,p); % Preallocate array to store the normalized data
for i = 1:p
    normalizedData(:,i) = (data(:,i) - mean(data(:,i))) / std(data(:,i)); % Makes normalizedData by subtracting the mean and then dividing each row by the standard deviation
end

% Step 2: Covariance Matrix Computation
C = cov(normalizedData); % uses cov function to make covariance matrix from normalizedData

% Step 3: Compute eigenvectors and eigenvalues
[eigenvectors,eigenvaluesDiag] = eig(C); % Uses eig function to compute the eigenvectors and get a matrix where the eigenvalues are on the diagonal
eigenvalues = zeros(1,p); % Preallocates eigenvalues array
for j = 1:p 
    eigenvalues(j) = eigenvaluesDiag(j,j); % Makes eigenvalues to be 1D and hold only eigenvalues in a straight line instead of on a diagonal
end


% Step 4: Keeping Principal Components
coeffOrth = zeros(p); % Preallocates coeffOrth as a pxp matrix
% Use ~ because the sorted eigenvalues are not used (~ used to be
% eigenvalues)
[~,indexes] = sort(abs(eigenvalues),'descend'); % Sorts eigenvalues in descending order and returns how the indexes are switched around
for k = 1:p
    coeffOrth(:,k) = eigenvectors(:,indexes(k)); % Uses the index order of the eigenvalues to reorder the eigenvectors from largest to smallest eigenvalue
end                                               % which is then assigned to coeffOrth


% Step 5: Converting normalized data

pcaData = normalizedData * coeffOrth; % projects normalized data onto the coeffOrth matrix

end