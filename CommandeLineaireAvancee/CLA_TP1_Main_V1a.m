% ------------------------ %
% CLA TP1 GABRIEL-RONK V1a %
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
a13 = az13 * Sn * sqrt( 2*9.81 ) 
a32 = az32 * Sn * sqrt( 2*9.81 ) 
a20 = az20 * Sn * sqrt( 2*9.81 ) 

% Resistance
%R13 = sqrt( abs( H10 - H30 ) ) / a13 ;
%R32 = sqrt( abs( H30 - H20 ) ) / a32 ;
%R20 = sqrt( abs( H20 ) ) / a20 ;

%% Point Equilibre

H2eq = ( (Q1eq)^2 + (Q2eq)^2 )/(a20)^2
H1eq = (Q1eq)^2/(a13)^2 + (Q1eq)^2/(a32)^2 + H2eq
H3eq = (Q1eq)^2/(a32)^2 + H2eq