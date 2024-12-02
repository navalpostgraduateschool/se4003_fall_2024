classdef (ConstructOnLoad) DBLogEvt < event.EventData
   properties
       msg
       timeStamp
   end

   methods
      function data = DBLogEvt(fmtStr, varargin)
          data.msg = sprintf(fmtStr, varargin{:});
          data.timeStamp = now;
      end
   end
end