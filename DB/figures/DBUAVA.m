classdef (Abstract) DBUAVA < handle
    properties
        Position % UAV position as [x, y]
        MaxVelocity % Maximum velocity magnitude
        Armor % UAV armor level (e.g., 0-100)
    end
    
    properties (Abstract, Constant)
        MaxSpeed % Maximum speed for the UAV
        MarkerType % Marker type for visualization (e.g., 'o', '+', '*')
        Color % Color for visualization as [R, G, B]
        Size % Marker size for visualization
        Icon % Icon representing the UAV (e.g., a file path or symbolic name)
    end
    
    methods
        function obj = DBUAVA(position, maxVelocity, armor)
            if nargin == 0
                % Default constructor for preallocation
                obj.Position = [0, 0];
                obj.MaxVelocity = 0;
                obj.Armor = 0;
            elseif nargin == 3
                % Constructor with specified inputs
                obj.Position = position;
                obj.MaxVelocity = maxVelocity;
                obj.Armor = armor;
            else
                error('DBUAV constructor requires either no inputs or exactly three inputs: position, maxVelocity, and armor.');
            end
        end
        
        function obj = update(obj, dt, velocity)
            % Ensure the velocity does not exceed MaxVelocity
            if norm(velocity) > obj.MaxVelocity
                velocity = (velocity / norm(velocity)) * obj.MaxVelocity;
            end
            obj.Position = obj.Position + velocity * dt;
        end
    end
end
