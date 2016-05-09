function [ out ] = recursive_kron( n, i, ins_mat, prev_mat )

    % 2x2 Identity matrix
    iden = [[1, 0] ;[ 0, 1]];

    % If first call, first_call = true, else first_call = false
    switch nargin
    case 3
        first_call = 1;
    case 4
        first_call = 0;
    end
    
    % Decrement counter
    n = n-1;
    
    % If first call, need to chose two 2x2 matrices
    if first_call
        % Decrement counter again because we are inserting two elements
        n = n-1;
        % If should insert matrix at end
        if i==(n+2)
            out = recursive_kron(n, i, ins_mat, kron(iden,ins_mat));
        % If should inset matrix at end-1
        elseif i==(n+1)
            out = recursive_kron(n, i, ins_mat, kron(ins_mat,iden));
        % If should not inset matrix
        else
            out = recursive_kron(n, i, ins_mat, kron(iden,iden));
        end
    % If not first call, need to chose one 2x2 matrices
    else
        % If should finish
        if n==-1
            out = prev_mat;
        % If should call recursively
        else
            % If should insert matrix next
            if i==(n+1)
                out = recursive_kron(n, i, ins_mat, kron(ins_mat,prev_mat));
            % If should not inset matrix
            else
                out = recursive_kron(n, i, ins_mat, kron(iden,prev_mat));
            end
        end
    end
   
    
end

