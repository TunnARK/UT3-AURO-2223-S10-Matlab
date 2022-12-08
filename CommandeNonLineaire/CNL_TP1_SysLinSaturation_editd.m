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


% for Xinit= 100*rand(2,1000)  
%     [tout,xout]=ode45(@fcNL,time,Xinit);
%     plot(xout(:,1),xout(:,2))
%     hold on
%     title('Estimation du bassin d attraction par simulation')    
% end 
% for i= 1:1:1000  
%     [tout,xout]=ode45(@fcNL,time,[-10+20*rand;-10+20*rand]);
%     plot(xout(:,1),xout(:,2))
%     hold on
%     axis([-5 5 -5 5])
%     title('Estimation du bassin d attraction par simulation')    
% end 



%% Recherche d une fonction de Lyapunov

Q = eye(2);
P = lyap(A,Q)


%% Definition de la fonction pour estimer le basser d attraction

function dxdt=fcNL(t,x)
    A=[0 1 ; 1 0];
    u=-2*x(1)-x(2);
    if u > 1
        dxdt = A*x + [0; 1];
    else 
        if u < -1
            dxdt = A*x + [0; -1];
        else
            dxdt = A*x + [0; u];
        end
    end
%     if u>1 % Cas avec u>1
%         dxdt=A*x+[0;1];
%     end 
% 
%     if u<-1 % Cas avec u<-1
%        dxdt=A*x+[0; -1];
%     end 
%     
%     if (u>=-1 || u<=1) % Cas avec u dans [-1;1]   
%             dxdt=A*x+[0;1]*u;
%     end
end  
