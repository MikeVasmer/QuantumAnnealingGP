% Add main directory to path
addpath('../../');

% h's and J's
% Require that:
%     |J_N| << J_a
%     |J_N| < q_0 << J_a 
%     0 < q_i < J_a
%     |J_N| < q_0 << J_a
% H_N = J_N Z_1*Z_2*Z_3*Z_4 
N = 4;      % Fixed

% Require: |J_N| < q_0 << J_a
J_N = 1;    % Free
q_0 = 2;    % Free
J_a = 8;  % Free

% Steps to plot
steps = 51;

%four_local( J_N, q_0, J_a, steps );
two_local(  J_N, q_0, J_a, steps );



