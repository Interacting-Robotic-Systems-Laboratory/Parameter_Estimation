function [F, J, domerr] = mcp_funjac_planar_sliding(z, jacflag)
%% initialize
z = z(:);
F = [];
J = [];
domerr = 0;

global I_zz m q_z g h alpha beta gamma;

global v_xo v_yo w_zo;

global p_x p_y p_z p_xt p_yt p_zt;


v_x = z(1);
v_y = z(2);
w_z = z(3);
p_t = z(4);
p_o = z(5);
p_r = z(6);
sigma = z(7);

r_x = (p_yt-p_t*q_z)/(m*g*h-p_z);
r_y = (-p_xt-p_o*q_z)/(m*g*h-p_z);

F(1) = m*(v_x-v_xo)-p_t-p_x;
F(2) = m*(v_y-v_yo)-p_o-p_y;
F(3) = I_zz*(w_z-w_zo)-p_r-p_zt+p_t*r_y-p_o*r_x;
F(4) = alpha^2*(m*g*h-p_z)*(v_x-w_z*r_y)+p_t*sigma;
F(5) = beta^2*(m*g*h-p_z)*(v_y+w_z*r_x)+p_o*sigma;
F(6) = gamma^2*(m*g*h-p_z)*w_z+p_r*sigma;
F(7) = 1-(p_t/((m*g*h-p_z)*alpha))^2-(p_o/((m*g*h-p_z)*beta))^2-(p_r/((m*g*h-p_z)*gamma))^2;

if(jacflag)
     J = [                      m,                     0,                        0,                                                       -1,                                                        0,                                  0,   0
                                0,                     m,                        0,                                                        0,                                                       -1,                                  0,   0
                                0,                     0,                     I_zz, (p_xt + p_o*q_z)/(p_z - g*h*m) - (p_o*q_z)/(p_z - g*h*m), (p_yt - p_t*q_z)/(p_z - g*h*m) + (p_t*q_z)/(p_z - g*h*m),                                 -1,   0
           -alpha^2*(p_z - g*h*m),                     0, alpha^2*(p_xt + p_o*q_z),                                                    sigma,                                          alpha^2*q_z*w_z,                                  0, p_t
                                0, -beta^2*(p_z - g*h*m),  beta^2*(p_yt - p_t*q_z),                                          -beta^2*q_z*w_z,                                                    sigma,                                  0, p_o
                                0,                     0,   -gamma^2*(p_z - g*h*m),                                                        0,                                                        0,                              sigma, p_r
                                0,                     0,                        0,                       -(2*p_t)/(alpha^2*(p_z - g*h*m)^2),                        -(2*p_o)/(beta^2*(p_z - g*h*m)^2), -(2*p_r)/(gamma^2*(p_z - g*h*m)^2),   0];
     J = sparse(J);
end
    
    
    
    
    
end