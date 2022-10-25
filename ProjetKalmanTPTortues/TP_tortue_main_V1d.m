%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TP - Migration des tortues luth
%RONK Antoine
% Damien GABRIEL CALIXTE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
close all
clean all

%% Remplissage des donnnees 
load turt8.data
[N,T,Z,u,F,G,H,mX0,PX0,Qw,Rv,X]=simulationDonnees;


%% Filtrage de Kalman 

% Initialisation

x_obsv=mX0; 
P_obsv=PX0;

for k=1:(N-1)
    F_predi=[1,0, (T(k+1)-T(k)), 0; 0, 1, 0, (T(k+1)-T(k)); 0,0,1,0; 0,0,0,1];
    G_predi=[(T(k+1)-T(k)),0 ; 0,(T(k+1)-T(k)); 0,0; 0,0];

    % Prediction
    x_predi(:,k+1)=F_predi*x_obsv(:,k)+G_predi*u(:,k);
    P_predi(k+4:k+7,:)=F_predi*P_obsv(k:k+3,:)*transpose(F_predi)+Qw %bruit de dynamqiue suppose staionnaire
    
    
    
end 



