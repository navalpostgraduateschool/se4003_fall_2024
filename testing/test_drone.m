% Filepath to the JSON file (ensure the JSON file is in your working directory or provide the full path)
jsonFilePath = '../data/drone_specs.json';

% Specify the label of the drone you want to initialize
droneLabel = 'QuadCopter';

% Instantiate the subclass with the JSON data and label
try
    % Create the drone object
    predatorDrone = DBDroneFromJSON(jsonFilePath, droneLabel);

    % Display results to confirm successful initialization
    disp('Drone Initialized Successfully!');
    disp("Drone Label: " + droneLabel);
    disp("Max Speed: " + predatorDrone.MaxSpeed); % Dynamically loaded max speed
    disp("Armor: " + predatorDrone.armor);
catch ME
    % Display error message if something goes wrong
    disp("Error: " + ME.message);
end
