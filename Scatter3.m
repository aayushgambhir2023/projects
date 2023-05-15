%Scatter3 was written by Aayush and William on June 15, 2022
%It plots the path of a photon travelling through a cloud layer extending from y =0 to y=ycl.
%y is the optical thickness of the cloud
%The photon scattering is found using either Isotropic, Raleigh, or Max Forward Scattering phase functions.
clear
N=input('Input Scattering type: 0 = Isotropic, 1 = Raleigh, 2 = Max Forward = '); %asking the user to enter which type of scattering
if (N==2)
   p=input('Input number of Legendre pairs (max is 5)='); %entering degree of legendre polynomail
end

%Define Max Forward Legendre Coefficients
w(1,1)=1;
w(2,1)=.3333;
w(1,2)=1;
w(2,2)=0.6;
w(3,2)=0.4;
w(4,2)=0.1714;
w(1,3)=1;
w(2,3)=0.7143;
w(3,3)=0.5714;
w(4,3)=0.3810;
w(5,3)=0.2381;
w(6,3)=0.1082;
w(1,4)=1;
w(2,4)=0.7778;
w(3,4)=0.6667;
w(4,4)=0.5108;
w(5,4)=0.3939;
w(6,4)=0.2681;
w(7,4)=0.1632;
w(8,4)=0.0761;
w(1,5)=1;
w(2,5)=0.8182;
w(3,5)=0.7273;
w(4,5)=0.5967;
w(5,5)=0.4988;
w(6,5)=0.3869;
w(7,5)=0.2937;
w(8,5)=0.2016;
w(9,5)=0.1209;
w(10,5)=0.0573;

%Evaluate Phase Functions
theta=0:0.01*pi:2*pi; 
Ntheta=201; %number of theta
MU=cos(theta); %calculating cos of theta

if (N==1) 
    PHRAY=0.75*(MU.^2+1)/1.5; %Evaluate Raleigh Phase Function/pmax  
else
    if(N==2)
        for i1=1:Ntheta %Loop from 1 to total number of theta
            MM=MU(i1); %using the cos of angles from 0 to 2pi
            Sum=0;
            for i2=1:2*p
                L=i2-1;
                Sum=Sum+legendreP(L,MM)*(2*L+1)*w(i2,p); %Using legendreP function to solve legrendre polynomial
            end
            PHFOR(i1)=Sum/(p*(p+1)); %Evaluate Max Forward Phase Function/pmax
        end
    end
end
ycl=20; %optical thickness

for thetainc = 0:10:90 %incident angle 
    thetainc2 = thetainc; %printing out the incident angle 
    NTOP = 0; %intializing number of photons exiting from top or bottom counter
    NBOT = 0; 
    NPHOT=2; %Number of incident photons 
    Dstep=0.1; %interval stepsize
    sprob=1-exp(-Dstep); %evaluate scatter probability
    thetaR(1)=thetainc/180*pi; %angle of incident ray incident at the origin
    thetaR(2)=thetaR(1);
    for i3 = 1:NPHOT %using a for loop to repeat loop for many photons
        x(1)=0; %starting position of photon
        y(1)=0;
        x(2)=Dstep*sin(thetaR(1)); %calculating x component for second x value 
        y(2)=Dstep*cos(thetaR(1)); %calculating x component for second y value 
        yy=y(2);
        i1 = 2; %Initialize scatter counter
        while (yy < ycl & yy> 0) %while the photon is in the cloud and below the optical thickness
            i1 = i1+1;
            srand=rand; 
            if (sprob<srand) %checking if a scattering event will occur
                thetaR(i1)=thetaR(i1-1); %No scatter occurs
            else
                if (N==0)
                    thetaR(i1)=thetaR(i1-1)+2*pi*rand; %Isotropic Scattering
                end
                if (N==1)
                    sangle=2*pi*rand; %random angle 
                    PRAY=interp1(theta,PHRAY,sangle,'spline'); %interpolating phase function for Rayleigh Scattering
                    PProb=rand; %random angle between 0 and 1
                    while (PRAY<PProb) %if probability is less than random number 
                        sangle=2*pi*rand;
                        PRAY=interp1(theta,PHRAY,sangle,'spline');
                        PProb=rand;
                    end
                    thetaR(i1)=thetaR(i1-1)+sangle; 
                end
                if (N==2)
                    sangle=2*pi*rand;
                    PFOR=interp1(theta,PHFOR,sangle,'spline');  %interpolating phase function for Forward Scattering
                    PProb=rand;
                    while (PFOR<PProb) %if probability is less than random number 
                        sangle=2*pi*rand;
                        PFOR=interp1(theta,PHFOR,sangle,'spline');
                        PProb=rand;
                    end
                    thetaR(i1)=thetaR(i1-1)+sangle;
                end
            end
            x(i1)=x(i1-1)+Dstep*sin(thetaR(i1)); %calculating x component of new direction
            y(i1)=y(i1-1)+Dstep*cos(thetaR(i1)); %calculating y component of new direction 
            yy=y(i1);
        end
        if yy <=0
            NBOT=NBOT+1; %if the y position is less than 0 than the photon exits from the bottom
        elseif yy>=ycl
            NTOP=NTOP+1; %if the y position is more than the optical thickness than the photon exits from the top
        end
        figure(1) 
        plot (x,y) %plotting x and y
        xlim([-ycl,ycl]) %setting limits
        ylim([-1,ycl+1])
        hold on
    end
    fprintf('Number photons exiting from cloud bottom is %d\n', NBOT); %print out total number of photons
    fprintf('Number photons exiting from cloud top is %d\n', NTOP);

end

ylabel('Optical thickness');
xlabel('Single scattering albedo');
title ('Random paths of photons');
hold off



