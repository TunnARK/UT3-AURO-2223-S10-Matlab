%%% Function    : drawTraj% Description : Calcul et tracé de la réponse indicielle% Parameter   :%      - Sbf1, Sbf2 : Représentation d'état des systèmes en boucle fermée%      - qConsigne1 : Consigne à atteindre pour l'axe 1%      - qConsigne2 : Consigne à atteindre pour l'axe 2%      - h = 0.8 (hauteur au-dessus du plateau)%      - (X,Y,Z) : Position de la pière à saisir dans R0%      - drawTraj   : booléen = 1 pour dessiner la trajectoire du bras, 0 sinon.%                     0 est la valeur par défaut.function drawTraj(Sbf1, Sbf2, qConsigne1, qConsigne2, t, h, X, Y, Z, showBM)if nargin==8    showBM=0;endfigure%[q1s,t]=step(qConsigne1*Sbf1);[q1s]=step(qConsigne1*Sbf1,t);plot(t,q1s)title('Réponse indicielle du moteur 1 asservi')gridfigure[q2s]=step(qConsigne2*Sbf2,t);plot(t,q2s)title('Réponse indicielle du moteur 2 asservi')grid% On fixe les valeurs des autres articulations à 0q3s = zeros(size(q1s))-h/2; % vecteur fixe pour articulation 3 (prism.)q3s(end) = -h; % pour faire descendre la pince sur la dernière positionq4s = zeros(size(q1s)); % vecteur de 0 pour articulation 4 (rot.)% Assemblage des configs des 4 articulations:q_sim = [q1s q2s q3s q4s];% Joue la trajectoire calculée via la commande:if showBM==1  figure    plot3(X,Y,Z,'ro'); % pour afficher la pièce  hold on  disp('appuyer sur espace pour voir le robot bouger')  for i=1:length(t)   drawBM(q_sim(i,:))    hold on    pause  endend