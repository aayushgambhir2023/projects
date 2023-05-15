%ReflectanceGraphs was written by Aayush on June 22, 2022
%ReflectanceGraphs reads the data from "CloudLayerReflectance June 21,
%2022" and plots the graph of reflectance for the three type of scatterings
%Isotropic Scattering
clear
NPHOT = 1e+5; %Number of photons 
Dstep = 0.001; %stepsize
[num,txt,raw]= xlsread('CloudLayerReflectance June 21, 2022.xlsx'); %reading from excel file 
for i = 1:10 %running loop for number of elements 
    theta(i)= num (i,3); %getting the theta values 
    ycl1 (i)= num (i,4); %getting the reflectance numbers for optical thickness = 1
    ycl2(i)= num (i,5);
    ycl5(i)= num (i,6);
    ycl20(i)= num (i,7);
end
figure (1)
plot(theta, ycl1,'LineWidth',2) %plotting
hold on
plot(theta, ycl2,'LineWidth',2)
plot(theta, ycl5,'LineWidth',2)
plot(theta, ycl20,'LineWidth',2)
ylabel('Reflectance');
ylim([0 1]);
xlabel('Incident Angle (degrees)');
title ('Isotropic Scattering');
leg1 = legend({'tau = 1', 'tau=2', 'tau=5', 'tau=20'});
set(leg1,'Box','off', 'Location', 'southeast')
hold off

% Rayleigh Scattering
c1 = 0; %number of reflectances
for i2 = 20:29 %getting reflectance from row 20 to 29
    c1 = c1+1; %counter till 9
    yclR1 (c1) =num (i2,4);
    yclR2(c1)= num (i2,5);
    yclR5(c1)= num (i2,6);
    yclR20(c1)= num (i2,7);
end
figure (2)
plot(theta, yclR1,'LineWidth',2)
hold on
plot(theta, yclR2,'LineWidth',2)
plot(theta, yclR5,'LineWidth',2)
plot(theta, yclR20,'LineWidth',2)
ylabel('Reflectance');
ylim([0 1]);
xlabel('Incident Angle (degrees)');
title ('Rayleigh Scattering');
leg2 =legend({'tau = 1', 'tau=2', 'tau=5', 'tau=20'});
set(leg2,'Box','off', 'Location', 'southeast')
hold off

%Forward Scattering
c2= 0;
for i3 = 35:44
    c2 = c2+1;
    yclF1 (c2) =num (i3,4);
    yclF2(c2)= num (i3,5);
    yclF5(c2)= num (i3,6);
    yclF20(c2)= num (i3,7);
end
figure (3)
plot(theta, yclF1,'LineWidth',2)
hold on
plot(theta, yclF2,'LineWidth',2)
plot(theta, yclF5,'LineWidth',2)
plot(theta, yclF20,'LineWidth',2)
ylabel('Reflectance');
ylim([0 1]);
xlabel('Incident Angle (degrees)');
title ('Forward Scattering');
leg3 = legend({'tau = 1', 'tau=2', 'tau=5', 'tau=20'});
set(leg3,'Box','off', 'Location', 'southeast')
hold off