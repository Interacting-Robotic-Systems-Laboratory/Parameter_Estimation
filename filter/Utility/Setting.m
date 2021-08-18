function S = Setting(Object)
S = struct();

%measurement noise
%S.R = [(1.5e-3)^2,0,0;0,(0.46e-3)^2,0;0,0,(0.49*(pi/180))^2]; 
S.R = [(1.5e-3)^2,0,0;0,(0.46e-3)^2,0;0,0,(0.49*(pi/180))^2]; 
% number of particle of PF
S.N_Particle = 100;

if strcmp(Object,'wooden')
    S.mass = 0.262;
    S.I_zz = 2.46e-4;
    S.q_z = 0.0381;
    S.g = 9.8;
    S.para_ini = [0.2;0.2;0.004];
    
    % process noise for q is almost zero
    S.Q = eye(9);
    
    S.fixed_parameter = [0.234;0.231;6.6e-3];
%     
%%%% the parameters chosen
%     c1 = 60^2;
%     S.Q(1:3,1:3) = S.R;
%     S.Q(4,4) = S.R(1,1)*c1;
%     S.Q(5,5) = S.R(2,2)*c1;
%     S.Q(6,6) = S.R(3,3)*c1; 
%     S.Q(7,7) = 6.6335^2*1e-8; 
%     S.Q(8,8) = 8.3333^2*1e-8;
%     S.Q(9,9) = 1e-8;
% initial noise
%     c2 = 60^2;
%     S.P = eye(9);
%     S.P(1:3,1:3) = S.R;
%     
%     S.P(4,4) = S.R(1,1)*c2;
%     S.P(5,5) = S.R(2,2)*c2;
%     S.P(6,6) = S.R(3,3)*c2; 
%     S.P(7,7) = 0.05; 
%     S.P(8,8) = 0.05;
%     S.P(9,9) = 0.05/30^2;
    
%%%% parameters to be tested
    S.Q(1:3,1:3) = S.R/10;
    S.Q(4,4) = S.R(1,1)/10;
    S.Q(5,5) = S.R(2,2)/10;
    S.Q(6,6) = S.R(3,3)/10; 
    S.Q(7,7) = 1e-8; 
    S.Q(8,8) = 1e-8;
    S.Q(9,9) = 1e-8;
    
    c2 = 1000;
    S.P = eye(9);
    S.P(1:3,1:3) = S.R;
    
    S.P(4,4) = S.R(1,1)*c2;
    S.P(5,5) = S.R(2,2)*c2;
    S.P(6,6) = S.R(3,3)*c2; 
    S.P(7,7) = 0.01; 
    S.P(8,8) = 0.01;
    S.P(9,9) = 0.01/20;


    
    addpath('wooden_block');
  
elseif strcmp(Object,'steel')
    S.mass = 0.127;
    S.I_zz = 3.2e-5;
    S.q_z = 0.007;
    S.g = 9.8;
    S.para_ini = [0.3;0.3;0.002];
    S.fixed_parameter = [0.316;0.323;3.3e-3];
    % process noise for q is almost zero
    S.Q = eye(9);
    
    c1 = 60^2;
%     
%     
    S.Q(1:3,1:3) = S.R;
    S.Q(4,4) = S.R(1,1)*c1;
    S.Q(5,5) = S.R(2,2)*c1;
    S.Q(6,6) = S.R(3,3)*c1; 
    S.Q(7,7) = 1e-8; 
    S.Q(8,8) = 1e-8;
    S.Q(9,9) = 1e-9;

    % initial noise
    c2 = 60^2;
    S.P = eye(9);
    S.P(1:3,1:3) = S.R;
    
    S.P(4,4) = S.R(1,1)*c2;
    S.P(5,5) = S.R(2,2)*c2;
    S.P(6,6) = S.R(3,3)*c2; 
    S.P(7,7) = 0.05; 
    S.P(8,8) = 0.05;
    S.P(9,9) = 0.005/30^2;
    
    addpath('steel'); 
   
elseif strcmp(Object,'plastic')
    S.I_zz = 2.6e-4;
    S.mass = 0.057;
    S.q_z = 0.024;
    S.g = 9.8;
    S.para_ini = [0.26;0.26;0.0171];

    S.fixed_parameter = [0.256;0.264;16.9e-3];
    % process noise for q is almost zero
    S.Q = eye(9);
    % c is the std of parameter gamma
    c1 = (1e-4)^2;

    S.Q(1:3,1:3) = S.R;
    S.Q(4,4) = (1.5e-3)^2*60^2;
    S.Q(5,5) = (0.46e-3)^2*60^2;
    S.Q(6,6) = (0.49*(pi/180))^2*60^2; 
    S.Q(7,7) = 2.8625^2*c1; 
    S.Q(8,8) = 5.5375^2*c1;
    S.Q(9,9) = c1;

    % initial noise
    S.P = 1e-6*eye(9);
    S.P(1:3,1:3) = S.R;
    
    S.P(4,4) = (1.5e-3)^2*60^2;
    S.P(5,5) = (0.46e-3)^2*60^2;
    S.P(6,6) = (0.49*(pi/180))^2*60^2; 
%     S.P(7,7) = 0.2; 
%     S.P(8,8) = 0.05;
%     S.P(9,9) = 0.001;
    S.P(7:9,7:9) = S.Q(7:9,7:9); 
    
    addpath('plastic_plate');    

end



end