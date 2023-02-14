% ------------------------------- %
%  CCTR - Moteur Courant Continu  %
% ------------------------------- %

% V1 2023/01/27

clear all; close all;

%% Modele de connaissance LINEAIRE

% Donnees
R = 6.2; % Resistance induit
L = 0.8e-3; % Inductance induit
J1 = 0.039e-4; % Inertie rotor
TauM1 = 19.6e-3; % Constante de temps mecanique rotor seul
Ke = 3.6/1000*60/(2*pi); % Constante de fem
Kc = 3.5/100; % Constante de couple
Ks = 10; % Constante du potentiometre
Kr = 1/9; % Facteur du reducteur
Cn = 3e-4; % Couple nominal de frottement sec si rotation
rCn = Cn/2; % Rayon de l'incertitude du frottement sec
Kg = 0.105; % Constante de la generatrice tachymetrique
Rchn = 100; % Resistance nominale de la charge generatrice tachymetrique
rRch = 0.5; % Rayon de l'incertitude de la resistance de charge

% Mesure
TauM2 = 500e-3; % Constante de temps mecanique rotor+reducteur+charge

% Calculs
mu = J1/TauM1; % Coefficient de frottement visqueux
J2 = TauM2*mu; % Intertie rotor+reducteur+charge

% Facteurs approximations
alpha = (1.8897e7 / 1.327e5) / (4.3974e5 / 7745) ; % approximation i_2
beta  = (1250*2.114) / (7748*4.066)              ; % approximation i_1

%% MODELE TF

% Fonction de transfert Tension / Vitesse moteur
TFmoteurConnaissanceVmOmega = tf(Kc,[L*J2 mu*L+R*J2 Ke*Kc+mu*R]);
% Fonction de transfert Tension / Vg
TFmoteurConnaissanceVmVg = tf(Kc*Kg,[L*J2 mu*L+R*J2 Ke*Kc+mu*R]);
% Fonction de transfert Tension / Vs
TFmoteurConnaissanceVmVs = tf(Kc*Kr*Ks,[L*J2 mu*L+R*J2 Ke*Kc+mu*R 0]);


%% Modele de comportement LINEAIRE
% Mesures
tau = 250e-3; % Constante de temps
gain = 14.5; % Gain statique

% Fonction de transfert Tension / Vitesse moteur
TFmoteurComportementVmOmega = tf(gain,[tau 1]);
% Fonction de transfert Tension / Vg
TFmoteurComportementVmVg = tf(gain*Kg,[tau 1]);
% Fonction de transfert Tension / Vs
TFmoteurComportementVmVs = tf(gain*Ks*Kr,[tau 1 0]);

%% Comparaison modele de connaissance / modele de comportement
% figure(1);hold on
% step(TFmoteurConnaissanceVmOmega);step(TFmoteurComportementVmOmega);
% 
% figure(2);hold on
% Om = logspace(-1,9,1000);
% bode(TFmoteurConnaissanceVmOmega,Om);bode(TFmoteurComportementVmOmega,Om);

%% Modele Lineaire d'ordre 4

% Niveau 4
A4 = [ -R/L   0           0 -Ke/L    ;
         0    -(R+Rchn)/L 0  Ke/L    ;
         0    0           0   1      ;
       Kc/J2  -Kc/J2      0 -mu/J2   ];
B4 = [ 1/L;  0;  0; 0 ];
C4 = [ 0 0 0     Kg ;
       0 0 Kr*Ks 0  ];
D4 = [ 0 ];

uBOy4 = ss(A4, B4, C4, D4) ;

% Fonction Transfert des modeles 4 a 2
FT4 = zpk(ss(A4, B4, eye(4), zeros(4,1))) ;

% Niveau 3
A3G = [ 1 0 0 0 ;
        0 0 1 0 ;
        0 0 0 1 ];
A3D = [ 1 0 0     ;
        0 0 alpha ;
        0 1 0     ;
        0 0 1     ];
A3 = A3G * A4 * A3D ;
% erreur sur A3 !

B3G = [ 1 0 0 0 ;
        0 0 1 0 ;
        0 0 0 1 ];
B3 = B3G * B4 ;
C3 = [ 0 0     Kg ;
       0 Kr*Ks 0  ];
D3 = [ 0 ];

uBOy3 = ss(A3, B3, C3, D3) ;

% Niveau 2
A2G = [ 0 1 0 ;
        0 0 1 ];
A2D = [ 0 0 ;
        1 0 ;
        0 1 ];
A2 = A2G * A3 * A2D ;
B2G = [ 0 1 0 ;
        0 0 1 ];
B2 = B2G * ( B3 + A3 * [beta; 0; 0]);
C2 = [ Kg  0     ;
       0   Kr*Ks ];
D2 = [ 0 ];

uBOy2 = ss(A2, B2, C2, D2) ;


%% Observateur

% poles desires
poles_des = [-10; -20]; % tr = 0.3s pour -10 et -15 pour un pole + rapide

% gain
G2 = acker(A2', C2(1,:)', poles_des)';

% systeme obs
uBOy_obs = ss(A2-G2*C2(1,:), [G2 B2], eye(2), D2);

%% Retour Etat avec effet integral

% poles desires pour le retour etat
poles_rt = [-6; -12; -14]; % Pole dominant en -5 pour un tr = 0.5s

% Modele augmente
Aa = [ 0 -C2(1,:); zeros(2,1) A2 ];
Ba = [ 0; B2 ];

% gain
Ka = acker(Aa, -Ba, poles_rt);

% Systeme Retour Etat
Art = [ 0 -C2(1,:); B2*Ka(1) A2+B2*Ka(2:3) ];
Brt = [ 1; 0; 0 ];

%% Bouclage observateur et retour d etat avec effet integral

Arti=[Art+Brt*Ka -Brt*Ka(2:3) ; zeros(2,3) A2-G2*C2(1,:)];
Brti=[1;0;0; zeros(2,1)];
Crti=[1 0 0 zeros(1,2)];
Drti=0;

Systrti=ss(Arti,Brti,Crti,Drti);

step(Systrti);