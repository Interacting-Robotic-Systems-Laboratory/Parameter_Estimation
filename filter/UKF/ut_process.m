function [y,Y,P,Y1]=ut_process(S,X,u,Wm,Wc,n,R)
%Unscented Transformation
%Input:
%        f: nonlinear map
%        X: sigma points
%       Wm: weights for mean
%       Wc: weights for covraiance
%        n: numer of outputs of f
%        R: additive covariance
%Output:
%        y: transformed mean
%        Y: transformed smapling points
%        P: transformed covariance
%       Y1: transformed deviations
L=size(X,2);
y=zeros(n,1);
Y=zeros(n,L);
for k=1:L
    % function velocity and position
    q = X(1:3,k);
    v = X(4:6,k);
    beta = X(7:9,k);
    
    [q_p,v_p] = particle_prediction(S,q,v,beta,u,1);
    
    beta_p = StateTransPara(S,v_p,v,u);
    %beta_p = beta;
    Y(:,k) = [q_p;v_p;beta_p];
    y=y+Wm(k)*Y(:,k);       
end
Y1=Y-y(:,ones(1,L));
P=Y1*diag(Wc)*Y1'+R;          
end