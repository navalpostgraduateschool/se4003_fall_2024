classdef DBLaserController < DBController
    properties(Constant)
        SUPPORTED_LASERS = {
            'A';
            'B';
            };
    end

    methods

        % function this = DBLaserController()
        % end

        function didSet = setLaser(this, laserObjOrType)
            didSet = this.setModel(laserObjOrType);
        end

        function didInit = initModel(this)
            didInit = false;
            laserObj = this.getModel();
            if isempty(laserObj)
                didInit = this.setModel('lasera');
            else
                laserObj.reset();
            end
        end

        function laserObj = getLaser(this)
            laserObj = this.getModel();
        end

        function didSet = setModel(this, laserObjOrType)
            didSet = false;
            try
                tmpLaser = [];
                if isa(laserObjOrType,'DBLaser')
                    tmpLaser = laserObjOrType;
                elseif isa(laserObjOrType,'char')
                    switch lower(laserObjOrType)
                        case {'lasera','a'}
                            tmpLaser = DBLaserA(this.axesH, this.logH);
                        case {'laserb','b'}
                            tmpLaser = DBLaserB(this.axes, this.logH);
                        otherwise
                            throw(MException('LaserController:InvalidLaser:Unrecognized','Unrecognized laser type provided: %s', laserObjOrType));
                    end
                end

                if isa(tmpLaser, 'DBLaser')
                    this.modelObj = tmpLaser;
                    tmpLaser.setAxesHandle(this.axesH);
                    didSet = true;
                end

            catch me
                this.logError(me);
            end
        end

        function blah(this)

            % Laser Selection Script
            % Choose which laser to create (LaserA or LaserB)

            laserChoice = 'LaserB';  % Set 'LaserA' or 'LaserB' here to select laser type

            % Dynamically create the laser object based on the laserChoice string
            switch laserChoice
                case 'LaserA'
                    laserObj = DBLaserA();  % Dynamically create instance of LaserA
                case 'LaserB'
                    laserObj = DBLaserB();  % Dynamically create instance of LaserB
                otherwise
                    error('Invalid laser choice. Please select either LaserA or LaserB.');
            end
        end

    end

    methods(Static)
        function description = getDescription()
            description = 'Laser controller class.';

        end

        % returns a list (cell) of laser classes that are supported by this
        % ctonroller.
        function supportedLasers = getSupportedLasers()
            supportedLasers = {
                @DBLaserA;
                @DBLaserB;
            };
        end


    end
end