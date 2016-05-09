function [ out ] = recursive_kron_triple( n, i1, ins_mat1, i2, ins_mat2, i3, ins_mat3, prev_mat )

    % i1 != i2
    if i1 == i2 || i1 == i3 || i2 == i3
        error('Require: index 1 != index 2 != index 3');
    end

    % 2x2 Identity matrix
    iden = [[1, 0] ;[ 0, 1]];

    % If first call, set previous matrix to [1]
    switch nargin
    case 7
        prev_mat = [1];
    end
    
    % Decrement counter
    n = n-1;
    
    % If should finish
    if n==-1
        out = prev_mat;
    % If should call recursively
    else
        % If should insert i1 matrix next
        if i1==(n+1)
            out = recursive_kron_triple(n, i1, ins_mat1, i2, ins_mat2, i3, ins_mat3, kron(ins_mat1,prev_mat));
        % If should insert i2 matrix next
        elseif i2==(n+1)
            out = recursive_kron_triple(n, i1, ins_mat1, i2, ins_mat2, i3, ins_mat3, kron(ins_mat2,prev_mat));
        % If should insert i3 matrix next
        elseif i3==(n+1)
            out = recursive_kron_triple(n, i1, ins_mat1, i2, ins_mat2, i3, ins_mat3, kron(ins_mat3,prev_mat));
        % If should insert identity
        else
            out = recursive_kron_triple(n, i1, ins_mat1, i2, ins_mat2, i3, ins_mat3, kron(iden,prev_mat));
        end
    end
     
end

