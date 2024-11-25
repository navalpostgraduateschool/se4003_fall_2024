classdef (Abstract) DBDrone < DBModelWithGraphic
    properties(SetAccess=protected)
        position = [0,0]; % UAV position as [x, y]
        velocity = 0;% Maximum velocity magnitude
        armor % UAV armor level (e.g., 0-100)
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

        function didInit = init(obj, initPos, initVelocity)
            obj.armor = obj.MAX_ARMOR;
            obj.velocity = 0;
            if nargin>1
                obj.position = initPos;
                if nargin > 2
                    obj.velocity = initVelocity;
                end
            end
            didInit = true;
        end
        
        function setPosition(this, pos)
            this.position = pos;
        end

        function didSet = setVelocity(this, vel)
            didSet = false;
            if vel>=0 && vel<= this.MAX_VELOCITY
                this.velocity = vel;
                didSet = true;
            end
        end

        function update(obj, dt, velocity)
            % Ensure the velocity does not exceed MaxVelocity
            if norm(velocity) > obj.MAX_SPEED
                velocity = (velocity / norm(velocity)) * obj.MAX_SPEED;
            end
            obj.position = obj.position + velocity * dt;
        end
    end
end
