function Data = initial_belief(q,v,para_ini,Data,N_p,P)
    sigma_q = [P(1,1),P(2,2),P(3,3)];
    sigma_v = [P(4,4),P(5,5),P(6,6)];
    sigma_para = [P(7,7),P(8,8),P(9,9)];
    
    
    State = zeros(9,N_p);
    i = 1;
    while i <= N_p
        v_o = mvnrnd(v,sigma_v,1);
        q_o = mvnrnd(q,sigma_q,1);
        para = mvnrnd(para_ini,sigma_para,1);
        if (isreal(para(1)))&&(isreal(para(2)))&&(isreal(para(3)))
            State(:,i) = [q_o';v_o';para'];
            i = i+1;
        else
            disp('error in PF');
        end
            
    end
    Data.PF_State_i = State;
    

end