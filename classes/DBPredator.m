classdef DBPredator < DBUAVA
    % Predator UAV Class Inherits from DBUAVA
    
    properties (Constant)
        MaxSpeed = 2.0; % Maximum speed for the Predator UAV
        MarkerType = '^'; % Marker type for visualization
        Color = [1, 0, 0]; % Color for visualization (red)
        Size = 100; % Marker size for visualization
        Icon = ''; % Optional: Icon (e.g., for UI representation)
    end
    
    methods
        function obj = DBPredator(position, maxVelocity, armor)
            % Call superclass constructor
            obj@DBUAVA(position, maxVelocity, armor);
        end
        
        function update(obj, dt, velocity)
            % Update the position of the Predator UAV
            % Ensure velocity does not exceed MaxSpeed
            if norm(velocity) > obj.MaxSpeed
                velocity = (velocity / norm(velocity)) * obj.MaxSpeed;
            end
            obj.Position = obj.Position + velocity * dt;
        end
    end
end
