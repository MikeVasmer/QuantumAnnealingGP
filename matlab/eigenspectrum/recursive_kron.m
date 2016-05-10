function [ out ] = recursive_kron( n, i, ins_mat, prev_mat )

    % 2x2 Identity matrix
    iden = [[1, 0] ;[ 0, 1]];

    % If first call, set previous matrix to [1]
    switch nargin
    case 3
        prev_mat = [1];
    end
    
    % Decrement counter
    n = n-1;

    % If should finish
    if n==-1
        out = prev_mat;
    % If should call recursively
    else
        % If should insert matrix next
        if i==(n+1)
            out = recursive_kron(n, i, ins_mat, kron(ins_mat,prev_mat));
        % If should insert identity
        else
            out = recursive_kron(n, i, ins_mat, kron(iden,prev_mat));
        end
    end

   
end

