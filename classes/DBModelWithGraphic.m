classdef DBModelWithGraphic < DBModel & DBGraphic

    properties(SetAccess=protected)
        position = [nan, nan];
    end
    methods
        function syncGraphic(obj)
            set(obj.lineH,'xdata',obj.position(1),...
                'ydata', obj.position(2));
        end
    end
end