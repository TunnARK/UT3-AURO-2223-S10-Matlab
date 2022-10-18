function [N,T,Z,u,F,G,H,mX0,PX0,Qw,Rv,X] = simulationDonnees;
%SIMULATIONDONNEES
%  Simulation d'un ensemble de données pour la QUESTION3
%  Syntaxe d'appel : [N,T,Z,u,F,G,H,mX0,PX0,Qw,Rv,X] = simulationDonnees;
%  -> N : nombre d'échantillons temporels
%  -> T : vecteur des instants d'échantillonnage (1xN)
%  -> Z : réalisation du processus aléatoire de mesure (2xN)
%  -> u : signal déterministe vecteur vitesse du courant (2xN)
%  -> et comme ceci est de la simulation, sont également accessibles
%     . F, G, H : matrices du modèle (respectivement (4x4), (4x2), (2x4))
%     . mX0 : espérance du vecteur d'état à l'instant 0 (4x1)
%     . PX0 : covariance du vecteur d'état à l'instant 0 (4x4)
%     . Qw  : covariance du bruit de dynamique (supposé stationnaire) 
%             (4x4)
%     . Rv  : covariance du bruit de mesure (supposé stationnaire)
%             (2x2)
%     . X   : réalisation du processus aléatoire d'état (4xN)
%
%  Z, u, X admettent AUTANT DE COLONNES QUE D'INSTANTS

N = 120;
deltaT = 10000;
T = [0:N-1]*deltaT;
u = [0.1*cos(2*pi/1e6*T);0.5*sin(2*pi/2e6*T)]*0.5;
%
mX0 = [0;0;0.05;0.1];
PX0 = diag([2 2 0 0]*1e6);
Qw = diag([2e4 2e4 1e-6 1e-6]);
%Rv = diag([1e6 1e6])/100000;
Rv = diag([36e4 36e4]);
%
F = [1 0 deltaT 0; 0 1 0 deltaT; 0 0 1 0; 0 0 0 1];
G = [deltaT 0; 0 deltaT; 0 0; 0 0];
H = [1 0 0 0; 0 1 0 0];
X = nan*ones(4,N); Z = nan*ones(2,N); Zpropre = nan*ones(2,N);

% Instant 0
W = chol(Qw)'*randn(4,N);
V = chol(Rv)'*randn(2,N);
%X(:,1) = mX0 + chol(PX0)'*randn(4,1);
X(:,1) = mX0 + sqrt(PX0)'*randn(4,1);
Xpropre(:,1) = X(:,1);

% Instants 1:(N-1);
for k=2:N,                              % k == instant+1
  X(:,k) = F*X(:,k-1) + G*u(:,k-1) + W(:,k-1);
  Xpropre(:,k) = F*Xpropre(:,k-1) + W(:,k-1);
  Z(:,k) = H*X(:,k) + V(:,k);
  Zpropre(:,k) = H*Xpropre(:,k) + V(:,k);
end;

figure
h7 = quiver(Z(1,:),Z(2,:),u(1,:),u(2,:),2,'c.-'); hold on;
h6 = plot(Z(1,:),Z(2,:),'b.-'); hold off; axis square;
grid on; legend([h6 h7],'Z','u');
%
figure;
h1 = plot(Z(1,:),Z(2,:),'r'); hold on;
h2 = plot(Zpropre(1,:),Zpropre(2,:),'m'); hold off; axis square;
grid on; legend([h1 h2],'Z','Zpropre');
