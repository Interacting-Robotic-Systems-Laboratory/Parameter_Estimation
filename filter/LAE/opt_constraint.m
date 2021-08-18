function [p_t,p_o,p_r,v_t,v_o,v_r] = opt_constraint(AA,B,x,options,prob)

    prob.Objective = (AA*x-B)'*(AA*x-B);
    prob.Constraints.cons1 = x(1)*x(4)<=-1e-10;
    prob.Constraints.cons2 = x(2)*x(5)<=-1e-10;
    prob.Constraints.cons3 = x(3)*x(6)<=-1e-10;
    x0.x = [x0_1;x0_2;x0_3;x0_4;x0_5;x0_6];
    sol= solve(prob,x0,'Options',options);
    p_t = sol.x(1);
    p_o = sol.x(2);
    p_r = sol.x(3);
    v_t = sol.x(4);
    v_o = sol.x(5);
    v_r = sol.x(6);

end