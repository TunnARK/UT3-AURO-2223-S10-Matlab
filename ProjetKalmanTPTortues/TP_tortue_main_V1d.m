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
H=eye(2,4);
xk1k=[];
P_k1k=[];


for i=1:(N-1)
    F_k=[1,0, (T(i+1)-T(i)), 0; 0, 1, 0, (T(i+1)-T(i)); 0,0,1,0; 0,0,0,1];
    G_k=[(T(i+1)-T(i)),0 ; 0,(T(i+1)-T(i)); 0,0; 0,0];

    % Prediction
    xk1k=[xk1k,F_k*x_kk(:,i)+G_k*u(:,i)];
    P_k1k=[P_k1k,F_k*Pkk(:,i:i+3)*F_k'+Qw]; %bruit de dynamique suppose stationnaire
%     
%     % Mise à jour
%     K(:,i+1)=P_k1k(:,i:i+3)*H'*inv((Rv+H*Pkk(:,i:i+3)*H')); %bruit de mesure suppose stationnaire
%     xk1k(:,i+1)=x(:,i+1)+K(:,i+1)*(Z(:,i+1)-H*x_k1k(:,i));
%     P_k1k(:,i+3:)=Pkk(:,i:i+3)- K(:,i+1)*H*Pkk(:,i:i+3);
    
    
    
end 



