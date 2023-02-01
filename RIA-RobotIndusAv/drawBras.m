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
%function drawBras(q1,q2,q3,q4) 

X0=0;
Y0=0;
d1=0.5;
d2=0.5;
h=0.5;
q1=pi/2;
q2=pi/2;
q3=-h/2;
q4=0;
O0O1 = [d1*cos(q1) d1*sin(q1) h]';
O0O2 = O0O1 + [d2*cos(q1+q2) d2*sin(q1+q2) h]';
xori1 = O0O1(1);
yori1 = O0O1(2);
xori2 = O0O2(1);
yori2 = O0O2(2);
%plot3([X0,X0], [Y0, Y0], [0,h], 'k','linewidth',2);              
hold on
plot3([X0,X0+xori1], [Y0, Y0+yori1], [h,h],'linewidth',2);              
plot3([X0+xori1, X0+xori2], [Y0+yori1, Y0+yori2], [h,h], 'g','linewidth',2);              
plot3([X0+xori2, X0+xori2], [Y0+yori2, Y0+yori2], [h,h+q3],'r','linewidth',2);              
plot3([X0+xori2, X0+xori2], [Y0+yori2, Y0+yori2], [h+q3,h+q3],'bo','linewidth',14);              
axis([-1 1 -1 1 -1 1]);


R01 = [cos(q1) -sin(q1) 0;sin(q1) cos(q1) 0;0 0 1];
R12 = [cos(q2) -sin(q2) 0;sin(q2) cos(q2) 0;0 0 1];
R23 = eye(3);
R34 = [cos(q4) -sin(q4) 0;sin(q4) cos(q4) 0;0 0 1];
R04=R01*R12*R23*R34;
%T01 = [R01 O0O1;0 0 0 1];
%T12 = [R12 O1O2;0 0 0 1];
O2O3 = R01*R12*[0;0;q3];
%T23 = [R23 [0;0;q3];0 0 0 1];