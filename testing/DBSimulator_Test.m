% Test Script for DBSimulator

% Clear workspace and console
clear;
clc;

disp('Starting test for DBSimulator...');

% Step 1: Create a mock laser controller as a struct and GUI axes
disp('Creating mock laser controller and GUI axes...');
laserController = createLaserController(); % Function to create the mock laser controller
figureHandle = figure('Name', 'Test GUI', 'NumberTitle', 'off'); % Create a test figure
axisHandle = axes(figureHandle); % Create test axes in the figure

% Step 2: Instantiate the simulator
disp('Instantiating DBSimulator...');
simulator = DBSimulator(laserController, axisHandle); % Correctly use DBSimulator class

% Step 3: Initialize components
disp('Initializing components...');
simulator.initializeSwarmController();
simulator.initializeLaserController();
simulator.clearAxes();

% Verify initialization
disp('Verifying initialization...');
assert(~isempty(simulator.swarmController.UAVs), 'Swarm controller did not initialize UAVs.');

% Step 4: Run the simulation with limited iterations
disp('Running simulation...');
iterationLimit = 5; % Limit the number of iterations for testing
iterationCount = 0;

while simulator.swarmController.hasUAVs() && ~simulator.laserController.hasFailed()
    simulator.swarmController.update();
    simulator.visualize();
    pause(0.1);
    iterationCount = iterationCount + 1;
    
    if iterationCount >= iterationLimit
        disp('Reached iteration limit. Stopping simulation.');
        break;
    end
end

% Step 5: Verify updates
disp('Verifying simulation updates...');
assert(iterationCount > 0, 'Simulation did not run any iterations.');
assert(~isempty(simulator.swarmController.getUAVPositions()), 'UAV positions are empty after updates.');

% Step 6: Clean up
disp('Cleaning up...');
close(figureHandle);

disp('Test completed successfully.');
