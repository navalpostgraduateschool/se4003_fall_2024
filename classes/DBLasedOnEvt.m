classdef (ConstructOnLoad) DBLasedOnEvt < event.EventData
   properties
       droneObj
       laserObj
       duration_sec
       timeStamp
       inducedPower
   end

   methods
       function data = DBLasedOnEvt(droneObj, laserObj, duration_sec,inducedPower,varargin)
          data.droneObj = droneObj;
          data.duration_sec = 1/20;
          if nargin>1
              data.laserObj = laserObj;
              if nargin>2
                  data.duration_sec = duration_sec;
                  if nargin > 3
                      data.inducedPower = inducedPower;
                  end
              end
          end
          data.timeStamp = datetime('now');
      end
   end
end