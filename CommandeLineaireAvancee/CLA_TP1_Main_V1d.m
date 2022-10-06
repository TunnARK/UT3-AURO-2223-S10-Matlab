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

F=tf(EE) %deja sous la forme de Smith-Macmillan

eig(F)

Z_colonne1=zero(F(1))
Z_colonne2=zero(F(2))



