classdef DBModelWithGraphic < DBModel & DBGraphic

    properties(SetAccess=protected)
        position = [nan, nan];
    end
    methods

        function didSet = setPosition(this, pos)
            try

                this.position = pos;
                this.syncGraphic();
                didSet = true;
            catch me
                this.logError(me);
                didSet = false;
            end
        end

        function delete(obj)
            delete@DBGraphic(obj);
            delete@DBModel(obj);
        end

        function syncGraphic(obj)
            set(obj.lineH,'xdata',obj.position(1),...
                'ydata', obj.position(2));
        end
    end
end