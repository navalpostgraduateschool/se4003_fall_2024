classdef (ConstructOnLoad) DBLasedOnEvt < event.EventData
   properties
       droneObj
       laserObj
       duration_sec
       timeStamp
   end

   methods
       function data = DBLasedOnEvt(droneObj, laserObj, duration_sec, varargin)
          data.droneObj = droneObj;
          data.duration_sec = 1/20;
          if nargin>1
              data.laserObj = laserObj;

              if nargin>2
                  data.duration_sec = duration_sec;
              end
          end
          data.timeStamp = datetime('now');
      end
   end
end