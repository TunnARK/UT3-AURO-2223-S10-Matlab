%% Définition du Système
H=ss;
H.A=[-.1 -1 0 0;1 -0.1 0 0;0 0 -0.1 3 ;0 0 -3 -0.1];
H.B=[1 0 0.1;0 1 0;.1 0 1;0 0.1 0];
H.C=[1 0 0 0;0 1 0 0;0 0 1 0]
%% tracé  de ses valeurs singulières
sigma(H)
%% récupération de la pire fréquence
[wcg,wcu]=wcgain(H)
%% Matrice de transfert à la pire fréquence
Hjome=evalfr(H,j*wcg.CriticalFrequency)
%% valeur singulière max à cette fréquence
sqrt(max(eig(Hjome'*Hjome)))
%% norme Hinfini de s
norm(H,inf)









%% test de la condition suffixante du petit gain
D=rand(3,3);
D=D/norm(D,2);
D=1/(norm(H,inf)+0.001)*D;
norm(D)
pole(feedback(H,-D))

%% test de la condition necessaire du petit gain
[U,S,V]=svd(Hjome)
Dwc=U(:,1)*V(:,1)'/norm(H,inf)
norm(Dwc)
pole(feedback(H,-Dwc))

%% test de la condition necessaire du petit gain
D=U(:,2)*V(:,2)'
norm(D)
pole(feedback(H,-D))
