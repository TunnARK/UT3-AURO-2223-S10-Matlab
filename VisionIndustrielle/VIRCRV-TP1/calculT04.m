function [T04] = calculT04(q)

% Geometrie du robot
h = 0.8;
L1 = 0.4;
L2 = 0.4;
L3 = 0.2;


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
end
