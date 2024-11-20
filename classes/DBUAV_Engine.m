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
            obj.DBPredator = arrayfun(@(~) DBPredator(rand(1, 2) * 10, rand(1, 2) * 0.5), 1:numPredators);

            % Initialize DBQuad instances
            obj.DBQuad = arrayfun(@(~) DBQuad(rand(1, 2) * 10, rand(1, 2) * 0.5), 1:numQuads);
        end

        % Run the simulation
        function run(obj, numIterations)
            for iter = 1:numIterations
                % Clear the axes
                cla(obj.Axes);

                % Update and plot DBPredator instances
                for i = 1:numel(obj.DBPredator)
                    obj.DBPredator(i).update();
                    scatter(obj.Axes, obj.DBPredator(i).position(1), obj.DBPredator(i).position(2), ...
                            50, 'r', 'filled');
                    hold(obj.Axes, 'on');
                end

                % Update and plot DBQuad instances
                for i = 1:numel(obj.DBQuad)
                    obj.DBQuad(i).update();
                    scatter(obj.Axes, obj.DBQuad(i).position(1), obj.DBQuad(i).position(2), ...
                            50, 'b', 'filled');
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