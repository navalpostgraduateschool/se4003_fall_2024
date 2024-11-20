classdef LaserB < Laser
    % LaserB subclass with specific properties

    properties
        OutputPower = 100;   % in kW
        ChargeTime = 15;      % in seconds
        Wavelength = 1.07;    % in micrometers
        DischargeRate = 1;    % in seconds
        NumBatteries = 5;     % number of batteries
        Range = 10;           % in km
    end

    methods
        % Override the fire method to implement specific firing behavior for LaserB
        function fire(obj)
            disp('Laser B firing...');
            % Example: Update the marker position or perform a firing animation
            obj.markerHandle.XData = obj.markerHandle.XData + 2;  % Move marker more than LaserA
            obj.markerHandle.YData = obj.markerHandle.YData + 2;  % Move marker more than LaserA
        end
        
        % Override the follow method to implement specific following behavior for LaserB
        function follow(obj, targetX, targetY)
            disp(['Laser B following target at: (', num2str(targetX), ', ', num2str(targetY), ')']);
            % Example: Update the marker's position to follow the target
            obj.markerHandle.XData = targetX;
            obj.markerHandle.YData = targetY;
        end
    end
end
