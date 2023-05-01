% Script to determine useful paramters for the data handling and detectors
% part
clear
% Relation between the focal distance and the pixel size
focal_distance = 0.1402; %[m]
GSD = 50; % Ground sampling distance [m]
altitude = 561000; % [m]
pixel_size = GSD * focal_distance / altitude; % [m] first approx = 12.5 ?m

fprintf('The pixel size is about %.4f micrometer. \n', pixel_size*10^6);

n_period = 15; % Number of period a day [-]
revisit_time = 1; % Time to have the same point in the swath again [day] 
repeat_cycle = 15; % Time to be exactly above the same point again [day]
earth_radius = 6378*10^3; % Radius of the earth [m]
earth_circumference = 2 * pi * earth_radius; % Circumference of the earth [m]
swath = (earth_circumference/(n_period*2*repeat_cycle)); % Length of a swath to cover the earth in one repeat cycle [m]
swath2 = 2048*50;

total_size = swath/altitude * focal_distance; % Total pixel size [m]
N = total_size/pixel_size; % Number of pixels in one direction [-]
%=N = 2048;
M = 1;
% N = Number of pixels in x-direction [-] first approx = 1280
% M = Number of pixels in y-direction [-] first approx = 1024

fprintf('The total number of pixels is about %.0f x %.0f.\n', N,M);

P = N * M; % Number of pixels [-]
B = 12; % Color depth [bits] arbitrary chosen for the first iteration
% Same depth of imaging than the one used in GHGSAt
% Color depth :
% 1, 8, 16, 24
% The higher the color depth, the more information we obtain
% 2^B level of gray
image_size = (N * M * B)/(8 * 1024); % [kbytes]

fprintf('The image size is about %.4f Mbytes.\n', image_size/10^3);

T_i = 0.0066; % Integration time
half_duration_orbit = 0;

Nmin = S_earth/(N*50*M*50); % Minimum number of images after the entire scan
Nmax = half_duration_orbit/T_i;

data_min = image_size*Nmin; % Minimum amount of data after the entire scan [kbytes]
data_min_orbit = data_min/repeat_cycle; % Minimum amount of data after one orbit [kbytes]
data_max = image_size*Nmax; % Maximum amount of data after the entire scan [kbytes]
data_max_orbit = data_max/repeat_cycle; % Maximum amount of data after one orbit [kbytes]

% No information about mass and volume
% mass = 0.027; % Mass of the camera using this sensors [kg]
% volume = 0.0254 * 0.0254 * 0.0253; % Volume of the camera [m^3]
% Based on the CAPELLA
T = [-40, 70]; % Interval of termperature for this type of camera
Power = 4.6; % Power consumption of the camera [W]
QE = 0.8; % Quantum efficiency at 550 nm [%]