clc
clear
%% Data and constant
% 6U Cube Sat
X_6U = 0.2; %[m]
Y_6U = 0.3; %[m]
Z_6U = 0.1; %[m]

%% Components
% Position, x,y,z = (0,0,0) is geometric center of the satellite
mm = [];
xx = [];
[optic, xx, mm] = Prop(0.13, [-0.05 0.015 0], xx, mm);
[telecom, xx, mm] = Prop(0.875, [-0.05 -0.010 0], xx, mm);
[ADCS, xx, mm] = Prop(3.1, [0 0 0], xx, mm);
[therm_cont, xx, mm] = Prop(0.07, [-0.05 -0.075 0], xx, mm);
[data_handling, xx, mm] = Prop(0.16, [0.05 0.075 0], xx, mm);
[struture, xx, mm] = Prop(1.23, [0 0 0], xx, mm);
[power, xx, mm] = Prop(0.104, [0.1 0 0], xx, mm);
[battery, xx, mm] = Prop(0.268, [0.05 0 0], xx, mm);
M = sum(mm);

% Position center of gravity
x_cg = sum(xx(:,1).*mm)/M;
y_cg = sum(xx(:,2).*mm)/M;
z_cg = sum(xx(:,3).*mm)/M;

d = sqrt(x_cg^2 + y_cg^2 + z_cg^2);

I = [sum(mm.*(xx(:,2).^2 + xx(:,3).^2)) -sum(mm.*xx(:,1).*xx(:,2)) -sum(mm.*xx(:,1).*xx(:,3));
    -sum(mm.*xx(:,1).*xx(:,2)) sum(mm.*(xx(:,1).^2 + xx(:,3).^2)) -sum(mm.*xx(:,2).*xx(:,3));
    -sum(mm.*xx(:,1).*xx(:,3)) -sum(mm.*xx(:,2).*xx(:,3)) sum(mm.*(xx(:,1).^2 + xx(:,2).^2))];