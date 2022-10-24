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

x_obsv={mX0}; 
P_obsv={PX0};

% Prediction



