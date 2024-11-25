classdef DBDronePredator < DBDrone
    
    properties (Constant)
        LINE_PROPERTIES = struct('color','blue',...
            'linestyle','none',...
            'marker', '^',...
            'markerSize', 20,...  % Size = 100; % Marker size for visualization
            'markerFaceColor', [1, 0, 0],...
            'xdata',0,...
            'ydata',0);

        MAX_ARMOR = 80;
        MAX_VELOCITY = 2.0; % Maximum speed for the Predator UAV
        % MarkerType = '^'; % Marker type for visualization
        % Color = [1, 0, 0]; % Color for visualization (red)
        
    end
    
    methods
        % function obj = DBDronePredator(position, maxVelocity, armor)
        %     % Call superclass constructor
        %     obj@DBUAVA(position, maxVelocity, armor);
        % end
        
        function update(obj, dt, velocity)
            % Update the position of the Predator UAV
            % Ensure velocity does not exceed MaxSpeed
            if norm(velocity) > obj.MaxSpeed
                velocity = (velocity / norm(velocity)) * obj.MaxSpeed;
            end
            obj.Position = obj.Position + velocity * dt;
        end
    end

    methods(Static)
        function description = getDescription()
            description = 'Predator Drone';
        end

    end
end
