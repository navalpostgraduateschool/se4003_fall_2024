classdef DBGraphic < DBBase
    properties(Abstract, Constant)
        LINE_PROPERTIES; % struct containing line properties that can be used when initilizing the line handle

    end
    properties(SetAccess=private)
        lineH;
        axesH;
    end
    
    methods

        function didSet = setConstructorArguments(this, varargin)
            didSetClass = false;
            didSetBase = false;
            for n=1:numel(varargin)
                argIn = varargin{n};
                if isa(argIn, 'matlab.graphics.axis.Axes')
                    didSetClass = didSetClass || this.setAxesHandle(argIn);
                else
                    didSetBase = setConstructorArguments@DBBase(this, argIn) || didSetBase;
                end            
            end
            didSet = didSetClass && didSetBase;
        end

        function createLine(this,lineProperties)

            if nargin<2
                lineProperties = this.LINE_PROPERTIES;
            end
            if ~ishandle(this.axesH)
                this.axesH = [];
            end
            this.lineH = line(this.axesH,lineProperties);

        end

        function didSet = setAxesHandle(this, axesH)
            if isa(axesH, 'matlab.graphics.axis.Axes')
                this.axesH = axesH;
                % this.figureH = getParentFigure(this.axesH);

                didSet = true;
                if ~ishandle(this.lineH)
                    this.createLine();
                else
                    set(this.lineH, 'parent', this.axesH);
                end

            else
                didSet = false;
            end
        end
    end
end