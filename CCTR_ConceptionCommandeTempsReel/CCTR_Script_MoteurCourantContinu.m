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
Rchn = 1000; % Resistance nominale de la charge generatrice tachymetrique
rRch = 0.5; % Rayon de l'incertitude de la resistance de charge

% Mesure
TauM2 = 500e-3; % Constante de temps mecanique rotor+reducteur+charge

% Calculs
mu = J1/TauM1; % Coefficient de frottement visqueux
J2 = TauM2*mu; % Intertie rotor+reducteur+charge

% Facteurs approximations
alpha = J2/TauM1 ; % approximation pour i_2(t)
beta = 1 ; % !!!

%% Modele Lineaire d'ordre 4

% Niveau 4
A4 = [ -R/L   0           0 -Ke/L    ;
         0    -(R+Rchn)/L 0  Ke/L    ;
         0    0           0   1      ;
       Kc/J2  -Kc/J2      0 -mu/J2   ];
B4 = [ 1/L;  0;  0; 0 ];
C4 = [ 1 1 1 1 ];
D4 = [ 0; 0; 0; 0 ];

uBOy4 = ss(A4, B4, C4, D4);

% Niveau 3
A3G = [ 1 0 0 0 ;
        0 0 1 0 ;
        0 0 0 1 ];
A3D = [ 1 0 0     ;
        0 0 alpha ;
        0 1 0     ;
        0 0 1     ];
A3 = A3G * A4 * A3D ;

B3G = [ 1 0 0 0 ;
        0 0 1 0 ;
        0 0 0 1 ];
B3 = B3G * B4 ;
C3 = [ 1 1 1 1 ];
D3 = [ 0; 0; 0; 0 ];

uBOy3 = ss(A3, B3, C3, D3);   

% Niveau 2
A2G = [ 0 1 0 ;
        0 0 1 ];
A2D = [ 0 0 ;
        1 0 ;
        0 1 ];
A2 = A2G * A3 * A2D ;

B2G = [ 0 1 0 ;
        0 0 1 ];
B2 = B2G * ( B3 + A3 * [beta; 0; 0])_;
C2 = [ 1 1 1 1 ];
D2 = [ 0; 0; 0; 0 ];

uBOy2 = ss(A2, B2, C2, D2);