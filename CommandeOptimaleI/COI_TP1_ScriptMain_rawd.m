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


%% Reglage des parametres du critere J

% Test 1 en dimuinuant les coeffs

R2=100;
Q2=1/2*eye(2);
G2=-B*(1/R2)*B';
[P2,K2,L2]=icare(A,B,Q2,R2,[],[],G2) 
EE_bf2=ss((A-B*K2),B,C,D)

%Test 2 en augmentant les coeffs
R3=100;
Q3=3/2*eye(2);
G3=-B*(1/R3)*B';
[P3,K3,L3]=icare(A,B,Q3,R3,[],[],G3) 
EE_bf3=ss((A-B*K3),B,C,D)


%Test 3 en privilegiant la minimisation de la position angulaire

R4=100;
Q4=[100 0 ; 0 1];
G4=-B*(1/R4)*B';
[P4,K4,L4]=icare(A,B,Q4,R4,[],[],G4) 
EE_bf4=ss((A-B*K4),B,C,D)


% Test 4 en privilegiant la minimisation de la vitesse angulaire


R5=100;
Q5=[1 0 ; 0 100];
G5=-B*(1/R5)*B';
[P5,K5,L5]=icare(A,B,Q5,R5,[],[],G5) 
EE_bf5=ss((A-B*K5),B,C,D)


%Traces

figure(4)
subplot(2,2,1)
step(EE_bf2)
title('Réponse indielle avec Q=diag[1/2 1/2]')
subplot(2,2,2)
step(EE_bf3)
title('Réponse indicielle avec Q=diag[3/2 3/2]')
subplot(2,2,3)
step(EE_bf4)
title('Réponse indicielle avec Q=dag[100 1]')
subplot(2,2,4)
step(EE_bf5)
title('Réponse indicielle avec Q=diag[1 100]')


%% Etude des performances et de la stabilite de la boucle fermee pour un R et un Q choisis
Gain3=dcgain(EE_bf3)
BF_precomp3=(1/Gain3)*EE_bf3
VP_bf3=eig(BF_precomp3)

figure(5)
nyquist(BF_precomp3)

figure(6)
step(BF_precomp3)
title('Réponse indicielle du système en BF pour Q et R choisies')
stepinfo(BF_precomp3)



