function powerin = powerin(x,y,cond)
    if nargin <3
        cond = 'normal';
    end
    ds = 0;                  % spot size, m 
    Wavelength = 1.07*10^-6; % 1.07micrometer
    range = sqrt(x^2+y^2);   % range to UAV
    D = 0.3;                 % mirror diameter, m
    Tm = 933;                % melting temp Aluminium ,K
    Ta = 298;                % ambient temp, K 
    Cp = 897;                % specific heat capacity J/(kg*K)
    dH = 400;                % Heat of Fusion KJ/kg
    ro = 2700;               % density, kg/m^3
    h = 0.003;               % thickness, m
    epsilon = 0.05;          % emmisivity
    sigma = 5.67*10^8;       % Stefan-Boltzman Constant, J/(m^2*s*K^4)
    dx = 0.02;               % Gradient, m
    k = 237;                 % Thermal conductivity, W/(m*K)
    tau = 10;                % Dwell Time, s

    %calculate spot size by Reyligh equation
    ds = (1.22*Wavelength*range)/D;

    %Calculate melting heat
    dt = Tm - Ta;
    Q1 = Cp*m*dt;

    %Calculate melt heat
    As = 3.14*(ds/2)^2;       % spot area, m 
    m = ro*As*h;
    Q2 = m*dH;

    %Calculate radiation loss
    Prad = epsilon * sigma * As * (Tm^4 - Ta^4);

    % Calculate condactivity loss

    Pcond = k * As * (Tm - Ta) / dx;

    % Total energy

    I = (((Q1+Q2)/tau)+ (Pcond +Prad))/As;




    

end 