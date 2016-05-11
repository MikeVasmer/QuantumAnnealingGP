function [ out ] = q_i( N, i, J_N, q_0)

    if mod(N-i,2) == 0
       out = -J_N + q_0;
    else
       out =  J_N + q_0;
    end

end

