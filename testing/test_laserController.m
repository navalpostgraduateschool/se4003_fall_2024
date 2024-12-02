clear all;
close all;
clc;
passed = false;

try

    axesH = initAxes();
    DBEnvironment(axesH);
    laserController = DBLaserController(axesH);
    
    targetLocation = [50,50];
    target = line(axesH,targetLocation(1), targetLocation(2),'linestyle','none','marker','hexagram',...
        'markersize',20, ...
        'markeredgecolor','white',...
        'markerfacecolor','black');
    
    disp('Moving laser to [4, 0]');
    pause(1);
    laserController.setPosition([4,0]);
    laserController.laseLocation(targetLocation,3.0);
    
    disp('Setting laser type to B');
    pause(.5);
    laserController.setLaserType('B');
    
    disp('Moving laser to [-4, 0]');
    pause(0.5);
    laserController.setPosition([-4,0]);
    
    
    % laserController.setLaserType('B');
    passed = true;
catch me
    showME(me);
end

if passed
    disp('Laser controller passed');
else
    disp('Laser controller failed');
end