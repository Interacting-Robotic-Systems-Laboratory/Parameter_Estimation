function [x,P]=ukf(S,x,z,u,P,Q,R)
L=numel(x);                                 %numer of states
m=numel(z);                                 %numer of measurements

%% steel part
% alpha=0.7;                                 %default, tunable
% ki=0;                                       %default, tunable
% beta=2;  

%% wooden block
alpha=0.5;                                 %default, tunable
ki=0;                                       %default, tunable
beta=2;                                     %default, tunable
%% plastic plate
%alpha=1;                                 %default, tunable
%ki=1;                                       %default, tunable
%beta=2;                                     %default, tunable
%%
lambda=alpha^2*(L+ki)-L;                    %scaling factor
c=L+lambda;                                 %scaling factor

Wm=[lambda/c 0.5/c+zeros(1,2*L)];           %weights for means
Wc=Wm;
Wc(1)=Wc(1)+(1-alpha^2+beta);               %weights for covariance
c=sqrt(c);
X=sigma(x,P,c);  

[x1,X1,P1,X2]=ut_process(S,X,u,Wm,Wc,L,Q);          %unscented transformation of process
% X1=sigmas(x1,P1,c);                         %sigma points around x1
% X2=X1-x1(:,ones(1,size(X1,2)));             %deviation of X1
[z1,Z1,P2,Z2]=ut_measurement(X1,Wm,Wc,m,R);       %unscented transformation of measurments
P12=X2*diag(Wc)*Z2';                        %transformed cross-covariance
K=P12/P2;
x=x1+K*(z-z1);                              %state update
P=P1-K*P12';                                %covariance update

% update Q
% a1 = 0.2;
% mu_k = z - x1(1:3);
% Q = ((1-a1)*Q + a1*(K*(mu_k*mu_k')*K'));
end