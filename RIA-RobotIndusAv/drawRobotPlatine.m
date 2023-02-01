%%  $Id: drawRobotPlatine.m,v 2.2 2004/09/08 14:25:55 dfolio Exp $
%  drawRobotPlatine.m -- 
% Function    : drawRobotPlatine
% Description : draw a robot with it's turntable (platine)
% Parameter   : 
%      - (x0, y0, theta0) : robots initial state
%      - Theta_pl         : turntable (platine) state in radian   
%      - [scale] : the robots scale 
%                 (default scale = 0.75)  
%      - [motif] :  a character string made from one element
%        from any or all the following 3 columns:
%             b     blue          .     point              -     solid
%             g     green         o     circle             :     dotted
%             r     red           x     x-mark             -.    dashdot 
%             c     cyan          +     plus               --    dashed   
%             m     magenta       *     star
%             y     yellow        s     square
%             k     black         d     diamond
%                                 v     triangle (down)
%                                 ^     triangle (up)
%                                 <     triangle (left)
%                                 >     triangle (right)
%                                 p     pentagram
%                                 h     hexagram
%                      
%      For example, if motif='b-' draw a robot with a blue solid line.
%      So it's like to plot function 
%

%------------------------------------------------------------------------------
% Copyright (c) 2004 LAAS/CNRS, Toulouse, France        --  Fri Mar 19 2004
% All rights reserved.                                     David FOLIO
%------------------------------------------------------------------------------
%
% Author : David FOLIO (dfolio@laas.fr)
%          PhD Thesis Student,  RIA group, LAAS-CNRS, Toulouse (France)
%          Supported by The European Social Fund.
% Date   : Fri Mar 19 2004
% Version: $Revision: 2.2 $
%
%------------------------------------------------------------------------------
% $Log: drawRobotPlatine.m,v $
% Revision 2.2  2004/09/08 14:25:55  dfolio
% update...
%
% Revision 2.1  2004/07/27 16:52:17  dfolio
% backup
%
% Revision 1.2  2004/06/11 11:25:45  dfolio
% updating matlabl/lib tools
%
%
%------------------------------------------------------------------------------
% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  TODO && BUGS !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%




%  function [result] = drawRobotPlatine(args)
function drawRobotPlatine(X0,Y0,Theta0,Theta_pl, scale, motif) 
 
%[ D_rob, H_rob, Dx, PC]=initRobots;

  D_rob=0.34544;
  H_rob=0.8;
  Dx = 0.1;
  
%% parametres de configuration du robot 
if (nargin == 4) 
  scale = D_rob/2; %% rapport d'eche 
  motif = '-b'; 
elseif(nargin==5) 
  motif = '-b'; 
end 
 

% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 
hold on;
d =scale;
% cercle representant le robot 
drawcircle(X0,Y0,d,motif); 
xori = d * cos(Theta0) ;
yori = d * sin(Theta0) ;

x_pl0 = X0+2*d * cos(Theta0)*Dx ;
y_pl0 = Y0+2*d * sin(Theta0)*Dx ;

x_pl = 1.5*d * cos(Theta_pl+Theta0) ;
y_pl = 1.5*d * sin(Theta_pl+Theta0) ;

% axe donnant l'orientation
plot3([X0,X0+xori], [Y0, Y0+yori], [0,0],'linewidth',2);              
% axe des roues
plot3([X0+yori,X0-yori], [Y0-xori, Y0+xori], [0,0],motif);    

% axe donnant l'orientation de la platine 
plot3([x_pl0,x_pl0+x_pl], [y_pl0, y_pl0+y_pl], [H_rob,H_rob],'-mo');              
%plot3([X0 X0],[Y0 Y0],[0 H_rob],'linewidth',2)
%plot3([x_pl0,x_pl0],[Y0 Y0],[0 H_rob],'linewidth',3)
plot3([x_pl0,x_pl0],[y_pl0 y_pl0],[0 H_rob],'linewidth',3)

