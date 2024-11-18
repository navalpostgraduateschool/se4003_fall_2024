classdef (Abstract) Laser
    % Abstract class for Laser with common properties

    properties (Abstract)
        OutputPower       % Output power of the laser
        ChargeTime        % Charge time of the laser (seconds)
        Wavelength        % Wavelength of the laser (micrometers)
        DischargeRate     % Discharge rate of the laser (seconds)
        NumBatteries      % Number of batteries
        Range             % Range of the laser (km)
    end
    
    methods
        % Abstract methods could be added here if needed, for example:
        % function fireLaser(obj)
        %     % Implementation to fire laser
        % end
        
        % A general method to display laser details
        function displayLaserDetails(obj)
            disp('Laser Specifications:');
            disp(['Output Power: ', num2str(obj.OutputPower), ' kW']);
            disp(['Charge Time: ', num2str(obj.ChargeTime), ' sec']);
            disp(['Wavelength: ', num2str(obj.Wavelength), ' micrometers']);
            disp(['Discharge Rate: ', num2str(obj.DischargeRate), ' sec']);
            disp(['Number of Batteries: ', num2str(obj.NumBatteries)]);
            disp(['Range: ', num2str(obj.Range), ' km']);
        end
    end
end
