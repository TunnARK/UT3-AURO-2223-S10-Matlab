function [T0C] = calculT0C(q)

% G�om�trie du robot
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
% Calcul de la matrice de passage de R2 à Rc (rotation typic autour de y2)
T2C=[
    cos(pi)  0  sin(pi)    L2 + L3    ; % cos(pi) car xc = -x2
    0      1   0           0       ; % 1 car yc=y2
    -sin(pi) 0   cos(pi)    0       ; % -1 car zc=-z2
    0       0   0           1       ]; 
    
% Matrice de passage homgene entre R0 et RC
T0C= T01 * T12 * T2C ; 

end
