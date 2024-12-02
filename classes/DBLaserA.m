classdef DBLaserA < DBLaser
    % LaserA subclass with specific properties
    properties(Constant)
        LINE_PROPERTIES = struct('color','blue',...
            'linestyle','none',...
            'marker', 'v',...
            'markerSize', 10,...
            'markerFaceColor', [0.2 0.4 0.8],...
            'markerEdgeColor', [0.8, 0.8 0.8],...
            'xdata',0,...
            'ydata',0);
    end

    properties(SetAccess=protected)
        outputPower = 60;    % in kW
        chargeTime = 10;      % in seconds
        wavelength = 1.07;    % in micrometers
        dischargeRate = 1;    % in seconds
        numBatteries = 3;     % number of batteries
        maxRange = 50;        % in km
        maxTemperature = 80;  % in celsius
        coolDownRate = 20;
    end

    methods
        % Override the fire method to implement specific firing behavior for LaserA
        % function fire(obj)
        %     disp('Laser A firing...');
        %     % Example: Update the marker position or perform a firing animation
        %     obj.markerHandle.XData = obj.markerHandle.XData + 1;  % Move marker as an example
        %     obj.markerHandle.YData = obj.markerHandle.YData + 1;  % Move marker as an example
        % end
        
        % Override the follow method to implement specific following behavior for LaserA
        function follow(obj, targetX, targetY)
            disp(['Laser A following target at: (', num2str(targetX), ', ', num2str(targetY), ')']);
            % Example: Update the marker's position to follow the target
            obj.markerHandle.XData = targetX;
            obj.markerHandle.YData = targetY;
        end
    end

    methods(Static)
        function description = getDescription()
            description = 'Laser model A';
        end
    end
end
