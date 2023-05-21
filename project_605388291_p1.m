%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main
% Final Project Problem 1
% Loads the provided covid_countries.csv data, then calls the myPCA
% function with this data, and uses the output of the myPCA function to
% make a biplot that helps us visualize the two principle component
% eigenvectors and the data that was projected onto the vector subspace.
%
% Cory Chilton
% 605388291
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; clc; close all;

% Step 1: Load the provided covid_countries.csv
covid_countries_table = readtable('covid_countries.csv', ...
    'VariableNamingRule', 'preserve');

% Step 2: Call your myPCA function with the loaded data
[coeffOrth,pcaData] = myPCA(covid_countries_table{:,3:end}); % Calling myPCA with the loaded data; Uses {} because we want to just take data from the table

% Step 3: Uses the biplot function to visualize the first two principle
% component eigenvectors and the projected data onto this 2D vector
% subspace

categories = {'Infections', 'Deaths', 'Cures', 'Mortality Rate', ...
    'Cure Rate', 'Infection Rate'}; % Header titles from the table that will be used as labels in the biplot
                                        % Uses {} because it is a cell array with strings of different lengths

h1 = figure(1); % Opens new figure
biplot(coeffOrth(:,1:2), 'Scores', pcaData(:,1:2), 'Varlabels', categories); % Plots the data required using the biplot function with categories labels
box on; % Aesthetic
title('myPCA of Covid Countries Data'); % Adds title

saveas(h1, 'Final_Project_biplot.png'); % Save to use in report



