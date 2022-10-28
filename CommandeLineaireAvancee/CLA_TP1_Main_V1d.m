% ------------------------ %
% CLA TP1 GABRIEL-RONK V1d %
% ------------------------ %

clear all; close all;

%% VARIABALES

% Sections
S       = 0.0154            ; % m^2
Sn      = 5 * 10^(-5)       ; % m^2

% Coef Tension Pompes
k       = 1.6 * 10^5        ; % cst
b       = -9.2592           ; % cst

% Debits
Q1eq    = 3 * 10^(-5)       ; % m^3/s
Q2eq    = 0.5 * 10^(-5)     ; % m^3/s
Qmax    = 12 * 10^(-5)      ; % m^3/s quand tension = +10V

% Coef Ecoulement
az13 = 0.4753 ;
az32 = 0.4833 ;
az20 = 0.9142 ;
a13 = az13 * Sn * sqrt( 2*9.81 ) ;
a32 = az32 * Sn * sqrt( 2*9.81 ) ;
a20 = az20 * Sn * sqrt( 2*9.81 ) ;


% Point Equilibre

H2eq = ( ( Q1eq + Q2eq )/a20 )^2 ; % H2eq = 0.0299
H3eq = (Q1eq)^2/(a32)^2 + H2eq   ; % H3eq = 0.1084
H1eq = (Q1eq)^2/(a13)^2 + H3eq   ; % H1eq = 0.1897

% Point Equilibre Soni
%H1eq = 0.01968
%H2eq = 0.0316
%H3eq = 0.1156

% Resistance
R13 = 2 * sqrt( abs( H1eq - H3eq ) ) / a13 ;
R32 = 2 * sqrt( abs( H3eq - H2eq ) ) / a32 ;
R20 = 2 * sqrt( abs( H2eq ) ) / a20        ;


%% Modele EE 

A = [
    -1/(S*R13)     1/(S*R13)                   0                     ;
    1/(S*R13)      -1/(S*((1/R13)+(1/R32)))    1/(S*R32)             ;
    0              1/(S*R32)                   -(1/S)*(1/R32+1/R20)  ];
B = [
    1/S      0     ; 
    0        0     ; 
    0        1/S   ];
C = [1 0 0]     ;
D = 0           ;

EE = ss(A,B,C,D) ;

%% Analyse de stabilite

EEeig = eig(A) ;

%% Commandabilite 

% En considerant l entree q1
rangCq1 = rank(ctrb(A,B(:,1))) 

% En considerant l entree q2
rangCq2 = rank(ctrb(A,B(:,2))) 

% En considerant les deux entree
rangC = rank(ctrb(A,B)) 

% Indices de commandabilite

Co = ctrb(A,B)

%% Etude de la fonction de transfert

F=tf(EE) % fonction de transfert

eig(F) % calcul des pôles


Z_colonne1=zero(F(1)) % valeur des zeros pour le transfert 1
Z_colonne2=zero(F(2)) % valeur des zeros pour le transfert 2

dcgain(F) %calcul du gain statique


% Analyse de la reponse idicielle en mesurant h1

%F represente la fonction de transfert dont h1 est mesuree en sortie

figure(1)
subplot(1,2,1)
sgtitle('Réponse indicielle pour la hauteur h1')
step(5e-5*F(1))

subplot(1,2,2)
step(2e-5*F(2))


% Analyse de la reponse idicielle en mesurant h2

C2=[0 1 0];
EE2=ss(A,B,C2,D);
F2=tf(EE2); %F2 represente la fonction de transfert dont h2 est mesuree en sortie

figure(2)
subplot(1,2,1)
sgtitle('Réponse indicielle pour la hauteur h2')
step(5e-5*F2(1))

subplot(1,2,2)
step(2e-5*F2(2))

% Analyse de la reponse idicielle en mesurant h3
C3=[0 0 1];
EE3=ss(A,B,C2,D);
F3=tf(EE3); %F3 represente la fonction de transfert dont h2 est mesuree en sortie

figure(3)
subplot(1,2,1)
sgtitle('Réponse indicielle pour la hauteur h3')
step(5e-5*F3(1))

subplot(1,2,2)
step(2e-5*F3(2))






%% Methode de Bass-Gura

q=[2;3];

% Bt=B*q
% 
% rang_Bt=rank(Bt)
% 
% cmd_ABt=rank(ctrb(A,Bt))
% 
% p=[-1/30 -1/30, -1/30];
% 
% k=place(A,Bt,p)





