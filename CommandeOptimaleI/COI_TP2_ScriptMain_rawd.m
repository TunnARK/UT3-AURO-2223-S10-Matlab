%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TP2 Commande Optimale
% RONK Antoine et GABRIEL CALIXTE Damien
% Seance de 30 novembre 2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all
close all


%% Constantes

g=9.81;

N1=3e-5;
N2=0.5e-5;

S1=0.0154;
S2=0.0154;

c1=0.4753;
c2=0.9142;

C1=c1*2*sqrt(2*g);
C2=c2*2*sqrt(2*g);

%% Modele lineaire 

A=[(-1/S1)*C1*(1/2*sqrt(N1)) 0 ; (-1/S2)*C1*(1/2*sqrt(N1)) (-1/S2)*C2*(1/2*sqrt(N2))];

B=[1/S1 ; 1/S2];

C=[0 S2];

D=[0];

EE=ss(A,B,C,D)

O=obsv(A,C);

observabilite=rank(O)


%% Commande optimale sans considerer la fuite

Q=eye(2);
R=eye(2);
P=Q;


