% Test Script for DBUAV_Engine

% Clear workspace and command window
clear; clc;

% Test Parameters
numPredators = 5;  % Number of DBPredator instances
numQuads = 3;      % Number of DBQuad instances
numIterations = 50; % Number of simulation iterations

% Create a figure and axes for the simulation
fig = figure('Name', 'DBUAV Engine Test', 'NumberTitle', 'off', 'Position', [100, 100, 800, 600]);
ax = axes('Parent', fig, 'Position', [0.1, 0.1, 0.8, 0.8]);
xlim(ax, [0, 10]);
ylim(ax, [0, 10]);
title(ax, 'DBUAV Simulation');
xlabel(ax, 'X');
ylabel(ax, 'Y');
grid(ax, 'on');

% Create DBUAV_Engine instance
uavEngine = DBUAV_Engine(numPredators, numQuads, ax);

% Run the simulation
disp('Starting DBUAV Simulation...');
uavEngine.run(numIterations);
disp('Simulation complete.');

% End of script
