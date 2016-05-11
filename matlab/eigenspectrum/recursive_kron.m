function [ out ] = recursive_kron( n, indicies, ins_matrices, prev_mat )

    % 2x2 Identity matrix
    iden = [[1, 0] ;[ 0, 1]];

    % If first call, set previous matrix to [1]
    switch nargin
    case 3
        prev_mat = [1];
        ins_matrices = reshape(ins_matrices,2,2,length(indicies));
    end
    
    % Decrement counter
    n = n-1;
    
    % If should finish
    if n==-1
        out = prev_mat;
    % If should call recursively
    else
        matrix_inserted = 0;
        for i = 1:length(indicies)           
            % If should insert matrix i next
            if indicies(i)==(n+1)
                matrix_inserted = 1;
                out = recursive_kron(n, indicies, ins_matrices, kron(ins_matrices(:,:,i),prev_mat));             
            end      
        end
        % If none inserted, then insert identity
        if matrix_inserted == 0;
            out = recursive_kron(n, indicies, ins_matrices, kron(iden,prev_mat));
        end
    end
     
end

