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
q =Q3;

%% SECTION 2.1
% Matrices de passages homogenes
T01=[
    cos(q(1))   -sin(q(1))  0   0 ;
    sin(q(1))   cos(q(1))   0   0 ;
    0           0           1   h ;
    0           0           0   1 ];
T12=[
    cos(q(2))   -sin(q(2))  0   L1  ;
    sin(q(2))   cos(q(2))   0   0   ; 
    0           0           1   0   ; 
    0           0           0   1   ];
T23=[
    1   0   0   L2   ;
    0   1   0   0    ; 
    0   0   1   q(3) ; % signe dans q(3) pour la longueur prismatique
    0   0   0   1    ];
T34=[
    cos(q(4))   -sin(q(4))  0   0 ;
    sin(q(4))   cos(q(4))   0   0 ; 
    0           0           1   0 ;
    0           0           0   1];

% Modele MGD
T04 = T01 * T12 * T23 * T34

% Verfication du MGD
v_test = T04 * [1   ; 0.5  ; 1   ; 1]

%% SECTION 2.2

% Calcul de la matrice de passage de R2 à Rc
T2C=[
    1 0 0 L2+L3;
    0 1 0  0 ;
    0 0 1  0;
    0 0 0 1 ]; 
    
T0C= T01*T12*T2C % Matrice de passage homgene entre R0 et RC


% Affichage de l'orientation de Rc
drawBM(Q1)
hold on
drawFrame(T0C,'RC')
hold off

% D�termination de la situation de la pi�ce dans R0
% Donn�es: position de la pi�ce dans Rc : (xP, yP, h), orientation : cf. �nonc�
% Afficher la position (X,Y,Z) de la pi�ce dans R0 --> Fonction : plot3(X,Y,Z,'ro'); 
% D�duire la situation de la pi�ce dans R0
% Utilisation de la fonction drawBM

% Calcul du MGD et afficher le rep�re outil
% Ne pas oublier hold on si n�cessaire pour la superposition des courbes

% Calcul du MGI et v�rification
% Affichage


%% SECTION 2.3

	% D�termination des repr�sentations d'�tat des actionneurs

    
	% R�ponse indicielle des actionneurs seuls

	
	% R�ponse indicielle de chaque actionneur et dessin de la trajectoire