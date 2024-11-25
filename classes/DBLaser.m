classdef (Abstract) DBLaser < DBModelWithGraphic
    % Abstract class for Laser with common properties

    properties (Abstract)
        OutputPower       % Output power of the laser
        ChargeTime        % Charge time of the laser (seconds)
        Wavelength        % Wavelength of the laser (micrometers)
        DischargeRate     % Discharge rate of the laser (seconds)
        NumBatteries      % Number of batteries
        Range             % Range of the laser (km)
    end

    properties (SetAccess=protected)

        % These exist in the parent class
        % axesH         % Handle for the axis in GUI
        % lineH         % Handle for the marker in GUI
    end

    methods
        % Abstract methods could be added here if needed, for example:
        % function fireLaser(obj)
        %     % Implementation to fire laser
        % end
        
         function syncGraphic(this)
            if this.armor>0
                this.show();
            else
                this.hide();
            end
         end

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
        
        % Method to set axis and marker handle
        function setHandles(obj, ax, marker)
            obj.axesH = ax;
            obj.lineH = marker;
        end
        
        % Fire method (abstract for subclasses to define)
        function fire(obj)
            % This is a placeholder for subclasses to implement firing behavior
            % This could involve updating the marker, reducing energy, etc.
            disp('Laser firing...');
        end
        
        % Follow method (abstract for subclasses to define)
        function follow(obj, targetX, targetY)
            % This is a placeholder for subclasses to implement follow behavior
            % This could involve updating the marker's position to follow a target
            disp(['Laser following target at position: (', num2str(targetX), ', ', num2str(targetY), ')']);
        end
    end
end
