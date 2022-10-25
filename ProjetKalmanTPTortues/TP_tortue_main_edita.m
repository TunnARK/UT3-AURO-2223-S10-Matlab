% ------------------------------- %
% Projet 1 Kalman - M2 AURO
% TP - Migration des tortues luth 
% RONK Antoine
% Damien GABRIEL CALIXTE
% ------------------------------- %

clc       ;
close all ;
clear all ;

%% Remplissage des donnnees 

load turt8.data
[N,T,Z,u,F,G,H,mX0,PX0,Qw,Rv,X] = simulationDonnees;
% -> N : nombre d'echantillons temporels
% -> T : (1xN) vecteur des instants d'echantillonnage
% -> Z : (2xN) realisation du processus aleatoire de mesure
% -> u : (2xN) signal deterministe vecteur vitesse du courant
% -> et comme ceci est de la simulation, sont egalement accessibles
%  . F, G, H : (resp. (4x4), (4x2), (2x4)) matrices du modele
%  . mX0     : (4x1) esperance du vecteur d'etat a l'instant 0
%  . PX0     : (4x4) covariance du vecteur d'etat a l'instant 0
%  . Qw      : (4x4) covariance du bruit dynamique (suppose stationnaire)
%  . Rv      : (2x2) covariance du bruit de mesure (suppose stationnaire)
%  . X       : (4xN) realisation du processus aleatoire d'etat
% -> Z, u, X admettent AUTANT DE COLONNES QUE D'INSTANTS


%% Filtre de Kalman

% Declarations
Ppred = cell(1, N) ;
Pest  = cell(1, N) ;
Xpred = cell(1, N) ;
Xest  = cell(1, N) ;
K     = cell(1, N) ;

% Initialisation
Xpred{1} = [0; 0; 0; 0] ;
Xest{1}  = mX0          ; % Eq1
Pest{1}  = PX0          ; % Eq2

% Iteration (nota: ici k represente k+1 dans les formules du cours)
for k=2:N
    % Time Update
    Xpred{k}  = F * Xest{k-1}       + G * u(:, k) ; % Eq3
    Ppred{k}  = F * Pest{k-1} * F'  + Qw          ; % Eq4
    
    % Measurement Update
    Gain{k} = Ppred{k} * H' * inv(Rv + H * Ppred{k} * H')   ; % Eq5  
    Xest{k} = Xpred{k} + Gain{k} * (Z(:, k) - H * Xpred{k}) ; % Eq6
    Pest{k} = Ppred{k} - Gain{k} * H * Ppred{k}             ; % Eq7
end

% Extraction des vecteurs
for k=1:N
   % Estimation de la postion
   vestx(k) = Xest{k}(1,1) ;
   vesty(k) = Xest{k}(2,1) ;
   
   % Matrice de covariance
   vestpx(k) = Pest{k}(1,1) ;
   vestpy(k) = Pest{k}(2,1) ;
end

%% Plot Xreel and Xestime
figure(3)
hold on
p1 = plot(X(1,:), X(2,:));
p2 = plot(vestx(:), vesty(:));
legend([p1 p2],'Xreel','Xestime');
title("Comparaison entre trajectoire estimee et reelle")
hold off

%% Error Interval

xTop    = vestx + 3 * sqrt(vestpx) ;
xBottom = vestx - 3 * sqrt(vestpx) ;

yTop    = vesty + 3 * sqrt(vestpy) ;
yBottom = vesty - 3 * sqrt(vestpy) ;
