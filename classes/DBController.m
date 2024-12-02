classdef DBController < DBBase

    properties(SetAccess=protected)
        modelObj;
        axesH;   % if it controls an axes or has a model that requires an axes (e.g DBGraphicItem) 
        panelH;  % if it controls a panel
    end

    properties
        initPosition = [nan, nan];
    end

    methods

        function obj = DBController(varargin)
            % call parent constructor
            obj@DBBase(varargin{:});

            % create model as necessary;
            obj.initModel();
        end

        function pos = getPosition(this)
            model = this.getModel();
            pos = [nan, nan];
            if ~isempty(pos)
                pos = model.getPosition();
            end
        end

        function didSet = setPosition(this, modelPos)
            model = this.getModel();
            didSet = false;
            if ~isempty(model)
                if numel(model)>1
                    didSet = all(arrayfun(@(m)(m.setPosition(modelPos)), model,'UniformOutput',true));
                else
                    didSet = model.setPosition(modelPos);
                end
            end
        end
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

        % overload this method to initialize as appropriate.
        function didInit = initModel(this)
            didInit = false;
        end

        function didSet = setModel(this, modelIn)
            this.modelObj = modelIn;
            didSet = true;
        end

        function modelObj = getModel(this)
            modelObj = this.modelObj;
            if ~isempty(modelObj)
                if ~isa(modelObj, 'DBModel')
                    modelObj = [];
                end
            end
        end

        function didSet = setAxesHandle(this, axesH)
            if isa(axesH, 'matlab.graphics.axis.Axes')
                this.axesH = axesH;
                didSet = true;

                model = this.getModel();

                if ~isempty(model)
                    model.setAxesHandle(axesH);
                end
            else
                didSet = false;
            end
        end
    end
end