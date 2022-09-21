% VIRCRV TP1 Grp2 Gabriel/Ronk
% Version 0.10
% Last modified 2022/09/21 00:15

%% INITIALISATION
clc
clear all
close all

% G�om�trie du robot
h = 0.8;
L1 = 0.4;
L2 = 0.4;
L3 = 0.2;

% Mesures renvoy�es par la cam�ra (position de la pi�ce � saisir dans Rc):
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
q = Q1;

%% SECTION 2.1
	% Utilisation de la fonction drawBM

	% Calcul du MGD et afficher le rep�re outil
	% Ne pas oublier hold on si n�cessaire pour la superposition des courbes

T01=[
    cos(q(1))   -sin(q(1))  0   0 ;
    sin(q(1))   cos(q(1))   0   0 ;
    0           0           1   0 ;
    0           0           0   h]
T12=[
    cos(q(2))   -sin(q(2))  0   L1 ;
    sin(q(2))   cos(q(2))   0   0 ; 
    0           0           1   0 ; 
    0           0           0   1]
T23=[
    1   0   0   L1 ;
    0   1   0   0 ; 
    0   0   1   0 ; 
    0   0   0   1]

%% SECTION 2.2

	% Calculer ici TOC la matrice de passage homog�ne entre R0 et Rc


	% D�termination de la situation de la pi�ce dans R0
	% Donn�es: position de la pi�ce dans Rc : (xP, yP, h), orientation : cf. �nonc�
  	% Afficher la position (X,Y,Z) de la pi�ce dans R0 --> Fonction : plot3(X,Y,Z,'ro'); 
	% D�duire la situation de la pi�ce dans R0
  
  	% Calcul du MGI et v�rification
  	% Affichage


%% SECTION 2.3

	% D�termination des repr�sentations d'�tat des actionneurs

    
	% R�ponse indicielle des actionneurs seuls

	
	% R�ponse indicielle de chaque actionneur et dessin de la trajectoire