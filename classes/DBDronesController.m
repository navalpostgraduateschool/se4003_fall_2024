classdef DBDronesController < DBController

    properties(Constant)
        SUPPORTED_DRONES = {
            'Predator';
            'Quad Copter';
            }
    end
    properties(SetAccess=protected)
        numDrones = 2;
        droneType = 'predator';
        drones = [];
        location;  % x,y location of the controller, where drones will be launched from.
    end

    methods
        
        function setLocation(this, controllerLoc)
            this.location = controllerLoc;
        end

        function didSet = setDroneType(this, droneType)
            droneType = this.SUPPORTED_DRONES{strcmpi(droneType, this.SUPPORTED_DRONES)};
            didSet = false;
            if ~isempty(droneType)
                this.droneType = droneType;
                didSet = true;
            end

        end



        function didSet = setNumDrones(this, num)

            num = max(0, round(num));
            if ~isnan(num)
                this.numDrones = num;
                didSet = true;
            end
        end

        function initModel(this)

            switch lower(this.droneType)
                case 'predator'
                    droneClass = @DBDronePredator;
                case 'quad copter'
                    droneClass = @DBDroneQuad;
                otherwise
                    droneClass = [];
            end
            if isempty(droneClass)
                this.logWarning('Drone type is not set!')
            else
                tmpDroneObj = droneClass();
                this.drones = repmat(tmpDroneObj, this.numDrones,1);
                for n=1:this.numDrones
                    this.drones(n) = droneClass(this.axesH, this.logH);
                    this.drones(n).setPosition(this.location);
                end
            end

            % this.modelObj = 

        end



        % Run the simulation
        function run(obj, numIterations)
            dt = 0.1; % Define a fixed time step
            for iter = 1:numIterations
                % Clear the axes
                cla(obj.Axes);

                % Update and plot DBPredator instances
                for i = 1:numel(obj.DBPredator)
                    % Generate a random velocity for the predator
                    velocity = rand(1, 2) - 0.5; % Random velocity in [-0.5, 0.5] for both x and y directions
                    obj.DBPredator(i).update(dt, velocity);

                    % Plot Predator UAV
                    scatter(obj.Axes, obj.DBPredator(i).Position(1), obj.DBPredator(i).Position(2), ...
                            50, 'r', 'filled', 'Marker', obj.DBPredator(i).MarkerType);
                    hold(obj.Axes, 'on');
                end

                % Update and plot DBQuad instances
                for i = 1:numel(obj.DBQuad)
                    % Generate a random velocity for the quad
                    velocity = rand(1, 2) - 0.5; % Random velocity in [-0.5, 0.5]
                    obj.DBQuad(i).update(dt, velocity);

                    % Plot Quad UAV
                    scatter(obj.Axes, obj.DBQuad(i).Position(1), obj.DBQuad(i).Position(2), ...
                            50, 'b', 'filled', 'Marker', obj.DBQuad(i).MarkerType);
                    hold(obj.Axes, 'on');
                end

                % Set axis limits and pause
                xlim(obj.Axes, [0, 10]);
                ylim(obj.Axes, [0, 10]);
                drawnow;
                pause(0.1);
            end
        end
    end

    methods(Static)
        function desc = getDescription()
            desc = 'Drones controller';
        end
    end
end
