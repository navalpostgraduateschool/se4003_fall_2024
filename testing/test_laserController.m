clear all;
close all;
clc;
passed = false;
try

axesH = initAxes();
laserController = DBLaserController(axesH);
passed = true;
catch me
    showME(me);
end

if passed
    disp('Laser controller passed');
else
    disp('Laser controller failed');
end