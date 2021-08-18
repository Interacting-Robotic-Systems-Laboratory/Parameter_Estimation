function para = StateTransPara(S,v_p,v,u)

h = S.h;
m = S.mass;
g = S.g;

p_x = u(1);
p_y = u(2);
p_z = u(3);
p_xt = u(4);
p_yt = u(5);
p_zt = u(6);


X= Depvar(S,v_p,v,u);

p_t = X(1,:);
p_o = X(2,:);
p_r = X(3,:);
v_t = X(4,:);
v_o = X(5,:);
v_r = X(6,:);


sigma = -(p_t.*v_t+p_o.*v_o+p_r.*v_r)/(m*g*h-p_z);

alpha = sqrt(-p_t.*sigma./((m*g*h-p_z)*v_t));
beta = sqrt(-p_o.*sigma./((m*g*h-p_z)*v_o));
gamma = sqrt(-p_r.*sigma./((m*g*h-p_z)*v_r));

para = [alpha;beta;gamma];
end