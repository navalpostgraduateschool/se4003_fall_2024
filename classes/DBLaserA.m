classdef LaserA < Laser
    % Laser A subclass with specific properties

    properties
        OutputPower = 60;    % in kW
        ChargeTime = 10;      % in seconds
        Wavelength = 1.07;    % in micrometers
        DischargeRate = 1;    % in seconds
        NumBatteries = 3;     % number of batteries
        Range = 5;            % in km
    end
end
