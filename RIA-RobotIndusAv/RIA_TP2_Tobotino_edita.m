%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TP2 Asservisement visuel d un robot mobile
% Ronk et Gabriel Calixte
% 1er fev 2023
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all;

%% Declaration des constantes
% Coordonnees de C dans Rp
a = 0 ;
b = 0 ;
% Entraxe 
Dx = 0.1 ; % (m)
% Hauteur
h  = 0.4 ; % (m) entre P et M
r  = 0.4 ; % (m) entre M et sol
f  = 1   ; %     focal

%% Position des cible dans le repre scene
OP1_R = [8; 2.2; 1;   1] ; % dans R
OP2_R = [8; 1.8; 1;   1] ; % dans R
OP3_R = [8; 1.8; 0.6; 1] ; % dans R
OP4_R = [8; 2.2; 0.6; 1] ; % dans R


%% Indices visuels desires
s_b = [ -0.2; 0.2; -0.2; -0.2; 0.2; -0.2; 0.2; 0.2 ];

%% Configuration initiale
% Angle de rotation 
theta = 0 ;
% Angle de la platine
qpl = 0 ;
% Position du robot
Xm = 6,9 ; Ym = 2 ;
% Vecteur de configuration
Q = [Xm; Ym; theta; qpl] ;

%% Calcul des matrices de passage
% Camera sur Platine
T_RP_RC = [ 0 0 1 a ;
            0 1 0 b ;
           -1 0 0 0 ;
            0 0 0 1 ];
% Platine sur Base
T_RM_RP = [ cos(qpl) -sin(qpl) 0 Dx ;
            sin(qpl)  cos(qpl) 0 0  ;
            0         0        1 0  ;
            0         0        0 1  ];
% Base sur Scene
T_R_RM = [ cos(theta) -sin(theta) 0 Xm ;
           sin(theta)  cos(theta) 0 Ym ;
           0           0          1 0  ;
           0           0          0 1  ];
% Camera sur Scene
T_R_RC = T_R_RM * T_RM_RP * T_RP_RC ;
% Base sur Camera
T_RC_R = [ T_R_RC(1:3,1:3)' -T_R_RC(1:3,1:3)'*T_R_RC(1:3,4) ;
           zeros(1,3)        1                              ];
% ou bien T_RC_R = inv(T_R_RC) ;

%% Calcul des points dans le repere camera
OP1_C = T_RC_R * OP1_R ;
OP2_C = T_RC_R * OP2_R ;
OP3_C = T_RC_R * OP3_R ;
OP4_C = T_RC_R * OP4_R ;

%% Projection perpesctive
% Xp = f/z * xp
OP1_I = OP1_C(1:3) * f/OP1_C(3) ;
OP2_I = OP2_C(1:3) * f/OP2_C(3) ;
OP3_I = OP3_C(1:3) * f/OP3_C(3) ;
OP4_I = OP4_C(1:3) * f/OP4_C(3) ;

%% Calcul des indices visuels
% un vecteur superposant chaque projection ci-dessus
s = [ OP1_I(1:2); OP2_I(1:2); OP3_I(1:2); OP4_I(1:2) ];

%% Affichages
% Affichage des points cibles
drawTarget(OP1_R,OP2_R,OP3_R,OP4_R);
% Affichage 3D de la platine pour x=6.9, y=2, theta=0 et qpl=0
drawRobotPlatine(Xm, Ym, theta, qpl, 1, '-b');
% Affichage des indices visuels obtenues
hold on; drawImage(s(1),s(2),s(3),s(4),s(5),s(6),s(7),s(8));
% Affichage des indices visuels desires
drawImage(s_b(1),s_b(2),s_b(3),s_b(4),s_b(5),s_b(6),s_b(7),s_b(8));

