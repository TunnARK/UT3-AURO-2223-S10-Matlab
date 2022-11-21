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
C=[1 0]; % on veut la mesure de theta s pour avoir l'angle de sortie
D=[0]

EE=ss(A,B,C,D)


%% Etude de la stabilite 

EE_vp=eig(A)

%% Commandabilite et Observabilite

Co=rank(ctrb(A,B))

% ATX+XA−XBBTX+CCT=0

Ob=rank(obsv(A,C))


%% Ricatti Resolution

Q = eye(2);
R = 100;
[P,L,G] = care(A,B,Q,R)

[eig(A) eig(A-B*G)]

%% Analysis

yCLu = ss(A-B*G,B,C,D)

[Gm,Pm,Wcg,Wcp] = margin(yCLu)

stepinfo(yCLu)

step(yCLu)
grid on
