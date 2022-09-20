
% Dessin du robot 
% q : Configuration du robot
% DrawTool : peut être omis. Permet de faire apparaître le repère de l'organe terminal 
% DrawO4 : peut être omis. Permet d'afficher le point O4
function drawBM(q, DrawTool, DrawO4) 

if nargin==1
    DrawTool=0;
    DrawO4 = 0;
end
if nargin==2
    DrawO4 = 0;
end


% Longueurs
h = 0.8;
L1 = 0.4;
L2 = 0.4;
L3 = 0.2;

% Config
Th1 = q(1);
Th2 = q(2);
Th4 = q(4);
r3 =  q(3);

% TracÃ© R0
%drawFrame([eye(3) zeros(3,1);zeros(1,3) 1], 'R0')
drawFrame([eye(3) zeros(3,1);zeros(1,3) 1], 'R0')
hold on
x0 = 0;
y0 = 0;
z0 = 0;
x1 = x0;
y1 = y0;
z1 = h;
plot3([x0 x1], [y0, y1], [z0, z1],'-bo', 'linewidth',3);  
grid on            
hold on
xlabel('x')
ylabel('y')
zlabel('z')
%axis([-1 1 -1 1 0 1])
x2 = L1 * cos(Th1);
y2 = L1 * sin(Th1);
z2 = h;
plot3([x1 x2], [y1, y2], [z1, z2],'-mo', 'linewidth',3);              

x3 = L2 * cos(Th1+Th2) + x2;
y3 = L2 * sin(Th1+Th2) + y2;
z3 = z2;
plot3([x2 x3], [y2, y3], [z2, z3],'-bo', 'linewidth',3);              

x4 = x3;
y4 = y3;
z4 = z2 + r3;
plot3([x3 x4], [y3, y4], [z3, z4],'-ro', 'linewidth',3);              

text(x0-0.1, y0-0.1, z0, 'O0');
if DrawO4 == 1
    text(x4-0.15, y4-0.15, z4, 'O4');
end
if DrawTool==1
drawFrame([cos(Th1+Th2+Th4) -sin(Th1+Th2+Th4) 0 x4;
           sin(Th1+Th2+Th4) cos(Th1+Th2+Th4) 0 y4; 
           0 0 1 z4; zeros(1,3) 1], '', 0.25)  
end

