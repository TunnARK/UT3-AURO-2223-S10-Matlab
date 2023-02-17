function [q_dot] = commande(opc,s_o,s_b)
% opc [3x4] coord point p repere camera
% s_o [8x1] coord metrique plan image
% s_b [8x1] coord point cible
e = s_o - s_b ;

% Matrice d'interaction
L_red1 = [ 0          s_o(1)/opc(3,1) s_o(1)*s_o(2) ;
          -1/opc(3,1) s_o(2)/opc(3,1) 1 + s_o(2)^2  ];
L_red2 = [ 0          s_o(3)/opc(3,2) s_o(3)*s_o(4) ;
          -1/opc(3,2) s_o(4)/opc(3,2) 1 + s_o(4)^2  ];
L_red3 = [ 0          s_o(5)/opc(3,3) s_o(5)*s_o(6) ;
          -1/opc(3,3) s_o(6)/opc(3,3) 1 + s_o(6)^2  ];
L_red4 = [ 0          s_o(7)/opc(3,4) s_o(7)*s_o(8) ;
          -1/opc(3,4) s_o(8)/opc(3,4) 1 + s_o(8)^2  ];
L_total = [ L_red1 ; L_red2 ; L_red3 ; L_red4 ];


end

