```% ------------------------------- %
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

alpha=(1.8897e7/(1.327e5*7748))/(4.3974e5/7745); %approximation pour i_2(t)

beta=0.0839  %approximation pour i_1(t)

%% Modele Lineaire d'ordre 4

% Modele d ordre 4
A4 = [ -R/L   0           0 -Ke/L    ;
         0    -(R+Rchn)/L 0  Ke/L    ;
         0    0           0   1      ;
       Kc/J2  -Kc/J2      0 -mu/J2   ];
B4 = [ 1/L;  0;  0; 0 ];
C4 = [0 0 0 Kg ;0 0 Kr*Ks 0 ];
D4 =0;

uBOy4 = ss(A4, B4, C4, D4);

FT4=zpk(ss(A4,B4,eye(4),D4))


%% Modele d ordre 3
A3G = [ 1 0 0 0 ;
        0 0 1 0 ;
        0 0 0 1 ];
A3D = [ 1 0 0     ;
        0 0 alpha;
        0 1 0     ;
        0 0 1     ];
A3 = A3G * A4 * A3D ;

B3G = [ 1 0 0 0 ;
        0 0 1 0 ;
        0 0 0 1 ];
B3 = B3G * B4 ;
C3 = [0  0 Kg ;0 Kr*Ks 0 ];
D3=0;

uBOy3 = ss(A3, B3, C3, D3);   

FT3=zpk(ss(A3,B3,eye(3),D3))

%% Modele d ordre 2
A2G = [ 0 1 0 ;
        0 0 1 ];
A2D = [ 0 0 ;
        1 0 ;
        0 1 ];
A2 = A2G * A3 * A2D ;

B2G = [ 0 1 0 ;
        0 0 1 ];
B2 = B2G * ( B3 + A3 * [beta; 0; 0]);
C2 = [Kg 0;0 Ks*Kr ];
D2 = 0;

uBOy2 = ss(A2, B2, C2, D2);

FT2=zpk(ss(A2,B2,eye(2),D2))

%% Trace de Bode

figure(1)
hold on
bode(FT4(3))
bode(FT3(2))
bode(FT2(1))
legend('Bode du transfert 4 Theta/V_s','Bode du transfert 3 Theta/V_s','Bode du transfert 2 Theta/V_s')
hold off

figure(2)
hold on
bode(FT4(4))
bode(FT3(3))
bode(FT2(2))
legend('Bode du transfert 4 OmegaV_s','Bode du transfert 3 Omega/V_s','Bode du transfert 2 Omega/V_s')
hold off

%% Observateur

%Pole dominant en -10 pour un temps de reponse en 0,3 s
poles_des=[-10;-15];

G=acker(A2',C2(1,:)',poles_des)';

%Bouclage de l observateur

OB=ss((A2-G*C2(1,:)),[G B2],eye(2),0);


%% Retour d etat avec effet integral

%Modele EE augmente

Aa=[0  -C2(1,:); zeros(2,1) A2];

Ba=[0; B2];


poles_rt=[-6; -12; -14]; %Pole dominant en -6 pour un temps de reponse en 0,5 s

Ka=acker(Aa,-Ba,poles_rt)

K=Ka(2:3);

Aa1=[0 -C2(1,:); B2*Ka(1) A2+B2*K]

Ba1=[1; 0; 0]

%% Bouclage observateur et retour d etat avec effet integral

A_rti=[Aa1+Ba1*Ka -Ba1*K ; zeros(2,3) A2-G*C2(1,:)];

B_rti=[1;0;0; zeros(2,1)];

C_rti=[1 0 0 zeros(1,2)];

D_rti=0;

Syst_rti=ss(A_rti,B_rti,C_rti,D_rti);

figure(3)
step(Syst_rti)
title('Rép indicielle du syst asservi RE basé observateur avec effet int')

stepinfo(Syst_rti)

TF_rti=tf(Syst_rti)

figure(4)
bode(TF_rti)
title('Diagramme de bode du transfert Y/Yc')
```