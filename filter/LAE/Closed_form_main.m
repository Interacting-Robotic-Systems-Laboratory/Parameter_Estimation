function [para, para_chosen] = Closed_form_main(S,T,q_f_est,v_f_est)
%% compute the parameters for prediction
para = compute_parameter(S,T,v_f_est);
para_chosen = est_parameter(para);
end