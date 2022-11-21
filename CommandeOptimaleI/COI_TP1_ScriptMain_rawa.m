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
A=[0 1 ; 0 -1/Tm] ;
B=[0 ; (Km*Ke)/(9*Tm)] ;
C=[1 0] ; % on veut la mesure de theta s pour avoir l'angle de sortie
D=[0] ;

EE=ss(A,B,C,D) ;


%% Etude de la stabilite 

EE_vp=eig(A) ;

%% Commandabilite et Observabilite

Co=rank(ctrb(A,B)) ;

% ATX+XA−XBBTX+CCT=0

Ob=rank(obsv(A,C)) ;


%% Ricatti Resolution

Q = eye(2) ;
R = 100 ;
[P,L,G] = care(A,B,Q,R) ;

[eig(A) eig(A-B*G)] ;

%% Analysis

yCLu = ss(A-B*G,B,C,D)

[Gm,Pm,Wcg,Wcp] = margin(yCLu) ;

stepinfo(yCLu) ;

step(yCLu) ;
grid on

%% Precompensation

GainStat = dcgain(yCLu) ;

yNCLu = (1/GainStat)*yCLu ;

figure(1)
step(yNCLu) ;
title('Reponse indicielle de la BF avec gain de precompensation')
stepinfo(yNCLu) ;


%% Analyse of Q's Impact (R fixed at 100)

% Initialisation
vecQ = [1 1.5 2 2.5 3 4 6 10 GainStat 20 100 1000] ;
vecRiseTime = [] ;
Rloop = 100 ;

figure(2)
title('Evolution du gain de la BF en fonction de Q')
for i = 1:length(vecQ)
    Qloop = vecQ(i)*eye(2) ;
    [Ploop, Lloop, Gloop] = care(A,B,Qloop,Rloop) ;
    yCLuloop = ss(A-B*Gloop,B,C,D) ;
    Sloop = stepinfo(yCLuloop) ;
    vecRiseTime(i) = Sloop.RiseTime ;
    step(yCLuloop)
    hold on
end
hold off

figure(3)
plot(vecQ, vecRiseTime)
title('Evolution du temps de réponse en fonction de Q')