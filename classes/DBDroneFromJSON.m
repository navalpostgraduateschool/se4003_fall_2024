classdef DBDroneFromJSON < DBDrone
    properties
        JSONSourceFile % Path to the JSON file
        DroneLabel % The root-level label in the JSON for this drone
        MAX_VELOCITY % Maximum velocity (dynamic)
    end
    
    properties (Constant)
        MAX_ARMOR = 100; % Default armor value
    end
    
    methods
        % Constructor
        function obj = DBDroneFromJSON(jsonFilePath, droneLabel)
            obj.JSONSourceFile = jsonFilePath;
            obj.DroneLabel = droneLabel;
            obj.initializeFromJSON();
        end
        
        % Initialize from JSON
        function initializeFromJSON(obj)
            % Load and parse JSON file
            try
                jsonData = jsondecode(fileread(obj.JSONSourceFile));
            catch ME
                error('Error reading JSON file: %s', ME.message);
            end
            
            % Validate label
            if ~isfield(jsonData, obj.DroneLabel)
                error('Label ''%s'' not found in JSON file.', obj.DroneLabel);
            end
            
            % Extract data for the specified label
            droneData = jsonData.(obj.DroneLabel);
            
            % Assign properties
            if isfield(droneData, 'MaxSpeed')
                obj.MAX_VELOCITY = droneData.MaxSpeed.max; % Use max speed
            end
            if isfield(droneData, 'Material')
                disp('Material information:');
                disp(droneData.Material.description);
            end
            if isfield(droneData, 'LaserBurnThroughTime')
                disp('Laser burn-through time info:');
                disp(droneData.LaserBurnThroughTime);
            end
            
            % Initialize armor
            obj.armor = obj.MAX_ARMOR;
        end
    end
end
