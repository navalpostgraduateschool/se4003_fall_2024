classdef DBDroneQuad < DBDrone
    % Quad UAV Class Inherits from DBUAVA
    
    properties (Constant)
        LINE_PROPERTIES = struct('color',[0 0 1],...
            'linestyle','none',...
            'marker', 's',...   % Marker type for visualization (square)
            'markerSize', 8,...  % Size = 100; % Marker size for visualization
            'markerFaceColor', [0, 0, 1],...
            'xdata',0,...
            'ydata',0);
        MAX_VELOCITY = 0.5;
        MAX_ARMOR = 20;

    end
    
    methods(Static)
        function description = getDescription()
            description = 'Quad copter drone';
        end
        
    end
end
