% ------------------------- %
%  CNL TP1 Saturation Main  %
%  Gabriel-Calixte    Ronk  %
% ------------------------- %

clear all; close all;

%% Q1.3 - Dynamique du Systeme


%% Q2.2 - Saturation

% Parameters
xinit = [1;0];
Tend = 10; Tstep = 0.001;
time = 0:Tstep:Tend;

%% 1/ SIMULATION SIMULINK
% Open loop system
% G(p)=1/(p(p+1))
A = [0 1; 0 -1];
B = [0;1];
C = [1 0];
% Closed loop system 
% NL1
% output = sim('TD2_simu_new');
% figure(1) % Signaux en fonction du temps
% plot(output.tout, output.simout.signals.values)
% figure(2) % Plan de phase
% plot(output.simout.signals.values(:,1),output.simout.signals.values(:,2))

%% 2/ SIMULATION MALTAB
% Closed loop system
[tout, xout] = ode45(@fcNL3,time,xinit);
figure(3) % Signaux en fonction du temps
plot(tout, xout)
figure(4)
plot(xout(:,1), xout(:,2))

function dxdt = fcNL1(t,x)
    A = [0 1; 0 -1];
    if x(1) > 0
        dxdt = A*x + [0; -1];
    else 
        dxdt = A*x + [0; 1];
    end
end

function dxdt = fcNL2(t,x)
    A = [0 1; 0 -1];
    if x(1) > 0.5
        dxdt = A*x + [0; -1];
    else 
        if x(1) < -0.5
            dxdt = A*x + [0; 1];
        else
            dxdt = A*x;
        end
    end
end

function dxdt = fcNL3(t,x)
    A = [0 1; 0 -1];
    if x(1) > 1/4 
        dxdt = A*x + [0; -1];
    else 
        if x(1) > -1/4 && x(2) < 0
            dxdt = A*x + [0; -1];
        else
            dxdt = A*x + [0; 1];
        end
    end
end