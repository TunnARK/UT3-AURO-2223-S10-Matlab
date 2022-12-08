%****************************%
%  RONK et GABRIEL CALIXTE   %
% TP1 Commande Non Linéraire %
% ***************************%

close all

%% Plan de phase 
% Recuperation des variables issues de Simulink et trace 
%lot(out.simout.signals.values(:,1),out.simout.signals.values(:,2))
%title('Plan de phase pour une CI=[10;10]')


%% Dynamique en boucle fermee
%Definition de la matrice dynamique
A=[0 1 ; -1 -1];
%Calcul des valeurs propre de la matrice dynamique
vp_A=eig(A)

%% Estimation du bassin d attraction par simulation

Tend=10; Tstep=0.001;
time=0:Tstep:Tend;


for Xinit = 0:5:100
    
    [tout,xout]=ode45(@fcNL,time,Xinit);
    plot(xout(:,1),xout(:,2))    
    hold on  
end 

hold off

% Declaration de la fonction pour resolution

function dxdt=fcNL(t,x)
    A=[0 1 ; 1 0];    

    if (-2*x(1)+x(2))>1 
        x(2)=x(1)+1;
        x(1)=x(2);
        dxdt=x;
    else
        if (-2*x(1)+x(2))<-1
           x(2)=x(1)-1;
           x(1)=x(2);
           dxdt=x;
        else 
            x(2)=-x(1)-x(2);
            x(1)=x(2);
            dxdt=x;
        end
    end 

end  