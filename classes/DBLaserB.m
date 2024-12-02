classdef DBLaserB < DBLaser
    % LaserB subclass with specific properties
    properties(Constant)
        LINE_PROPERTIES = struct('color',[0 1 1],...
            'linestyle','none',...
            'marker', 'd',...
            'markerSize', 10,...
            'markerFaceColor', [0 1 0],...
            'markerEdgeColor', [0.6, 0.6 0.6],...
            'xdata',0,...
            'ydata',0);
    end

    properties(SetAccess=protected)
        outputPower = 100;   % in kW
        chargeTime = 15;      % in seconds
        wavelength = 1.07;    % in micrometers
        dischargeRate = 1;    % in seconds
        numBatteries = 5;     % number of batteries
        maxRange = 10;        % in km
        maxTemperature = 90;  % in celsius
        coolDownRate = 30;    % 30 deg_cel/sec
    end

    methods
        % Override the fire method to implement specific firing behavior for LaserB
        % function fire(obj)
        %     disp('Laser B firing...');
        %     % Example: Update the marker position or perform a firing animation
        %     obj.markerHandle.XData = obj.markerHandle.XData + 2;  % Move marker more than LaserA
        %     obj.markerHandle.YData = obj.markerHandle.YData + 2;  % Move marker more than LaserA
        % end
        
        % Override the follow method to implement specific following behavior for LaserB
        function follow(obj, targetX, targetY)
            disp(['Laser B following target at: (', num2str(targetX), ', ', num2str(targetY), ')']);
            % Example: Update the marker's position to follow the target
            obj.markerHandle.XData = targetX;
            obj.markerHandle.YData = targetY;
        end
    end

    methods(Static)
        function description = getDescription()
            description = 'Laser model B';
        end
    end    
end