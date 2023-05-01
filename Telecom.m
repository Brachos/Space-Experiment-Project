% Script to determine useful parameters for the ground station and telecom
% part

% Link budget
P = 0; % Transmitter power
L_l = 0; % Line loss
G_t = 0; % Antenna gain
L_s = 0; % Space loss
L_a = 0; % Transmission path loss
G_r = 0; % Gain receiver antenna
T_s = 0; % receiver system noise temperature
k = 0; % Boltzmann constant
R = 0; % Data rate
lambda = 0; % Wavelength
S = 0; % Path length

Eb_N0 = (P * L_l * G_t * L_s * L_a * G_r)/(k * T_s * R); % Link budget