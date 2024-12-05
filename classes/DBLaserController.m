classdef DBLaserController < DBController
    events
        DBLasing;
    end
    properties(Constant)
        SUPPORTED_LASERS = {
            'A';
            'B';
            };
    end

    methods

        function laseOff(obj)
            laser = obj.getLaser();
            if ~isempty(laser)
                laser.turnOff();
            end
        end

        function lase(obj, positionOrDrone)
            laser = obj.getLaser();
            if ~isempty(laser)
                if isa(positionOrDrone,'DBDrone')
                    laser.fire(positionOrDrone);
                else
                    obj.laseLocation(positionOrDrone);
                end
            end
        end

        function laseLocation(obj, position, duration_s)
            laser = obj.getModel();
            if ~isempty(laser)
                if nargin<3
                    duration_s = 0.5;
                end
                laser.fire(position, duration_s);
            end
        end

        function reset(this)
            this.initModel();
        end

        function didInit = initModel(this)
            this.initPosition = [0, 0];
            didInit = false;
            laserObj = this.getModel();
            if isempty(laserObj)
                didInit = this.setModel('lasera');
            else
                laserObj.reset();
            end
        end

        function maxRange = getMaxRange(this)
            model = this.getModel();
            maxRange = 0;

            if ~isempty(model)
                maxRange = model.maxRange();
            end
        end

        function pos = getPosition(this)
            pos = [nan, nan];
            laser = this.getModel();
            if ~isempty(laser)
                pos = laser.position;
            end
        end
        
        function isIt = isLocationTargetable(this, location)
            isIt = false;
            laserRange = this.getMaxRange();
            laser = this.getModel();

            if ~isempty(laser) && laserRange>0
                dist = sqrt(sum((location - this.getPosition()).^2));
                isIt =  dist <= laserRange;
            end
        end

        function laserObj = getLaser(this)
            laserObj = this.getModel();
        end

        function didSet = setLaserType(this, laserType)
            didSet = this.setModel(laserType);
        end

        function didSet = setLaser(this, laserObjOrType)
            didSet = this.setModel(laserObjOrType);
        end

        function distances = getDistanceToDrones(this, drones)

            % distances = inf(size(drones));
            laserPos = this.getPosition();
            % if isscalar(drones)
            % 
            % end
            distances = arrayfun(@(x) calcDistance(laserPos, x.position), drones);
        end

        function [drone, distToDrone] = getClosestDrone(this, drones)
            drone = [];
            distToDrone = inf;
            if nargin>1 && ~isempty(drones)
                distances = this.getDistanceToDrones(drones);
                [~, idx] = sort(distances,'ascend');
                drone = drones(idx(1));
                distToDrone = distances(idx(1));
            end
        end

        function canIt = canItFire(this)
            laser = this.getModel();
            canIt = false;
            if ~isempty(laser)
                canIt = laser.canItFire();
            end
        end

        % drones are within range?
        function update(this, drones)
            % get the closest target to my position.

            shouldLase = false;

            % then fire at that drone
            if nargin>1 && ~isempty(drones)
                [drone, distToDrone] = this.getClosestDrone(drones); 
                shouldLase = ~isempty(drone) && distToDrone<=this.getMaxRange() && this.canItFire();
            end

            if shouldLase
                this.lase(drone);
            else
                this.laseOff();
            end
        end

        function didSet = setModel(this, laserObjOrType)

            didSet = false;
            curLaser = this.getModel();
            if ~isempty(curLaser)
                laserPos = curLaser.position;
            else
                laserPos = this.initPosition;
            end
            
            try
                tmpLaser = [];
                if isa(laserObjOrType,'DBLaser')
                    tmpLaser = laserObjOrType;
                elseif isa(laserObjOrType,'char')
                    switch lower(laserObjOrType)
                        case {'lasera','a', 'laser a'}
                            tmpLaser = DBLaserA(this.axesH, this.logH);
                        case {'laserb','b','laser b'}
                            tmpLaser = DBLaserB(this.axesH, this.logH);
                        otherwise
                            throw(MException('LaserController:InvalidLaser:Unrecognized','Unrecognized laser type provided: %s', laserObjOrType));
                    end
                end

                if isa(tmpLaser, 'DBLaser')

                    curModel = this.getModel();
                    if ~isempty(curModel)
                        delete(curModel);
                    end

                    tmpLaser.addlistener('DBLasing',@this.lasingCb);
                    tmpLaser.setAxesHandle(this.axesH);
                    tmpLaser.setPosition(laserPos);

                    this.modelObj = tmpLaser;
                    didSet = true;
                end

            catch me
                this.logError(me);
            end
        end

        function lasingCb(this, laserObj, lasedEvt)
            this.notify('DBLasing',lasedEvt);
        end

        % function blah(this)
        %     % Laser Selection Script
        %     % Choose which laser to create (LaserA or LaserB)
        %     laserChoice = 'LaserB';  % Set 'LaserA' or 'LaserB' here to select laser type
        %     % Dynamically create the laser object based on the laserChoice string
        %     switch laserChoice
        %         case 'LaserA'
        %             laserObj = DBLaserA();  % Dynamically create instance of LaserA
        %         case 'LaserB'
        %             laserObj = DBLaserB();  % Dynamically create instance of LaserB
        %         otherwise
        %             error('Invalid laser choice. Please select either LaserA or LaserB.');
        %     end
        % end
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