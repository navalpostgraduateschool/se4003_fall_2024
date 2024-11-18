classdef LaserB < Laser
    % Laser B subclass with specific properties

    properties
        OutputPower = 100;   % in kW
        ChargeTime = 15;      % in seconds
        Wavelength = 1.07;    % in micrometers
        DischargeRate = 1;    % in seconds
        NumBatteries = 5;     % number of batteries
        Range = 10;           % in km
    end
end
