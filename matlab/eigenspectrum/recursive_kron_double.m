function [ out ] = recursive_kron_double( n, i1, ins_mat1, i2, ins_mat2, prev_mat )

    % i1 != i2
    if i1 == i2
        error('Require: i != k');
    end

    % 2x2 Identity matrix
    iden = [[1, 0] ;[ 0, 1]];

    % If first call, first_call = true, else first_call = false
    switch nargin
    case 5
        first_call = 1;
    case 6
        first_call = 0;
    end
    
    % Decrement counter
    n = n-1;
    
    % If first call, need to chose two 2x2 matrices
    if first_call
        % Decrement counter again because we are inserting two elements
        n = n-1;
        % If 
        if i1==(n+2) && i2==(n+1)
            out = recursive_kron_double(n, i1, ins_mat1, i2, ins_mat2, kron(ins_mat2,ins_mat1));
        % If 
        elseif i1==(n+1) && i2==(n+2)
            out = recursive_kron_double(n, i1, ins_mat1, i2, ins_mat2, kron(ins_mat1,ins_mat2));
        % If 
        elseif i1==(n+2)
            out = recursive_kron_double(n, i1, ins_mat1, i2, ins_mat2, kron(iden,ins_mat1));
        % If 
        elseif i1==(n+1)
            out = recursive_kron_double(n, i1, ins_mat1, i2, ins_mat2, kron(ins_mat1,iden));
        % If 
        elseif i2==(n+2)
            out = recursive_kron_double(n, i1, ins_mat1, i2, ins_mat2, kron(iden,ins_mat2));
        % If 
        elseif i2==(n+1)
            out = recursive_kron_double(n, i1, ins_mat1, i2, ins_mat2, kron(ins_mat2,iden));
        % If should not insert matrix
        else
            out = recursive_kron_double(n, i1, ins_mat1, i2, ins_mat2, kron(iden,iden));
        end
    % If not first call, need to chose one 2x2 matrices
    else
        % If should finish
        if n==-1
            out = prev_mat;
        % If should call recursively
        else
            % If should insert i1 matrix next
            if i1==(n+1)
                out = recursive_kron_double(n, i1, ins_mat1, i2, ins_mat2, kron(ins_mat1,prev_mat));
            % If should insert i2 matrix next
            elseif i2==(n+1)
                out = recursive_kron_double(n, i1, ins_mat1, i2, ins_mat2, kron(ins_mat2,prev_mat));
            % If should not inset matrix
            else
                out = recursive_kron_double(n, i1, ins_mat1, i2, ins_mat2, kron(iden,prev_mat));
            end
        end
    end
     
end

