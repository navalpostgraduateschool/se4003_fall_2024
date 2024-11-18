classdef DBPredator < DBUAVA
    properties (Constant)
        MaxSpeed = 100; % Maximum speed for large UAVs
        MarkerType = 'x'; % Cross marker
        Color = [1, 0, 0]; % Red color
        Size = 16; % Large marker size
        Icon = 'predator_icon.png'; % Example icon for a predator UAV
    end
    
    methods
        function obj = DBPredator(position)
            if nargin == 0
               position = [100, 100]; % Define a valid position as a 2-element vector
              
            end
            obj@DBUAVA(position, DBPredator.MaxSpeed, 80);
        end
    end
end
