%%  
% Function    : drawFrame
% Description : draw a frame
% Parameter   : 
%      - T : Transformation matrix
%      - FrameName : Label of the frame (eg, Rc) between quotes
%      - [scale] : the axes scale (0<scale<1)
%                 (default scale = 1)  
%
% Color code : blue : x / red : y / magenta : z

function drawFrame(T, FrameName, scale) 
plot3([T(1,4)], [T(2,4)], [T(3,4)],'ko','linewidth',2,'MarkerSize',10);              
hold on
%axis([-5 5 -5 5 -5 5])
xlabel('x')
ylabel('y')
zlabel('z')
grid on
text(T(1,4)-0.5, T(2,4)-0.5, T(3,4)-0.5, FrameName);
if nargin ==1
  error('il manque un argument')
end
if nargin==2
  scale = 1;
end
T(:,1) = scale * T(:,1);
T(:,2) = scale * T(:,2);
T(:,3) = scale * T(:,3);
% Tracé x en bleu
plot3([T(1,4),T(1,1)+T(1,4)], [T(2,4) T(2,1)+T(2,4)], [T(3,4) T(3,1)+T(3,4)],'b','linewidth',2);
plot3([T(1,1)+T(1,4)], [T(2,1)+T(2,4)], [T(3,1)+T(3,4)],'bh','linewidth',2)
text([T(1,1)+T(1,4)], [T(2,1)+T(2,4)-0.1], [T(3,1)+T(3,4)], 'x');
% Tracé y en rouge
plot3([T(1,4),T(1,2)+T(1,4)], [T(2,4) T(2,2)+T(2,4)], [T(3,4) T(3,2)+T(3,4)],'r','linewidth',2);
plot3([T(1,2)+T(1,4)], [T(2,2)+T(2,4)], [T(3,2)+T(3,4)],'rh','linewidth',2);
text([T(1,2)+T(1,4)-0.1], [T(2,2)+T(2,4)], [T(3,2)+T(3,4)], 'y');
% Tracé z en noir
plot3([T(1,4),T(1,3)+T(1,4)], [T(2,4) T(2,3)+T(2,4)], [T(3,4) T(3,3)+T(3,4)],'m','linewidth',2);
plot3([T(1,3)+T(1,4)], [T(2,3)+T(2,4)], [T(3,3)+T(3,4)],'mh','linewidth',2);  
text([T(1,3)+T(1,4)+0.1], [T(2,3)+T(2,4)], [T(3,3)+T(3,4)+0.01], 'z');




