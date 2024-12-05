function powerin = powerdistancecalc(x, y, cond, initialpower)
    if nargin < 4
        error('Initial power must be provided as an input.');
    end
    
    if nargin < 3
        cond = 'normal';
    end

    % Constants
    Wavelength = 1.07*10^-6;  % 1.07micrometer
    D = 0.3;                  % mirror diameter, m
    alphaa = 10^-3;           % Aerosol Absorption in 1/km
    betaa = 0.1;              % Aerosol Scattering
    alpham = 0.01;            % Molecular Absorption 1/km
    betam =  10^-3;           % Molecular Scattering 1/km

    % Calculate range to target (distance)
    range = sqrt(x^2 + y^2);  % range to UAV

    % Calculate spot size using Rayleigh criterion
    ds = (1.22 * Wavelength * range) / D;

    % Calculate excitation coefficient
    e1 = alpham + alphaa + betam + betaa;

    % Calculate the power at the target after distance effects
    powerin = initialpower * exp(-e1 * range);
end
