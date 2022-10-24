% VIRCRV TP1 Grp2 Gabriel/Ronk
% Version 0.20
% Last modified 2022/10/21 11:10

%% INITIALISATION
clc
clear all
close all

% Geometrie du robot
h = 0.8;
L1 = 0.4;
L2 = 0.4;
L3 = 0.2;

% Mesures renvoyees par la camera (position de la piece a saisir dans Rc):
xP = 0.5; yP = 0.2; 

% Differentes configurations de test pour les MGD/MGI
Q1 = zeros(1,4);
Q2 = [pi/2 0 0 0];
Q3 = [0 pi/2 0 0];
Q4 = [0 0 -0.5 pi/2];
Q5 = [pi/2 pi/2 -0.5 0];

% Parametres des actionneurs
r = 1/200; % rapport de reduction
Km = 0.3; % constante de couple
R = 1; % resistance induit
B = 1/80; % coefficient de frottement
Jeff1 = 0.02; % Inertie efficace articulation 1
Jeff2 = 0.01; % Inertie efficace articulation 2

% Gains de commande
K1=[0.267 0.225];
N1=0.267;
K2=[0.3 0.158];
N2=0.3;

% Vecteur temps simu trajectoire BF
t=[0:0.05:4];

%% CONFIGURATION
% Choix de la config de test parmi celles definies au-dessus (ou d'autres a votre discretion)
q = Q1 ;

%% SECTION 2.1

% Calcul MGD
T04 = calculT04(q);

% Verfication du MGD
q_test21 = [pi pi/2 -1 0] ;
T04q = calculT04(q_test21);
v_test21 = T04q * [1   ; 0.5  ; 1   ; 1] ;
figure(1)
drawBM(q_test21) ;
hold on
drawFrame(T04q,'R4',0.3) ; % repere scaled at 0.3
hold off
% ATTENTION TO4 depend de la config q donc il faut que q soit le meme que le parametre donne a drawBM



%% SECTION 2.2

% Q2.2.1

% Matrice de passage homgene entre R0 et RC
T0C= calculT0C(q)

% Affichage de l'orientation de Rc
figure(2)
drawBM(Q1) ;
hold on
drawFrame(T0C,'RC',0.1) ; % repere scaled at 0.1
hold off
% ATTENTION TOC depend de la config q donc il faut que q soit le meme que le parametre donne a drawBM

% Q2.2.2

% Determination de la situation de la piece dans R0 
P_R0=T0C*[xP; yP ;h; 1]; % position objet dans RO
P_Rp=[xP; yP ;h; 1]; % position objet donnee par la camera dans Rc

% Position objet donnee par la camera dans R0
Rp=[
    1   0   0   P_R0(1)   ; % pas de rotation sur xyz car meme orientation que R0
    0   1   0   P_R0(2)   ; 
    0   0   1   P_R0(3) ; 
    0   0   0   1    ]

% Validation
figure(3)
drawBM(q)
hold on
drawFrame(Rp,'Rcp',0.1)
drawFrame(T0C,'Rop',0.1)
hold off

% Q2.2.3 cf compte rendu

% Q2.2.4

% Calcul du MGI et verification
Qsol=mgi_mitsu(Rp) ;
Qsol1=Qsol(:,1) ; % sol1: configuration du robot pour atteindre la piece
Qsol2=Qsol(:,2) ; % sol2: configuration du robot pour atteindre la piece

% Affichage MGI
figure(4)
drawBM(Qsol1)
drawFrame(calculT04(Qsol1),'Routils',0.3)
figure(5)
drawBM(Qsol2)
drawFrame(calculT04(Qsol2),'Routils',0.3)


%% SECTION 2.3

% Determination des representations d etat des actionneurs

A1=[0 1 ; 0 -B/Jeff1];
B1=[0; Km/(R*Jeff1)];
C1=[1 0];

A2=[0 1 ; 0 -B/Jeff2];
B2=[0; Km/(R*Jeff2)];
C2=[1 0];

D=0;

% Mise sous forme EE
EE1=ss(A1,B1,C1,D);
EE2=ss(A2,B2,C2,D);

% Valeur de consigne
q1_star=Qsol1(1);
q2_star=Qsol1(2);

        
% Reponse indicielle des actionneurs seuls
figure(6)     
subplot(1,2,1)
plot(step(q1_star*EE1))
subplot(1,2,2)
plot(step(q2_star*EE2))

        
% Calcul du retour d etat
    
Ar1=A1-B1*K1;
Br1=B1*N1;

Ar2=A2-B2*K2;
Br2=B2*N2;

% Representation EE de la boucle fermee
retour_et1=ss(Ar1,Br1,C1,D);
retour_et2=ss(Ar2,Br2,C2,D);

% Reponse indicielle pour la boucle fermee
figure(7)
subplot(1,2,1)
plot(step(q1_star*retour_et1))
subplot(1,2,2)
plot(step(q2_star*retour_et2))
	
% Dessin de la trajectoire 
drawTraj(retour_et1,retour_et2,q1_star,q2_star,t,h,P_R0(1),P_R0(2),P_R0(3),1)