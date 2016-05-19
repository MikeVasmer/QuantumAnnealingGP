function [ betas ] = choose_betas_PT( beta_min, beta_max, M )
%CHOOSE_BETAS_PT Makes a geometric progression of betas in a length M
% vector, between beta_min and beta_max

betas = zeros(M, 1);
betas(1) = beta_min;
betas(M) = beta_max;

for k = 2:(M-1)    
    betas(k) = beta_min * (beta_min/beta_max)^((k-1)/(M-1));    
end


end

