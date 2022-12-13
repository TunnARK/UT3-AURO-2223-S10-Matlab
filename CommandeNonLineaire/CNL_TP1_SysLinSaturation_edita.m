% ------------------------- %
%  CNL TP1 Saturation Ed.a  %
%  Gabriel-Calixte    Ronk  %
% ------------------------- %

clear all; close all;

%% Q1.3 - Dynamique du Systeme

% Plan de phase 
% Recuperation des variables issues de Simulink et trace 
%plot(out.simout.signals.values(:,1),out.simout.signals.values(:,2))
%title('Plan de phase pour une CI=[10;10]')


%% Dynamique en boucle fermee

% Definition de la matrice dynamique
A=[0 1 ; -1 -1];
% Calcul des valeurs propre de la matrice dynamique
vp_A=eig(A);

%% Q2.2 - Estimation du bassin d attraction par simulation

% Initializing Time
Tend  = 10           ;
Tstep = 0.001        ;
time  = 0:Tstep:Tend ;

% Plotting random trajectories
for i = 0:1:500
    [tout,xout] = ode45(@fcNL, time, [-3+6*rand; -3+6*rand]) ;
    plot(xout(:,1),xout(:,2))
    axis([-3 3 -3 3]);
    hold on  
end
% Plotting special trajectories (attractice direction on resp eq pts)
Xinit = [ [0 1]; [0 -1]; [2 -1]; [-2 1] ]
for i = 1:1:4
    [tout,xout] = ode45(@fcNL, time, [Xinit(i,1); Xinit(i,2)]) ;
    plot(xout(:,1),xout(:,2))
    axis([-3 3 -3 3]); hold on
end
% Plotting eq pts
eq = [ [0 0]; [1 0]; [-1 0] ] ;
plot(eq(:,1), eq(:,2), 'go')
hold off

% Declaration de la fonction pour resolution
function dxdt = fcNL(t,x)
    % -----------------------------
    % Inputs 
    % time : ?
    % x    : [2x1] state vector
    % Output
    % dxdt : result of the derivate
    % -----------------------------
    A = [0 1 ; 1 0]    ; % Syst. Dynamic
    u = -2*x(1) - x(2) ; % Command Law
    % defining sat(u)
    if u > 1
        dxdt = A*x + [0; 1] ;
    else
        if u < -1
            dxdt = A*x + [0; -1] ;
        else 
            dxdt = A*x + [0;  u] ;
        end
    end
end