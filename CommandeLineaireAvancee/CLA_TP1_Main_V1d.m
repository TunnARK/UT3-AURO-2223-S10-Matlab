% ------------------------ %
% CLA TP1 GABRIEL-RONK V1d %
% ------------------------ %

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


%% Point Equilibre

H2eq = ( (Q1eq)^2 + (Q2eq)^2 )/(a20)^2;
H1eq = (Q1eq)^2/(a13)^2 + (Q1eq)^2/(a32)^2 + H2eq;
H3eq = (Q1eq)^2/(a32)^2 + H2eq;

% Resistance
R13 = sqrt( abs( H1eq - H3eq ) ) / a13 ;
R32 = sqrt( abs( H3eq - H2eq ) ) / a32 ;
R20 = sqrt( abs( H2eq ) ) / a20 ;




%% Modele EE 
A=[-1/S*R13 , 1/S*R13 , 0 ; 1/S*R13 , -1/S*(1/R13+1/R32) , 1/S*R32; 0, 1/S*R32, -1/S*(1/R13+1/R20)];
B=[1/S, 0; 0 , 0 ; 0, 1/S];
C=[1, 0, 0];
D=0;

EE=ss(A,B,C,D)

%% Analyse de stabilite

eig(A)

%% Commandabilite 

% En considérant l entree q1

rangCq1=rank(ctrb(A,B(:,1)))

% En considérant l entree q2

rangCq2=rank(ctrb(A,B(:,2)))

% En considerant les deux entree
rangC=rank(ctrb(A,B))

