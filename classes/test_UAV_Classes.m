% Test Script for DBPredator and DBQuad Classes with Custom Markers

% Clear workspace and command window
clear; clc;

% Test Parameters
numPredators = 3; % Number of DBPredator instances
numQuads = 2;     % Number of DBQuad instances
numIterations = 20; % Number of updates for testing
xLimits = [0, 10]; % X-axis limits for bounding
yLimits = [0, 10]; % Y-axis limits for bounding

% Create a figure and axes for the test
fig = figure('Name', 'UAV Class Test', 'NumberTitle', 'off', 'Position', [100, 100, 800, 600]);
ax = axes('Parent', fig, 'Position', [0.1, 0.1, 0.8, 0.8]);
xlim(ax, xLimits);
ylim(ax, yLimits);
title(ax, 'UAV Class Test');
xlabel(ax, 'X');
ylabel(ax, 'Y');
grid(ax, 'on');
hold(ax, 'on');

% Initialize DBPredator instances
predators = arrayfun(@(~) DBPredator(rand(1, 2) * 10, rand(1, 2) * 0.5), 1:numPredators);

% Initialize DBQuad instances
quads = arrayfun(@(~) DBQuad(rand(1, 2) * 10, rand(1, 2) * 0.5), 1:numQuads);

% Simulation Loop
disp('Starting UAV Class Test...');
for iter = 1:numIterations
    % Clear the axes for redrawing
    cla(ax);

    % Update and plot DBPredator instances
    for i = 1:numel(predators)
        predators(i).update();
        % Plot predators as red triangles
        scatter(ax, predators(i).position(1), predators(i).position(2), 100, 'r', '^', 'filled');
        hold(ax, 'on');
    end

    % Update and plot DBQuad instances
    for i = 1:numel(quads)
        quads(i).update();
        % Plot quads as blue squares
        scatter(ax, quads(i).position(1), quads(i).position(2), 100, 'b', 's', 'filled');
        hold(ax, 'on');
    end

    % Set axis limits and redraw
    xlim(ax, xLimits);
    ylim(ax, yLimits);
    drawnow;
    pause(0.1); % Adjust speed for better visualization
end

disp('UAV Class Test complete.');

% End of script
