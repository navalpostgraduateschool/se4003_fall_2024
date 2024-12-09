classdef (Abstract) DBLaser < DBModelWithGraphic
    % Abstract class for Laser with common properties
    events
        DBLasingEvt
        DBLasingOffEvt
    end

    properties(Constant)
        
    end

    properties (Abstract, SetAccess=protected)
        outputPower       % Output power of the laser
        chargeTime        % Charge time of the laser (seconds)
        wavelength        % Wavelength of the laser (micrometers)
        dischargeRate     % Discharge rate of the laser (seconds)
        numBatteries      % Number of batteries
        maxRange          % Range of the laser (km)
        maxTemperature    % maximum temperature the laser can operate at
        coolDownRate      % how quickly the laser will cool down in degrees C per second
    end

    properties (SetAccess=protected)
        laseH;  % line handle for the laser
        temperature = 0;  % and it can increase?
        powerAvailable = 100;
        laserOn = false;
        lastUpdateTimestamp; % time stamp of last update

        % These exist in the parent class
        % axesH         % Handle for the axis in GUI
        % lineH         % Handle for the marker in GUI
    end

    methods
        % Abstract methods could be added here if needed, for example:
        % function fireLaser(obj)
        %     % Implementation to fire laser
        % end

        % A general method to display laser details
        function displayLaserDetails(obj)
            disp('Laser Specifications:');
            disp(['Output Power: ', num2str(obj.outputPower), ' kW']);
            disp(['Charge Time: ', num2str(obj.chargeTime), ' sec']);
            disp(['Wavelength: ', num2str(obj.wavelength), ' micrometers']);
            disp(['Discharge Rate: ', num2str(obj.dischargeRate), ' sec']);
            disp(['Number of Batteries: ', num2str(obj.numBatteries)]);
            disp(['Range: ', num2str(obj.maxRange), ' km']);
        end

        function obj = DBLaser(varargin)
            obj.setConstructorArguments(varargin{:});
        end

        function canIt = canItFire(this)
            canIt = this.powerAvailable > 0 && this.temperature <= this.maxTemperature;
        end

        function createLine(this, varargin)
            laserProps = struct('linestyle', '-', 'linewidth', 2, 'color', 'green', 'visible', 'off');
            this.createLine@DBModelWithGraphic(varargin{:});
            this.laseH = line(this.axesH, nan, nan, laserProps);
        end

        % Method to set axis and marker handle
        function setHandles(obj, ax, marker)
            obj.axesH = ax;
            obj.lineH = marker;
        end

        function turnOn(obj, target)
            obj.laserOn = 1;
        end

        function turnOff(obj)
            obj.laserOn = 0;
            set(obj.laseH, 'visible', 'off');
            obj.notify('DBLasingOffEvt');
        end

        Power = DBpowerdistancecalc(x, y, cond, initialpower);
        
        % Fire method (abstract for subclasses to define)
        function fire(obj, droneOrTarget, duration_s)
            obj.turnOn();

            if isa(droneOrTarget, 'DBDrone')
                target = droneOrTarget.position;
                obj.notify('DBLasingEvt', DBLasedOnEvt(droneOrTarget, obj));
            else
                target = droneOrTarget;                
            end
            
            set(obj.laseH, 'xdata', [target(1), obj.position(1)], 'ydata', [target(2), obj.position(2)], 'visible', 'on');
            if nargin > 2
                pause(duration_s);
                obj.turnOff();
            end
        end
        
        % Follow method (abstract for subclasses to define)
        function follow(obj, targetX, targetY)
            % This is a placeholder for subclasses to implement follow behavior
            % This could involve updating the marker's position to follow a target
            disp(['Laser following target at position: (', num2str(targetX), ', ', num2str(targetY), ')']);
        end

        function update(this)
            timeSinceLastUpdate
        end

        function reset(obj)
            obj.turnOff();
            obj.temperature = 0;
            obj.powerAvailable = 100;
        end

        % New method to calculate the induced power based on range
        function powerIn = calculateInducedPower(obj, x, y)
            % Assuming 'initialpower' is the laser's output power
            initialpower = obj.outputPower;  % Use the outputPower from the laser object
            
            % Call the DBpowerdistancecalc function to compute the induced power
            powerIn = powerdistancecalc(x, y, 'normal', initialpower);
        end



        function T1 = updateTemp(obj, dt)
            % Feedback - the dblaser class broke after this was installed.  we want to hold off pushing code until it works so that it 
            % does not break things elsewhere that others depend on.  This is why we would also keep a separate branch and then merge them later.

            % The instructions for this were to update the current temperature.

            % Calculates the temperature at t1 given dt, temperature, and Power

            % Incorrect
            % dt = t1 - temperature in seconds
            
            % Correct
            % dt = t1-t0 in seconds.

            % temperature: Initial temperature in °F

            % R: Thermal resistance (fixed)

            % C: Thermal capacitance (fixed)

            % outputPower: Laser power in W

            R = 0.05;

            C = 200;


            % Compute the temperature change based on power output

            T1 = obj.temperature + (obj.outputPower * R * (1 - exp(-dt / (R * C))));
            obj.temperature = T1;

        end

    end
end
