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
Xm = 6.9 ; Ym = 2 ;
% Vecteur de configuration
Q = [Xm; Ym; theta; qpl] ;

%% Appel fonctions visu
[s_o,opc] = visu(Xm,Ym,theta,qpl,OP1_R,OP2_R,OP3_R,OP4_R) ;

%% Affichages
% Affichage des points cibles
drawTarget(OP1_R,OP2_R,OP3_R,OP4_R) ;
% Affichage 3D de la platine pour x=6.9, y=2, theta=0 et qpl=0
drawRobotPlatine(Xm, Ym, theta, qpl, 1, '-b') ;
% Affichage des indices visuels obtenues
drawImage(s_o(1),s_o(2),s_o(3),s_o(4),s_o(5),s_o(6),s_o(7),s_o(8)) ;
% Affichage des indices visuels desires
drawImage(s_b(1),s_b(2),s_b(3),s_b(4),s_b(5),s_b(6),s_b(7),s_b(8)) ;


%% Matrice d'interaction