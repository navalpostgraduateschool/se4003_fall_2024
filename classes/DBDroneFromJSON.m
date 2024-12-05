classdef DBDroneFromJSON < DBDrone
    properties
        JSONSourceFile % Path to the JSON file
        DroneLabel % The root-level label in the JSON for this drone
        MaxSpeed % Dynamically loaded max speed from JSON
    end
    
    properties (Constant)
        LINE_PROPERTIES = struct('color','green',...
            'linestyle','none',...
            'marker', 'v',...
            'markerSize', 12,...  % Size = 100; % Marker size for visualization
            'markerFaceColor', [0.2, 0.8, 0],...
            'markerEdgeColor', [0.1, 0.1 0.1],...
            'xdata',0,...
            'ydata',0);

        MAX_ARMOR = 100;
        MAX_VELOCITY = 1000; % Keep this as a constant to match the parent class definition
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
                obj.MaxSpeed = droneData.MaxSpeed.max; % Store max speed in a new property
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
      methods(Static)
        function description = getDescription()
            description = 'Custom Drone';
        end

    end
end
