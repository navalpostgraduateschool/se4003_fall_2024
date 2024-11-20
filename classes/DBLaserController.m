% Laser Selection Script
% Choose which laser to create (LaserA or LaserB)

laserChoice = 'LaserB';  % Set 'LaserA' or 'LaserB' here to select laser type

% Dynamically create the laser object based on the laserChoice string
switch laserChoice
    case 'LaserA'
        laserObj = DBLaserA();  % Dynamically create instance of LaserA
    case 'LaserB'
        laserObj = DBLaserB();  % Dynamically create instance of LaserB
    otherwise
        error('Invalid laser choice. Please select either LaserA or LaserB.');
end

% Display Laser Details
laserObj.displayLaserDetails();

% Create a simple GUI with axis for visualization
figure;
ax = axes('Parent', gcf);
axis([0 20 0 20]);
hold on;

% Create a marker to represent laser position (just as a point for now)
laserMarker = plot(ax, 10, 10, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');  % Position at (10, 10)

% Set the handles in the laser object
laserObj.setHandles(ax, laserMarker);

% Example: Fire the laser
laserObj.fire();

% Example: Follow a target position
laserObj.follow(15, 15);  % Move to (15, 15)
