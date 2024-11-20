% startLaserApp.m

% Get the current directory
currentDir = fileparts(mfilename('fullpath'));

% Add all subfolders to the MATLAB path using addPaths
addPaths(currentDir);

% Path to the DuckShooter app
appFile = fullfile(currentDir, 'figures', 'duckShooterApp.mlapp');

% Run the application if the file exists
if isfile(appFile)
    run(appFile);
else
    error('The application file "%s" could not be found.', appFile);
end
