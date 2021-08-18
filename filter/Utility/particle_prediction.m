function [q_p,v_p] = particle_prediction(S,q,v,para,u,N)

global I_zz m q_z g h alpha beta gamma;
alpha = para(1);
beta = para(2);
gamma = para(3);

m = S.mass;
I_zz = S.I_zz;
q_z = S.q_z;
h = S.h/N;
g = S.g;

global v_xo v_yo w_zo;


global p_x p_y p_z p_xt p_yt p_zt;

lower = -Inf*ones(7,1);
lower(7) = 0;
upper = Inf*ones(7,1);
fun = 'mcp_funjac_planar_sliding';

for i = 1:N

    if i == 1
        p_x = u(1); p_y = u(2); p_z = u(3); 
        p_xt = u(4); p_yt = u(5); p_zt = u(6);
        
        v_xo = v(1);
        v_yo = v(2);
        w_zo = v(3);
        Z = [v_xo;v_yo;w_zo;0;0;0;sqrt(v_xo^2+v_yo^2+w_zo^2)];
        
        q_o = q;
    else
        p_x = 0; p_y = 0; p_z = 0; 
        p_xt = 0; p_yt = 0; p_zt = 0;
        
        v_xo = s(1);
        v_yo = s(2);
        w_zo = s(3);
        Z = [v_xo;v_yo;w_zo;0;0;0;sqrt(v_xo^2+v_yo^2+w_zo^2)];
        
        q_o = q_p;
    end

    

    
 
    
    s = pathmcp(Z,lower,upper,fun);
  
    v_p = s(1:3);

    q_p = q_o + h*v_p;
   
end


end