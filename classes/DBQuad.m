classdef DBQuad < DBUAVA
    % Quad UAV Class Inherits from DBUAVA
    
    properties (Constant)
        MaxSpeed = 1.5; % Maximum speed for the Quad UAV
        MarkerType = 's'; % Marker type for visualization (square)
        Color = [0, 0, 1]; % Color for visualization (blue)
        Size = 80; % Marker size for visualization
        Icon = ''; % Optional: Icon (e.g., for UI representation)
    end
    
    methods
        function obj = DBQuad(position, maxVelocity, armor)
            % Call superclass constructor
            obj@DBUAVA(position, maxVelocity, armor);
        end
        
        function update(obj, dt, velocity)
            % Update the position of the Quad UAV
            % Ensure velocity does not exceed MaxSpeed
            if norm(velocity) > obj.MaxSpeed
                velocity = (velocity / norm(velocity)) * obj.MaxSpeed;
            end
            obj.Position = obj.Position + velocity * dt;
        end
    end
end
