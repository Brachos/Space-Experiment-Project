clc
clear
%% Data and constant
% 6U Cube Sat
X_6U = 366e-3; %[m]
Y_6U = 226.3e-3; %[m]
Z_6U = 100e-3; %[m]
deployed = 0;
%% Components
% Position, x,y,z = (0,0,0) is geometric center of the satellite
mm = [];
xx = [];
[optic, xx, mm] = Prop(5.860, [0.05315 0 -0.048], xx, mm);
[battery, xx, mm] = Prop(0.700, [0.0475 0 0.094], xx, mm);
[transceiver, xx, mm] = Prop(0.200, [-0.0195 0 -0.058], xx, mm);
[ADCS, xx, mm] = Prop(1.230, [-0.057 0 0.013], xx, mm);
[therm_cont, xx, mm] = Prop(0.07, [0 0 0], xx, mm);
[data_handling, xx, mm] = Prop(2*0.208, [-0.02735 0 0.1075], xx, mm);
[struture, xx, mm] = Prop(0.850, [0 0 0], xx, mm);
[antenna,xx,mm] = Prop(0.02, [-0.03315 0 -0.033], xx, mm);
if deployed
    [solar_panel, xx, mm] = Prop(0.245, [0 0 0.366/2], xx, mm);
else
    [solar_panel, xx, mm] = Prop(0.245, [0 0 0.053], xx, mm);
end
power.dim = [];

battery.dim = [89 95 14];
Volume(battery);
M = sum(mm);

% Position center of gravity
x_cg = sum(xx(:,1).*mm)/M;
y_cg = sum(xx(:,2).*mm)/M;
z_cg = sum(xx(:,3).*mm)/M;

d = sqrt(x_cg^2 + y_cg^2 + z_cg^2);

I = [sum(mm.*(xx(:,2).^2 + xx(:,3).^2)) -sum(mm.*xx(:,1).*xx(:,2)) -sum(mm.*xx(:,1).*xx(:,3));
    -sum(mm.*xx(:,1).*xx(:,2)) sum(mm.*(xx(:,1).^2 + xx(:,3).^2)) -sum(mm.*xx(:,2).*xx(:,3));
    -sum(mm.*xx(:,1).*xx(:,3)) -sum(mm.*xx(:,2).*xx(:,3)) sum(mm.*(xx(:,1).^2 + xx(:,2).^2))];

[TD, h, theta_acc] = ADCS_fun(max(diag(I)),min(diag(I)));