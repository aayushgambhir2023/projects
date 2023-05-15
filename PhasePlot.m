%PhasePlot was written by Aayush and William on June 15, 2022
%It plots the Isotropic, Raleigh and Max Forward scattering Phase Functions
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

Ntot=100; %Number of theta values
dtheta=2*pi/(Ntot-1);
p=input('Input value of p for max forward scattering(pmax=5) = ');
for i1=1:Ntot
    theta(i1)=dtheta*(i1-1);
    MM=cos(theta(i1));
    PISO(i1)=1; %Evaluate Isotropic Phase Function
    PRAY(i1)=0.75*(MM^2+1)/1.5; %Evaluate Raleigh Phase Function/pmax
    
    %Evaluate Max Forward Phase Function for Integer p
    Sum=0;
    for i2=1:2*p
        L=i2-1;
        Sum=Sum+legendreP(L,MM)*(2*L+1)*w(i2,p);
    end
    PFOR(i1)=Sum/(p*(p+1)); %Evaluate Max Forwrad Phase Function/pmax
end

figure(1)
    clf
    pax=polaraxes;
    polarplot(theta,PISO,'r--')
    hold on
    %grid off
    polarplot(theta,PRAY,'b','LineWidth',2)
    polarplot(theta,PFOR,'g','LineWidth',1)
    pax.ThetaDir = 'clockwise';
    pax.ThetaZeroLocation='top';
    pax.FontSize = 16;
    leg1=legend('Isotropic','Raleigh','Max Forward');
    set(leg1,'Box','off','Location','northwest')
    title('Plot of Scattering Phase Functions','Fontsize',16)
    rlim([0,1.5]) 
    thetaticks(0:45:315)
    rticks(0:.3:1.5)  
