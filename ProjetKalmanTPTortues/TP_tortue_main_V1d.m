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
xk1k=[];



for i=1:(N-1)
    F_k=[1,0, (T(i+1)-T(i)), 0; 0, 1, 0, (T(i+1)-T(i)); 0,0,1,0; 0,0,0,1];
    G_k=[(T(i+1)-T(i)),0 ; 0,(T(i+1)-T(i)); 0,0; 0,0];

    % Prediction
    xk1k(:,i+1)=F*x_kk(:,i)+G*u(:,i);
    P_k1k=F*Pkk*F'+Qw; %bruit de dynamique suppose stationnaire
 
%     % Mise à jour
    K=P_k1k*H'*inv((Rv+H*Pkk*H')); %bruit de mesure suppose stationnaire
    xk1k(:,i+1)=xk1k(:,i+1)+K*(Z(:,i+1)-H*xk1k(:,i));
    P_k1k=Pkk-K*H*Pkk;
    
    
    
end 



