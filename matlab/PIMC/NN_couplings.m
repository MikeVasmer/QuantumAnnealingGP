function [out] = NN_couplings(n, val)
    
    J_mat = zeros(n);
    
    for i = 1:n-1
            J_mat(i,i+1) = val;
    end
    
    out = J_mat + J_mat';