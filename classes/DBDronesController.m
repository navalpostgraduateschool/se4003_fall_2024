classdef DBDronesController < DBController

    properties(Constant)
        SUPPORTED_DRONES = {
            'Predator';
            'Quad Copter';
            }
    end
    properties(SetAccess=protected)
        numDrones = 30;
        launchDelay = 20;  % delay in seconds between launching drones.
        droneType = 'predator';
        drones = [];
        location = [nan,nan];  % x,y location of the controller, where drones will be launched from.
        destination = [nan, nan];  % x,y location of the destination drone(s) are launched to.
    end

    methods
        
        function setDestination(this, targetLocation)
            this.destination = targetLocation;
        end

        function setLocation(this, controllerLoc, shouldReset)
            if nargin<3
                shouldReset = false;
            end
            if nargin<2 || isempty(controllerLoc)
                controllerLoc = this.initPosition;
            end
            this.location = controllerLoc;
            if shouldReset
                this.reset();
            end
        end

        function status = getStatus(this)
            numAvail = 0;
            numActive = 0;
            numDestroyed = 0;
            numSuccess = 0;
            numUnknown = 0;
            for n=1:this.numDrones
                switch(this.drones(n).status)
                    case {'active','loitering','mission'}
                        numActive = numActive+1;
                    case {'ready','available'}
                        numAvail = numAvail+1;
                    case {'destroyed','dead'}
                        numDestroyed = numDestroyed + 1;
                    case {'success','complete'}
                        numSuccess = numSuccess + 1;
                    otherwise
                        numUnknown = numUnknown + 1;
                end
            end
            status.active = numActive;
            status.available = numAvail;
            status.alive = numActive+numAvail+numSuccess;
            status.remaining = numActive+numAvail;
            status.destroyed = numDestroyed; 
            status.success = numSuccess;
            status.unknown = numUnknown;
        end

        function num = getDronesAlive(this)
            status = this.getStatus();
            num = status.alive;
        end

        function num = getNumRemaining(this)
            status = this.getStatus();
            num = status.remaining;
        end

        function num = getNumAvailableForLaunch(this)
            status = this.getStatus();
            num = status.available;
        end

        function num = getNumSuccessful(this)
            status = this.getStatus();
            num = status.success;
        end

        function num = getNumDestroyed(this)
            status = this.getStatus();
            num = status.destroyed;
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

        function reset(this)
            this.initModel();
        end

        function isIt = isDone(this)
            isIt = this.getNumRemaining()==0;
        end

        function didInit = initModel(this, location, target, start_velocity, droneTypeIn)
            didInit = false;
            if nargin>4
                this.setDroneType(droneTypeIn);
            end

            switch lower(this.droneType)
                case 'predator'
                    droneClass = @DBDronePredator;
                case {'quad copter','quad_copter','quad'}
                    droneClass = @DBDroneQuad;
                otherwise
                    droneClass = [];
            end
            initVelocity = 0;
            if nargin>1
                this.setLocation(location);
                if nargin>2
                    this.setDestination(target);
                    if nargin>3
                        initVelocity = start_velocity;
                    end
                end
            end
            
            initStatus = 'ready';
            if isempty(droneClass)
                this.logWarning('Drone type is not set!')
            else
                tmpDroneObj = droneClass();
                this.drones = repmat(tmpDroneObj, this.numDrones,1);
                heading_rad = calcHeading(this.destination, this.location)*pi/180;
                % Calculate dx and dy from heading
                if isnan(heading_rad)
                    locationOffset = 0;
                else
                    dx = cos(heading_rad);
                    dy = sin(heading_rad);
                    locationOffset = [dx, dy]*this.launchDelay;
                end
                for n=1:this.numDrones
                    this.drones(n) = droneClass(this.axesH, this.logH);
                    start_location = this.location+(n-1)*locationOffset;
                    this.drones(n).init(start_location, this.destination, initVelocity, initStatus);
                end
                didInit = this.setModel(this.drones);
            end
        end

        function update(this)
            if ~this.isDone()
                for n=1:this.numDrones()
                    drone = this.drones(n);
                    drone.update();
                end
            end
        end

        function demo_run(this, numSeconds)
            fps = 20;
            if nargin<2 || isempty(numSeconds)
                numSeconds = 5;
            end
            numIterations = fps*numSeconds;

            start_pos = [30, 30];
            target_pos = [-15, -15];
            start_velocity = 5;

            this.initModel(start_pos, target_pos, start_velocity)

            dt = 1/fps;
            for n=1:numIterations
                this.update();
                pause(dt);
            end
        end

        % Run the simulation
        % function run(obj, numIterations)
        %     dt = 0.1; % Define a fixed time step
        %     for iter = 1:numIterations
        %         % Clear the axes
        %         cla(obj.Axes);
        % 
        %         % Update and plot DBPredator instances
        %         for i = 1:numel(obj.DBPredator)
        %             % Generate a random velocity for the predator
        %             velocity = rand(1, 2) - 0.5; % Random velocity in [-0.5, 0.5] for both x and y directions
        %             obj.DBPredator(i).update(dt, velocity);
        % 
        %             % Plot Predator UAV
        %             scatter(obj.Axes, obj.DBPredator(i).Position(1), obj.DBPredator(i).Position(2), ...
        %                     50, 'r', 'filled', 'Marker', obj.DBPredator(i).MarkerType);
        %             hold(obj.Axes, 'on');
        %         end
        % 
        %         % Update and plot DBQuad instances
        %         for i = 1:numel(obj.DBQuad)
        %             % Generate a random velocity for the quad
        %             velocity = rand(1, 2) - 0.5; % Random velocity in [-0.5, 0.5]
        %             obj.DBQuad(i).update(dt, velocity);
        % 
        %             % Plot Quad UAV
        %             scatter(obj.Axes, obj.DBQuad(i).Position(1), obj.DBQuad(i).Position(2), ...
        %                     50, 'b', 'filled', 'Marker', obj.DBQuad(i).MarkerType);
        %             hold(obj.Axes, 'on');
        %         end
        % 
        %         % Set axis limits and pause
        %         xlim(obj.Axes, [0, 10]);
        %         ylim(obj.Axes, [0, 10]);
        %         drawnow;
        %         pause(0.1);
        %     end
        % end
    end

    methods(Static)
        function desc = getDescription()
            desc = 'Drones controller';
        end
    end
end
