classdef DBSimulator < DBController
    properties
        env_width;  
        env_height;
        environment;
        dronesController   % Instance of the drones controller ?(nested class)?  -- what does this mean?
        laserController   % Instance of the laser controller
        % axis_handle       % Handle to the GUI axes for visualization
    end
    
    methods
        % Constructor
        function this = DBSimulator(axisH, varargin)
            if nargin<1 || isempty(axisH)
                axisH = gca;
            end
            this@DBController(axisH, varargin{:});
            %
            %this.swarmController = duckBlindSimulator.swarmController(); % Create swarmController instance
            % this.laserController = laserController;
            % this.axis_handle = axis_handle;
        end
        
        function initModel(this)
            this.env_height = 200;
            this.env_width = 200;
            this.environment = DBEnvironment(this.axesH, this.logH);
            if isempty(this.axesH)
                this.axesH = this.environment.axesH;
            end
            this.laserController = DBLaserController(this.axesH, this.logH);
            this.dronesController = DBDronesController(this.axesH, this.logH);
            this.laserController.setPosition([-10,-10]);
            top_right = 0.9*[this.environment.dimensions_x(2), this.environment.dimensions_y(2)];

            this.dronesController.initPosition = top_right;
            this.dronesController.setPosition(top_right);

            % or
            % 
            % this.dronesController.reset();
        end

        function reset(this)
            this.environment.reset();
            this.dronesController.reset();
            this.laserController.reset();
        end

        % Other methods (initializeSwarmController, run, etc.)
        % Remain the same as previously provided
        function didSet = setNumDrones(this, numDrones)
            didSet = this.dronesController.setNumDrones(numDrones);
        end

        function didSet = setDroneType(this, droneType)
            didSet = this.dronesController.setDroneType(droneType);
        end

        function didSet = setLaserType(this, laserType)
            didSet = this.laserController.setLaserType(laserType);
        end

        % Determines if the simulation is done
        function isIt = isDone(this)
            % is done when the laser is dead - never happen
            % when there are no more drones.
            isIt = this.dronesController.isDone();
        end

        function run(this)
            while ~this.isDone()
                this.update();
            end
        end

        function demo_run(this, numSeconds)
            fps = 20;
            if nargin<2 || isempty(numSeconds)
                numSeconds = 10;
            end
            numIterations = fps*numSeconds;
            this.reset();
            drone_start_pos = [30, 30];
            laser_location = [-15, -15];
            start_velocity = 5;

            laserType = 'a';
            this.setLaserType(laserType);
            droneType = 'quad copter';
            this.dronesController.initModel(drone_start_pos, laser_location, start_velocity,droneType);

            dt = 1/fps;
            for n=1:numIterations
                this.update();
                pause(dt);
            end
        end

        function drones = getTargetableDrones(this, laserCtrl, dronesCtrl)
            if nargin<3
                dronesCtrl = this.dronesController;
                if nargin<2
                    laserCtrl = this.laserController;
                end
            end
            numDrones = dronesCtrl.numDrones;
            targetableIdx = false(numDrones,1);
            for idx=1:numDrones
                curDrone = dronesCtrl.drones(idx);
                targetableIdx(idx) = curDrone.isTargetable() && laserCtrl.isLocationTargetable(curDrone.position);
            end
            drones = dronesCtrl.drones(targetableIdx);            
        end

        function update(this)
            activeDrones = this.getTargetableDrones();
            % if numel(activeDrones)>0
            %     disp(numel(activeDrones));
            % end
            this.laserController.update(activeDrones);
            this.dronesController.update();
            this.environment.update();
        end
    end

    methods(Static)
        function description = getDescription()
            description = 'Simulation controllor';
        end
    end
end
