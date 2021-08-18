function X = Depvar(S,v_p,v,u)
h = S.h;
m = S.mass;
I_zz = S.I_zz;
q_z = S.q_z;
g = S.g;
v_xp = v_p(1,:);
v_yp = v_p(2,:);
w_zp = v_p(3,:);

v_x = v(1,:);
v_y = v(2,:);
w_z = v(3,:);

p_x = u(1);
p_y = u(2);
p_z = u(3);
p_xt = u(4);
p_yt = u(5);
p_zt = u(6);


M_1 = [1,0,0;
        0,1,0;
        p_xt/(m*g*h-p_z),p_yt/(m*g*h-p_z),1];
    
Y_1 = [m*(v_xp-v_x)-p_x;
        m*(v_yp-v_y)-p_y;
        I_zz*(w_zp-w_z)-p_zt];
    
X_1 = M_1\Y_1;

p_t = X_1(1,:);
p_o = X_1(2,:);
p_r = X_1(3,:);

M_2 = [1,0,0;
       0,1,0;
       0,0,1];
    
Y_2 = [v_xp-w_zp.*(-p_xt-p_o*q_z)/(m*g*h-p_z);v_yp+w_zp.*(p_yt-p_t*q_z)/(m*g*h-p_z);w_zp];
    
X_2 = M_2\Y_2;

X = [X_1;X_2];



end