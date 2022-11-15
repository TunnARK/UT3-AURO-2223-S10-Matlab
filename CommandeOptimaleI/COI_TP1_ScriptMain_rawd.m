%%%%%%
% TP1 Commande Optimale
% RONK et GABRIEL CALIXTE
%%%%%%

close all

%% Declaration des constantes
Km=9;
Tm=0.3;
Kg=0.105;
Ks=10;
Ke=10;

%% Modele EE
A=[0 1 ; 0 -1/Tm];
B=[0 ; (Km*Ke)/(9*Tm)];
C=[1 0];
D=[0]

EE=ss(A,B,C,D)


%% Etude de la stabilite 

EE_vp=eig(A)

%% Commandabilite et Observabilite

Co=rank(ctrb(A,B))

Ob=rank(obsv(A,C))

%% Resoltuion de l equation de Ricatti et analyse de la dynamique de la BF

R=100;
Q=eye(2);
G=-B*(1/R)*B';

[P,K,L]=icare(A,B,Q,R,[],[],G) %P solution, L valeurs propres de la BF et K gain du retour d etat


%% Etudes des marges de pahse et de gain

EE_bf=ss((A-B*K),B,C,D)

figure(1)
nyquist(EE_bf)
[Gm,Pm,Wcg,Wcp] = margin(EE_bf)

%% Trace de la reponse indicielle

figure(2)
step(EE_bf)
title('Reponse indicielle de la BF')
grid on
stepinfo(EE_bf)


%% Calcul d un precompensateur

GainStat=dcgain(EE_bf)

BF_precomp=(1/GainStat)*EE_bf

figure(3)
step(BF_precomp)
title('Reponse indicielle de la BF avec gain de precompensation')
stepinfo(BF_precomp)


%% Critere J parametre



