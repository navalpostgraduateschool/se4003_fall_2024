function addPaths(rootDir)
    % addPaths - Adds all subfolders of the specified directory to the MATLAB path
    %
    % Inputs:
    %   rootDir - The root directory whose subfolders will be added to the path
    %
    % Example:
    %   addPaths(pwd)

    if nargin < 1
        rootDir = pwd; % Default to the current directory if no input provided
    end
    
    % Add all subfolders to MATLAB path
    addpath(genpath(rootDir));
end
