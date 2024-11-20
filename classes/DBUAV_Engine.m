classdef DBUAV_Engine
    properties
        DBPredator
        DBQuad
        Axes
    end

    methods
        % Constructor
        function obj = DBUAV_Engine(numPredators, numQuads, axes)
            obj.Axes = axes;

            % Initialize DBPredator instances
            obj.DBPredator = arrayfun(@(~) DBPredator(rand(1, 2) * 10, rand * 0.5, randi([50, 100])), 1:numPredators);

            % Initialize DBQuad instances
            obj.DBQuad = arrayfun(@(~) DBQuad(rand(1, 2) * 10, rand * 0.5, randi([50, 100])), 1:numQuads);
        end

        % Run the simulation
        function run(obj, numIterations)
            dt = 0.1; % Define a fixed time step
            for iter = 1:numIterations
                % Clear the axes
                cla(obj.Axes);

                % Update and plot DBPredator instances
                for i = 1:numel(obj.DBPredator)
                    % Generate a random velocity for the predator
                    velocity = rand(1, 2) - 0.5; % Random velocity in [-0.5, 0.5] for both x and y directions
                    obj.DBPredator(i).update(dt, velocity);

                    % Plot Predator UAV
                    scatter(obj.Axes, obj.DBPredator(i).Position(1), obj.DBPredator(i).Position(2), ...
                            50, 'r', 'filled', 'Marker', obj.DBPredator(i).MarkerType);
                    hold(obj.Axes, 'on');
                end

                % Update and plot DBQuad instances
                for i = 1:numel(obj.DBQuad)
                    % Generate a random velocity for the quad
                    velocity = rand(1, 2) - 0.5; % Random velocity in [-0.5, 0.5]
                    obj.DBQuad(i).update(dt, velocity);

                    % Plot Quad UAV
                    scatter(obj.Axes, obj.DBQuad(i).Position(1), obj.DBQuad(i).Position(2), ...
                            50, 'b', 'filled', 'Marker', obj.DBQuad(i).MarkerType);
                    hold(obj.Axes, 'on');
                end

                % Set axis limits and pause
                xlim(obj.Axes, [0, 10]);
                ylim(obj.Axes, [0, 10]);
                drawnow;
                pause(0.1);
            end
        end
    end
end
