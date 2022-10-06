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
A(:,:,1)=[0 1;-49 -21];
%A(:,:,2)=[0 1;-49 -3]; 
% ou 
 A(:,:,2)=[0 1; -49 -7]
A(:,:,3)=[0 1;-9 -3];
A(:,:,4)=[0 1;-9 -21];
vb=4;
%% point au hasard dans le polytope
z=rand(1,4);
z=z/sum(z)
Az=z(1)*A(:,:,1)+z(2)*A(:,:,2)+z(3)*A(:,:,3)+z(4)*A(:,:,4)
eig(Az)
%% Construction des LMI pour le polytope
P=sdpvar(2,2,'symmetric')
quiz=[P>=eye(2)];
for v=1:vb
    quiz=quiz+[A(:,:,v)'*P+P*A(:,:,v)<=-eye(2)];
end
%% Résolution
res=optimize(quiz)
%% Analyse du résultat
checkset(quiz)
%% Si faisable obtention du résultat
double(P)

