% -------------------------- %
% CLADP TP1 GABRIEL-RONK V1d %
% -------------------------- %

clear all
close all


%% Question 3
delta1=0;
delta2=0;
mu=2;

A = [
    0   ,   1   ;
    delta1/(1+delta2)   ,   delta1;
]


% Matrice dynamique avec delta1=delt2=0 et mu=2
X=sdpvar(2,2);
R=[X>=eye(1)];
Dzw=zeros(1,1);
Bu=[0;1];
Bw=[0;1];
Cz=[1 delta1];



T=[ A*X+Bu*R+(A*X+Bu*R)' , Bw , X*Cz' ;
    Bw', -mu^2, Dzw';
    Cz*X, Dzw, -1 ]

% Contraintes du theoreme 1
R=R+[T'*P+P*T<=-eye(2)];


%Resolution
res=optimize(R)

% Analyse du résultat
checkset(R)

% Si faisable obtention du résultat
double(X)





