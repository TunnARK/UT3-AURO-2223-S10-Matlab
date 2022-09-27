% VIRCRV TP1 Grp2 Gabriel/Ronk
% Version 0.10
% Last modified 2022/09/21 00:15

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

% Diff�rentes configurations de test pour les MGD/MGI
Q1 = zeros(1,4);
Q2 = [pi/2 0 0 0];
Q3 = [0 pi/2 0 0];
Q4 = [0 0 -0.5 pi/2];
Q5 = [pi/2 pi/2 -0.5 0];

% Param�tres des actionneurs
r = 1/200; % rapport de r�duction
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
% Choix de la config de test parmi celles d�finies au-dessus (ou d'autres � votre discr�tion)
q = Q1 ;

%% SECTION 2.1

% Calcul MGD
T04q = calculT04(q);

% Verfication du MGD
% v_test21 = T04 * [1   ; 0.5  ; 1   ; 1] ;
% q_test21 = [pi pi/2 -1 0] ;
% drawBM(q_test21) ;
% hold on
% drawFrame(T04,'R4',0.3) ; % repere scaled at 0.3
% hold off
% ATTENTION TO4 depend de la config q donc il faut que q soit le meme que le parametre donne a drawBM



%% SECTION 2.2

% Q2.2.1

% Matrice de passage homgene entre R0 et RC
T0C= calculT0C(q)

% Affichage de l'orientation de Rc
% drawBM(Q1) ;
% hold on
% drawFrame(T0C,'RC',0.1) ; % repere scaled at 0.1
% hold off
% ATTENTION TOC depend de la config q donc il faut que q soit le meme que le parametre donne a drawBM

% Q2.2.2

% Determination de la situation de la piece dans R0 
P_R0=T0C*[xP; yP ;h; 1]; % position objet dans RO
P_Rp=[xP; yP ;h; 1]; % position objet donnee par la camera dans Rc

% position objet donnee par la camera dans R0
Rp=[
    1   0   0   P_R0(1)   ; % pas de rotation sur xyz car meme orientation que R0
    0   1   0   P_R0(2)   ; 
    0   0   1   P_R0(3) ; 
    0   0   0   1    ]

% Validation
% drawBM(q)
% hold on
% drawFrame(Rp,'Rcp',0.3)
% drawFrame(T0C,'Rop',0.3)
% hold off

% Q2.2.3 cf compte rendu

% Q2.2.4

% Calcul du MGI et verification
Qsol=mgi_mitsu(Rp) ;
Qsol1=Qsol(:,1) ; % sol1: configuration du robot pour atteindre la piece
Qsol2=Qsol(:,2) ; % sol2: configuration du robot pour atteindre la piece

% Affichage MGI
figure(1)
subplot(1,2,1)
drawBM(Qsol1)
drawFrame(calculT04(Qsol1),'Routils',0.3)
subplot(1,2,2)
drawBM(Qsol2)
drawFrame(calculT04(Qsol2),'Routils',0.3)



%% SECTION 2.3

% D�termination des repr�sentations d'�tat des actionneurs


% R�ponse indicielle des actionneurs seuls


% R�ponse indicielle de chaque actionneur et dessin de la trajectoire