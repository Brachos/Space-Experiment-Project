function [TD, h, theta_acc] = ADCS_fun(Izz,Ixx)

% Data and constants
phi = 1361; %solar constant on the satellite, [W m^-2]
alt = 561e3; %altitude, [m]
mu = 3.986004418e14; %earth gravity parameter, [m^3 s^-2]
R = 6378000 + alt; %distance from earth center, [m]
c = 3e8; %speed of light, [ms^-1]
As = 6*0.1^2; %sunlit area, [m^2]
q = 0.6; %refectance factor
P = (60 + 36)*60; %period time, [s]
e = 2*50; %twice the ground sampling distance
s = 8.9054e+04; %swath, [m]
dist_center = 0.1; % cps - cm
% Gravity torque
Tg = 3*mu/(2*R^3)*abs(Izz - Ixx);

% Solar pressure torque
Ts = phi/c * As * (1+q)*dist_center;

TD = Tg + Ts;

h = TD*1.25 * P * 0.707/4; %wheel momentum
% Pointing accuracy
theta_acc  = atan((e + s/2)/alt) - atan(s/2/alt); % in RADIANS