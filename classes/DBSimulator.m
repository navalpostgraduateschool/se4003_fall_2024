classdef DBSimulator < handle
    properties
        swarmController   % Instance of the swarm controller (nested class)
        laserController   % Instance of the laser controller
        axis_handle       % Handle to the GUI axes for visualization
    end
    
    methods
        % Constructor
        function this = duckBlindSimulator(laserController, axis_handle)
            this.swarmController = duckBlindSimulator.swarmController(); % Create swarmController instance
            this.laserController = laserController;
            this.axis_handle = axis_handle;
        end
        
        % Other methods (initializeSwarmController, run, etc.)
        % Remain the same as previously provided
    end
end
