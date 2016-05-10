function [ out ] = random_coef( dim, min, max, density )

    % Generate random matrix
    if length(dim) == 1
        rand_mat = (rand(1,dim)*(max-min))+min;
    else
        rand_mat = (rand(dim)*(max-min))+min;
    end

    % Create a density of 0's
    for i = 1:numel(rand_mat)
        if rand() > density
            rand_mat(i) = 0;
        end
    end
    
    % Return final matrix
    out = rand_mat;
    
end

