classdef DBLaserJSON < DBLaser
    properties (SetAccess=protected)
        outputPower       % Output power of the laser
        chargeTime        % Charge time of the laser (seconds)
        wavelength        % Wavelength of the laser (micrometers)
        dischargeRate     % Discharge rate of the laser (seconds)
        numBatteries      % Number of batteries
        maxRange          % Range of the laser (km)
        maxTemperature    % Maximum operating temperature
        coolDownRate      % Cooling rate (degrees C per second)
    end

    methods
        % Constructor to initialize from JSON file
        function obj = DBLaserJSON(jsonFilePath, labelIndex)
            % Load JSON data
            jsonData = jsondecode(fileread(jsonFilePath));
            
            % Extract the specific laser data
            if ~isfield(jsonData, 'DirectedEnergyWeapons')
                error('The JSON file does not contain a DirectedEnergyWeapons field.');
            end
            laserData = jsonData.DirectedEnergyWeapons(labelIndex);

            % Map JSON data to class properties
            obj.outputPower = parsePower(laserData.power_output);
            obj.chargeTime = 10; % Default or compute if available
            obj.wavelength = 1.07; % Default or compute if available
            obj.dischargeRate = 1; % Default or compute if available
            obj.numBatteries = 3; % Default or compute if available
            obj.maxRange = parseRange(laserData.range);
            obj.maxTemperature = 80; % Default or compute if available
            obj.coolDownRate = 20; % Default or compute if available
        end
    end
end

% Helper function to parse power
function power = parsePower(powerStr)
    if contains(powerStr, 'kW')
        power = str2double(regexp(powerStr, '\d+', 'match', 'once'));
    else
        error('Unsupported power format.');
    end
end

% Helper function to parse range
function range = parseRange(rangeStr)
    if contains(rangeStr, 'NM')
        range = str2double(regexp(rangeStr, '\d+', 'match', 'once')) * 1.852; % Convert NM to km
    elseif contains(rangeStr, 'km')
        range = str2double(regexp(rangeStr, '\d+', 'match', 'once'));
    else
        range = NaN; % Default for classified or unsupported ranges
    end
end
