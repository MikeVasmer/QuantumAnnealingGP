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
J_a = 5;  % Free

% Steps to plot
steps = 51;

%three_local( J_N, steps );
two_local( J_a, steps );



