% base class for duck blind classes and applications that build off it
classdef (Abstract) DBBase < handle
    properties(SetAccess=private)
        version = '1.0';
        logH; % text handle for displaying things to a log..Instance of matlab.ui.control.TextArea
    end

    methods

        function obj = DBBase(varargin)
            obj.setConstructorArguments(varargin{:});
         end

        function didSet = setConstructorArguments(obj, varargin)
            didSet = false;

            % When done this way, the first valid log handle is going to be
            % set and the remaining ones, if present, will not be used/set.
            for n=1:numel(varargin)
                didSet = didSet || obj.setLogHandle(varargin{n});
            end
        end

        function didSet = setLogHandle(this, textAreaH)
            if isa(textAreaH, 'matlab.ui.control.TextArea')
                this.logH = textH;
                didSet = true;
            else
                didSet = false;
            end
        end


        function logError(this, me, varargin)
            showME(me);
            this.log(varargin{:})
        end

        function log(this, msgTxt, varargin)
            if ishandle(this.logH)

            else
                this.logConsole(msgTxt, varargin{:});
            end

        end
    end

    methods(Abstract, Static)
        getDescription;
    end
    methods(Static)
        function logConsole(fmtStr, varargin)
            fprintf(1, fmtStr, varargin{:});
            % add a line break
            fprintf(1,'\n');
        end

    end


end