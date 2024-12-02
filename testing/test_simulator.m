% Test Script for DBSimulator

% Clear workspace and console
clear;
clc;

disp('Starting test for DBSimulator...');

% use our method to create and initialize an axes handle.
% axisHandle = initAxes();

% Create the simulator and such
sim = DBSimulator();
droneLocation = [50,50];
disp('Setting drone location to:')
disp(droneLocation);
pause(0.5);
shouldReset = true;
sim.dronesController.setLocation(droneLocation, shouldReset);

disp('Setting number of drones to 4');
pause(0.5);
sim.setNumDrones(4);
sim.dronesController.reset();

disp('Setting to predator drones');
pause(0.5);
sim.setDroneType('predator');

disp('Setting laser type to A');
pause(0.5);
sim.setLaserType('A');
disp('Setting laser type to B');
pause(0.5);
sim.setLaserType('B');
disp('Moving laser controller to [-2, 0]');
pause(0.5);
sim.laserController.setPosition([-2,0]);

disp('Demo run');
sim.demo_run();
