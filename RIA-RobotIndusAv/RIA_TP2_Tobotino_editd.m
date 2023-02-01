%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TP2 Asservisement visuel d un robot mobile
%Ronk et Gabriel Calixte
%1er fev 2023
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Declaration des constantes
%Coordonnees de C dans Rp
a=0;
b=0;
%Entraxe 
Dx= 0.1 %m

%% Position des cible dans le repre scene
OP1_R=[8; 2.2; 1; 1]; %dans R
OP2_R=[8; 1.8; 1; 1]; %dans R
OP3_R=[8; 1.8; 0.6; 1]; %dans R
OP4_R=[8; 2.2; 0.6; 1]; %dans R

%% Configuration initiale
%Angle de rotation 
theta=0;
%Angle de la platine
qpl=0;
%Position du robot
Xm=0;
Ym=0;
%Vecteur de configuration
Q=[Xm; Ym; theta; qpl]

%% Calcul des matrices de passage

T_RP_RC=[0 0 1 a ; 0 1 0 b; -1 0 0 0 ; 0 0 0 1];


T_RM_RP=[cos(qpl) -sin(qpl) 0 Dx  ; sin(qpl) cos(qpl) 0 0; 0 0 1 0 ; 0 0 0 1];

T_R_RM=[cos(theta) -sin(theta) 0 Xm; sin(theta) cos(theta) 0 Ym; 0 0 1 0 ; 0 0 0 1];

T_R_RC=T_R_RM*T_RM_RP*T_RP_RC

T_RC_R=[ T_R_RC(1:3,1:3)' -T_R_RC(1:3,1:3)'*T_R_RC(1:3,4); zeros(1,3) 1 ]

%% Calcul des points dans le repere camera

OP1_C=T_RC_R*[OP1_R ; 1]