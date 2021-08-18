 function para = compute_parameter(S,T,v_f_est)
m = S.mass; %kg
q_z = S.q_z;
I_z = S.I_zz;
g = S.g; 

N_1 = S.Estimation_window(1);
N_2 = S.Estimation_window(2);

para = NaN(4,length(T));



% setting optimization problem
prob = optimproblem;
x = optimvar('x',6,1);
options = optimoptions('fmincon','Display','off','ConstraintTolerance',1e-16,'OptimalityTolerance',1e-16);

% method == 'opt' or 'fixed'
method = 'fixed';
for i = N_1+2:N_2
    tic
    h = T(i) - T(i-1);
    v_x = v_f_est(1,i);v_y = v_f_est(2,i);w_z = v_f_est(3,i);
    p_n = m*g*h;

    v_xo = v_f_est(1,i-1);v_yo = v_f_est(2,i-1);w_zo = v_f_est(3,i-1);

    a1 = -w_z*q_z/p_n;
    a2 = -a1;
    AA = [1,0,0,0,0,0;
         0,1,0,0,0,0;
         0,0,1,0,0,0;
         0,a1,0,1,0,0;
         a2,0,0,0,1,0;
         0,0,0,0,0,1];
     B = [m*(v_x-v_xo);m*(v_y-v_yo);I_z*(w_z-w_zo);v_x;v_y;w_z];
    
     % initial guess for optimization
    x0_1 = m*(v_x-v_xo);
    x0_2 = m*(v_y-v_yo);
    x0_3 = I_z*(w_z-w_zo);
    
    x0_4 = v_x +w_z*(x0_2*q_z/p_n);
    x0_5 = v_y -w_z*(x0_1*q_z/p_n);
    x0_6 = w_z;
    if (x0_1*x0_4+x0_2*x0_5+x0_3*x0_6) > 0
        %disp('violating energy dissipation ');
    end
    if (x0_1*x0_4>0)||(x0_2*x0_5>0)||(x0_3*x0_6>0)
        if (x0_1*x0_4>0)
            
            %disp('error in v_t');
        end
        if (x0_2*x0_5>0)
            
            %disp('error in v_o');
        end

        if (x0_3*x0_6>0)
            
            %disp('error in v_r');
        end
       if strcmp(method,'opt') 
           [p_t,p_o,p_r,v_t,v_o,v_r] = opt_constraint(AA,B,x,options,prob);
            sigma = (p_t*v_t+p_o*v_o+p_r*v_r)/p_n^2;
            para(1:3,i) = [sqrt((p_t/v_t)*sigma),...
                               sqrt((p_o/v_o)*sigma),sqrt((p_r/v_r)*sigma)];
            para(4,i) = 0;
       else
           para(1:3,i) = S.fixed_parameter';
           para(4,i) = 0;
       end
    else
        p_t = x0_1;
        p_o = x0_2;
        p_r = x0_3;
        v_t = x0_4;
        v_r = x0_6;
        v_o = x0_5;
        
        sigma = (p_t*v_t+p_o*v_o+p_r*v_r)/p_n^2;
       if abs(v_t) <=1e-8
           para(1,i) = NaN;
           disp('error');
       else
           para(1,i) = sqrt((p_t/v_t)*sigma);
       end

       if abs(v_o) <=1e-8
           para(2,i) = NaN;
           disp('error');
       else
           para(2,i) = sqrt((p_o/v_o)*sigma);
       end
          

       if abs(v_r) <=1e-8
           para(3,i) = NaN;
           disp('error');
       else
           para(3,i) = sqrt((p_r/v_r)*sigma);
           para(4,i) = 1;
       end
       
    end
    toc 
     
end











end