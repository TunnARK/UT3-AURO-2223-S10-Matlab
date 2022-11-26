%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TP - Migration des tortues luth
%RONK Antoine
% Damien GABRIEL CALIXTE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
close all
clear all

%% Remplissage des donnnees 
load turt8.data
[N,T,Z,u,F,G,H,mX0,PX0,Qw,Rv,X]=simulationDonnees;


%% Filtrage de Kalman 

% Initialisation

x_kk=mX0; 
Pkk=PX0;
xk1k(:,1)=mX0;



for i=2:N
   

    % Prediction
    xk1k(:,i)=F*x_kk(:,i-1)+G*u(:,i-1);
    P_k1k=F*Pkk*F'+Qw; %bruit de dynamique suppose stationnaire
 
     % Mise à jour
    K=P_k1k*H'*inv((Rv+H*Pkk*H')); %bruit de mesure suppose stationnaire
    x_kk(:,i)=xk1k(:,i)+K*(Z(:,i)-H*xk1k(:,i));
    P_kk=P_k1k-K*H*P_k1k;
    
    
    
end 

figure(3)
hold on
p1=plot(X(1,:),X(2,:));
p2=plot(xk1k(1,:),xk1k(2,:));
legend([p1 p2],'Xreel','Xestime');
title("Comparaison des trajectoires reconstruites par le filtre et reelles")
hold off


%% Qualification de l estimation

Xerr=X-xk1k; % erreur d estimation


plot(T,Xerr(1,:))
title('Tracé de l erreur d estimation')




