% Ce code utilise la toolbox YALMIP
% gratuitement téléchargeable à
% https://yalmip.github.io/download/
%
% Et nécessite d'avoir installé un solveur 
% SemiDefinite Programming
% Il y en a un dans la Robust Control Toolbox de MATLAB
% et d'autres libres listés ici
% https://yalmip.github.io/allsolvers/
% J'utilise SDPT3 disponible ici
% https://github.com/SQLP/SDPT3
% et là
% https://blog.nus.edu.sg/mattohkc/softwares/sdpt3/

% A=[0 1;-omega^2 -2*zeta*omega]
% 1/2 <= zeta <= 3/2
% 3 <= omega <= 7
%% Définition des sommets d'un polytope qui inclut la matrice incertaine

delta1=0;
delta2=0;
mu=2;

A = [
    0   ,   1   ;
    delta1/(1+delta2)   ,   delta1;
];




vb=1;

% %% Construction des LMI pour le polytope
% X = sdpvar(2,2,'symmetric')
% R = sdpvar(1,2)
% quiz=[X>=eye(2)];
% for v=1:vb
%     quiz=quiz+[ A*X+Bu*R+(A*X+Bu*R)' , Bw , X*Cz' ;
%     Bw', -mu^2, Dzw';
%     Cz*X, Dzw, -1 <= zeros(4,4)];
% end
% %% Résolution
% res=optimize(quiz)
% %% Analyse du résultat
% checkset(quiz)
% %% Si faisable obtention du résultat
% Xsol=double(X)
% Rsol=double(R)


%% Etude de stabilite avec le retour d etat
delta1=1/2;
delta2=1/2;


delta=[delta1 , 0 ; 0, delta2]

Hi_delta=norm(delta)
Aprime=[0 1; 0 0];
K=[12, 5; 0 0];
B=[0 0; 1 1];

Ad=Aprime-(B*K);
Bd=[0 0 0; 1 1 0];
Cd=[0 1 ; 0 0; 0 0];
Dd=[0 0 0 ; -1 -1 1 ; 0 0 0 ];

Sys=ss(Ad,Bd,Cd,Dd)
norm(Sys)