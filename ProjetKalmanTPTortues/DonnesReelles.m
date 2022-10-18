function [N,T,Z,u] = DonneesReelles;
%  Lecture d'un ensemble de donn�es pour la QUESTION5
%  Syntaxe d'appel : [N,T,Z,u] = DonneesReelles;
%  -> N : nombre d'�chantillons temporels
%  -> T : vecteur des instants d'�chantillonnage (1xN)
%  -> Z : mesure (2xN)
%  -> u : signal d�terministe vecteur vitesse du courant (2xN)
%	
%	Il ne s'agit plus de simulations mais de vraies mesures :
%  -> Les matrices de la repr�sentation d'�tat sont � d�duire de la
%     repr�sentation d'�tat. Attention, les instants de mesures n'�tant plus
%     r�gulier, F et G varient � chaque instant !
%  -> Les informations a priori suivantes ainsi que le "vrai vecteur %    
%     d'�tat" ne sont pas fournis :
%		. mX0 : esp�rance du vecteur d'�tat � l'instant 0 (4x1)
%     . PX0 : covariance du vecteur d'�tat � l'instant 0 (4x4)
%     . Qw  : covariance du bruit de dynamique (suppos� stationnaire) 
%             (4x4)
%     . Rv  : covariance du bruit de mesure (suppos� stationnaire)
%             (2x2)
%     . X   : r�alisation du processus al�atoire d'�tat (4xN)
%
%  Z, u admettent AUTANT DE COLONNES QUE D'INSTANTS


RAW.Mat = load('turt8.data');

RAW.Mat = RAW.Mat((RAW.Mat(:,2)==0),:);   % supprime les 'bouche-trou'
RAW.Mat = RAW.Mat((RAW.Mat(:,7)<=900),:); % supprime les erreurs de uCourant
RAW.Mat = RAW.Mat((RAW.Mat(:,8)<=900),:); % supprime les erreurs de vCourant

RAW.time = RAW.Mat(:,1)*24*60*60;   % time : temps en secondes
Phi = RAW.Mat(:,3);                 % Phi = longitude en degr�s
Theta = RAW.Mat(:,4);               % Theta = latitude en degr�s
RAW.uCourant = RAW.Mat(:,7);        % vitesse courant (m/s)
RAW.vCourant = RAW.Mat(:,8);        % vitesse courant (m/s)

N = size(RAW.Mat,1);
T = (RAW.time-RAW.time(1))'; % toujours en secondes
u = ([RAW.uCourant RAW.vCourant])';

% Calcul des positions de la tortue (en m)
% La tortue est supposee commencer en (0,0).  Sa position (X,Y)
% est ensuite calculee a chaque instant par rapport a cet origine.
X = zeros(1,N); Y = zeros(1,N);
%
for k = 2:N, % k commence a 2 car (k_ini == 1) ==> X(k_ini) = Y(k_ini) = 0
  X(k) =  X(k-1) ...
          + 111120*(Phi(k)-Phi(k-1))*(cos(0.5*(Theta(k)+Theta(k-1))*pi/180));
  Y(k) = Y(k-1) ...
         + 111120*(Theta(k)-Theta(k-1));
end

Z = [X ; Y];

figure
h7 = quiver(Z(1,:),Z(2,:),u(1,:),u(2,:),2,'c.-'); hold on;
h6 = plot(Z(1,:),Z(2,:),'b.-'); hold off; axis square;
grid on; legend([h6 h7],'Z','u');
