% Modélisation du robot SCARA Mitsubishi

%% PARTIE NON MODIFIABLE 
%% INITIALISATION 
%% NE PAS MODIFIER CETTE PARTIE!!!!!!

clc
clear all
close all

% Géométrie du robot
h = 0.8;
L1 = 0.4;
L2 = 0.4;
L3 = 0.2;

% Mesures renvoyées par la caméra (position de la pièce à  saisir dans Rc):
xP = 0.5; yP = 0.2; 

% Différentes configurations de test pour les MGD/MGI
Q1 = zeros(1,4);
Q2 = [pi/2 0 0 0];
Q3 = [0 pi/2 0 0];
Q4 = [0 0 -0.5 pi/2];
Q5 = [pi/2 pi/2 -0.5 0];

% Paramètres des actionneurs
r = 1/200; % rapport de réduction
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

% FIN DE LA PARTIE NON MODIFIABLE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Choix de la config de test parmi celles définies au-dessus (ou d'autres à  votre discrétion)
q = Q1;

%% A COMPLETER

%%% SECTION 2.1
	% Utilisation de la fonction drawBM


	% Calcul du MGD et afficher le repère outil
	% Ne pas oublier hold on si nécessaire pour la superposition des courbes


%%% SECTION 2.2

	% Calculer ici TOC la matrice de passage homogène entre R0 et Rc


	% Détermination de la situation de la pièce dans R0
	% Données: position de la pièce dans Rc : (xP, yP, h), orientation : cf. énoncé
  	% Afficher la position (X,Y,Z) de la pièce dans R0 --> Fonction : plot3(X,Y,Z,'ro'); 
	% Déduire la situation de la pièce dans R0
 
  
  	% Calcul du MGI et vérification
  	% Affichage


%%% SECTION 2.3

	% Détermination des représentations d'état des actionneurs

    
	% Réponse indicielle des actionneurs seuls

	
	% Réponse indicielle de chaque actionneur et dessin de la trajectoire

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 






