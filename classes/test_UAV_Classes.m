% Test Script for DBUAV_Engine

% Clear workspace and command window
clear; clc;

% Create a figure and axes for plotting
figure;
axesHandle = axes('Position', [0.1, 0.1, 0.8, 0.8]);

% Define number of UAVs
numPredators = 5; % Number of DBPredator instances
numQuads = 3;     % Number of DBQuad instances

% Initialize the DBUAV_Engine with the number of predators, quads, and axes
uavEngine = DBUAV_Engine(numPredators, numQuads, axesHandle);

% Run the simulation for 50 iterations
numIterations = 50; % Number of simulation iterations
disp('Running DBUAV simulation...');

% Call the run method to start the simulation
uavEngine.run(numIterations);

% End of test script
disp('Test complete.');
