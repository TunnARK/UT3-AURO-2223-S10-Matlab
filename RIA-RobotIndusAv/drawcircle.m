%  drawcircle.m -- 
% Function    : drawcircle
% Description :  draw a cicrcle
% Parameter   : 
%      - (x0, y0) :  cicle center coordinate
%      - r        : circle radius
% Optionels:
%      - [N]      : number of points to discretisate the circle (default N=20)
%      - [motif]  :  a character string made from one element
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

%------------------------------------------------------------------------------
% Copyright (c) 2004 LAAS/CNRS, Toulouse, France        --  Fri Mar 19 2004
% All rights reserved.                                     David FOLIO
%------------------------------------------------------------------------------
%
% Author : David FOLIO (dfolio@laas.fr)
%          PhD Thesis Student,  RIA group, LAAS-CNRS, Toulouse (France)
%          Supported by The European Social Fund.
% Date   : Fri Mar 19 2004
% Version: 1.2

%------------------------------------------------------------------------------
% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  TODO && BUGS !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%

%%  $Id: drawcircle.m,v 2.2 2004/09/08 14:25:55 dfolio Exp $


function drawcircle(x0, y0, r,arg1, arg2)

% valeur par defaut 
theta=0;
i=1;
n=20;
motif = 'b';
  
% test les arguments de la functions
if (nargin == 3) 
  motif = 'b';
  n =20;
elseif(nargin == 4)
  if(isnumeric(arg1))
    n = arg1;
    motif = 'b';
  elseif(isstr(arg1))
    motif =arg1;
    n = 20;
  else
    error('drawcircle -> error : argument arg1 optionel non reconnu');
  end    
elseif (nargin == 5)
  if(isnumeric(arg1)&isstr(arg2))
    n = arg1;
    motif = arg2;
  elseif(isnumeric(arg2)&isstr(arg1))
    n = arg2;
    motif = arg1;
  else
    error('drawcircle -> error : parametres optionnels non valide');
  end
else
  error('drawcircle -> error : nombre de parametre incorrect :\ndrawcerle(x, y, r, [N: entier], [MOTIF: chaine d element au format plot]) ')
end


  
% function de calcul des points du cercle
while theta<=2*pi
  x(i)=x0+r*cos(theta);
  y(i)=y0+r*sin(theta);
  theta=theta+pi/n;
  i=i+1;
end


hold on;           % on redessine sur la figure active
try
  plot(x,y,motif); % trace du cercle
catch
  error(['chaine de motif incorect, voir la function plot pour plus information']);
end

