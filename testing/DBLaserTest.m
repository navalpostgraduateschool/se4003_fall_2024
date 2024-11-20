% Test Script for Laser Controller
% This script tests the functionality of the Laser Controller with LaserA and LaserB

clear;
clc;

% Define test parameters (can select LaserA or LaserB)
laserChoice = 'LaserB';  % Set to 'LaserA' or 'LaserB' for testing

% Dynamically create the laser object based on the laserChoice string
switch laserChoice
    case 'LaserA'
        laserObj = DBLaserA();  % Dynamically create instance of LaserA
    case 'LaserB'
        laserObj = DBLaserA();  % Dynamically create instance of LaserB
    otherwise
        error('Invalid laser choice. Please select either LaserA or LaserB.');
end

% Create a simple GUI with axis for visualization
figure;
ax = axes('Parent', gcf);
axis([0 20 0 20]);
hold on;

% Create a marker to represent laser position (just as a point for now)
laserMarker = plot(ax, 10, 10, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');  % Position at (10, 10)

% Set the handles in the laser object
laserObj.setHandles(ax, laserMarker);

% Display Laser Details
disp('---- Laser Details ----');
laserObj.displayLaserDetails();

% Test the 'Fire' method: Fire the laser (move marker)
disp('Firing the laser...');
laserObj.fire();
pause(1);  % Pause for a second to visualize the change

% Test the 'Follow' method: Make the laser follow a target
targetX = 15;
targetY = 15;
disp(['Making the laser follow target at: (', num2str(targetX), ', ', num2str(targetY), ')']);
laserObj.follow(targetX, targetY);
pause(1);  % Pause for a second to visualize the change

% Test the 'Fire' method again: Fire the laser again
disp('Firing the laser again...');
laserObj.fire();
pause(1);  % Pause for a second to visualize the change

% Test the 'Follow' method with another target
targetX = 18;
targetY = 5;
disp(['Making the laser follow a new target at: (', num2str(targetX), ', ', num2str(targetY), ')']);
laserObj.follow(targetX, targetY);
pause(1);  % Pause for a second to visualize the change

disp('Test complete!');
