%%%%%%
% TP1 Commande Optimale
% RONK et GABRIEL CALIXTE
%%%%%%


%% Declaration des constantes
Km=9;
Tm=0.3;
Kg=0.105;
Ks=10;
Ke=10;

%% Modele EE
A=[0 1 ; 0 -1/Tm];
B=[0 ; (Km*Ke)/(9*Tm)];
C=[Ks 0];
D=[0]

EE=ss(A,B,C,D)


%% Etude de la stabilite 

EE_vp=eig(A)

%% Commandabilite et Observabilite

Co=rank(ctrb(A,B))

Ob=rank(obsv(A,C))