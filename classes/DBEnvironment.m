classdef DBEnvironment < DBModelWithGraphic
    properties(Constant)
        LINE_PROPERTIES = struct('color',[0.2 0.8 .5],...
            'linestyle','--',...
            'marker', 'none',...
            'markerSize', 10,...
            'markerFaceColor', 'blue',...
            'xdata',nan,...
            'ydata',nan);
    end

    properties(SetAccess=protected)
        axes_properties = struct('color',[0.4 0.6 0.8],...% [0.3 0.5 0.8],...
            'xgrid','on', ...
            'ygrid','on', ...
            'xminorgrid','on',...
            'yminorgrid','on',...
            'xticklabel','',...
            'yticklabel','',...
            'ytickmode','auto',...
            'xtickmode','auto',...
            'tickdir', 'none', ... % do not show the actual ticks - they are too strong/dark compared to the grid lines.
            'gridlinestyle','-',...
            'gridcolor',[0.15 0.15 0.15],...
            'gridlinewidth', 2,...,
            'minorgridlinewidth',1,...
            'minorgridlinestyle',':'); 
        dimensions_x = [-100, 100]
        dimensions_y = [-100, 100]
    end

    methods

        function obj = DBEnvironment(axes_h, varargin)
            if nargin<1 || isempty(axes_h)
                axes_h = gca;
            end
            obj@DBModelWithGraphic(axes_h, varargin{:})
            % DBModelWithGraphic(obj, axes_h, varargin{:})
        end

        function initAxes(this)
            if ~isempty(this.axesH) && ishandle(this.axesH)
                initAxes(this.axesH, this.dimensions_x, this.dimensions_y, this.axes_properties);
            end
        end

        function reset(this)
            this.log('Reseting environment');
        end

        function update(this)
            this.log('No update for DB environment')
        end

        function didSet = setAxesHandle(this, axesH)
            didSet = this.setAxesHandle@DBModelWithGraphic(axesH);
            if didSet
                this.initAxes();
            end
        end

        % function env = DBEnvironment(varargin)
        % 
        % 
        % end

    end

    methods(Static)
        function desc = getDescription()
            desc = 'Environment that the simulator plays out on';
        end
    end
end