classdef (Abstract) DBDrone < DBModelWithGraphic
    events
        DBDroneKilledEvt;
    end
    properties(SetAccess=protected)
        % position = [0,0]; % UAV position as [x, y] - this exists in the DBModelWithGraphic class
        velocity = 0;% Maximum velocity magnitude
        heading_deg;
        armor % UAV armor level (e.g., 0-100)
        status = 'unset';  % can be 'unset', 'ready', 'loiter','inactive','active','success','destroyed','dead','available'
        showHeading;
        destination;  % position the drone is flying to.  Bearing is updated with the destination.
        heading_h;  % maybe show a line for the direction the drone is going?
    end
    
    properties (Abstract, Constant)
        MAX_VELOCITY % Maximum speed for the drone
        MAX_ARMOR; % armor for drone when at full strength
        % MarkerType % Marker type for visualization (e.g., 'o', '+', '*')
        % Color % Color for visualization as [R, G, B]
        % Size % Marker size for visualization
        % Icon % Icon representing the UAV (e.g., a file path or symbolic name)
    end
    
    methods
        function syncGraphic(this)
            if this.armor>0
                set(this.lineH, 'xdata', this.position(1), 'ydata', this.position(2));
            else
                set(this.lineH,'visible','off')
            end
        end

        function isIt = isAlive(this)
            isIt = this.armor > 0;
        end

        function lasingDamageCb(this, damageEvt)
            lase_dur_sec = damageEvt.duration_sec;
            laserObj = damageEvt.laserObj;
            damage = laserObj.outputPower*lase_dur_sec;
            this.armor = this.armor - damage;
            if this.armor<=0
                this.die()
            end
        end

        function die(this)
            this.status = 'dead';
            this.hide();
            this.notify('DBDroneKilledEvt');
        end

        function didInit = init(obj, initPos, initTarget, initVelocity, readyStatus)
            obj.armor = obj.MAX_ARMOR;
            obj.velocity = 0;
            if nargin>1
                obj.setPosition(initPos);  % obj.position = initPos;
                if nargin > 2
                    obj.setDestination(initTarget);
                    if nargin>3
                        obj.velocity = initVelocity;
                    end
                end
            end

            if nargin<5
                if obj.velocity == 0
                    readyStatus = 'available';
                else
                    readyStatus = 'active';
                end
            end
            obj.status = readyStatus;
            didInit = true;
        end

        function isIt = isTargetable(this)
            isIt = any(strcmpi(this.status,{'active','ready','loiter'}));
        end
        
        function didSet = setVelocity(this, vel)
            didSet = false;
            if vel>=0 && vel<= this.MAX_VELOCITY
                this.velocity = vel;
                didSet = true;
            end
        end

        function cur_heading = updateHeading(obj)
            % Calculate the differences in x and y
            cur_heading = calcHeading(obj.position, obj.destination);
            obj.heading_deg = cur_heading;
        end

        function update(obj)
            if obj.isAlive()
                obj.updateHeading();
                obj.updatePosition();
                obj.syncGraphic();
            end
        end

        % function update(obj, dt, velocity)
        %     % Ensure the velocity does not exceed MaxVelocity
        %     if norm(velocity) > obj.MAX_SPEED
        %         velocity = (velocity / norm(velocity)) * obj.MAX_SPEED;
        %     end
        %     obj.position = obj.position + velocity * dt;
        % end

        function updatePosition(obj)
            % Conversion
            time_multiplier = 10; % Speed up the simulation by this factor
            nm_per_second = obj.velocity; % (obj.speed_nmh / 3600) * time_multiplier; 
            fps = 10;
            distance_per_frame = nm_per_second / fps;

            % Convert heading to radians
            heading_rad = obj.heading_deg * pi / 180;

            % Calculate dx and dy from heading
            dx = cos(heading_rad);
            dy = sin(heading_rad);
            dx_dy = [dx, dy];
            
            obj.position = obj.position + distance_per_frame*dx_dy;

        end

        function showPath(obj, shouldShow)
            obj.showHeading = shouldShow;
            obj.updateDisplay;
        end

        % Sets the max velocity toward the destination given
        % if not destination coordiantes are given (x,y) then the current
        % destination coordinates are used
        % If the destination coordinates are provided, then the destination
        % property will be updated with these.  You are responsible for
        % keeping track of the last location.

        % function updateVelocityToDestination(this, destCoord)
        %     if nargin > 1
        %         this.setDestination(destCoord)
        %     end
        % end

        function didSet = setDestination(this, destCoord)
            this.destination = destCoord;
            didSet = true;
        end
        
    end
end
