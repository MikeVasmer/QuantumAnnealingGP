function [out] = lao_just_loops_3(num_spins, num_loops, adj)

    % ** Algorithm **
    % Generate (random) solution
    % Place M random loops on graph, each respecting the planted solution
    
    % Generate random solution, of size N
    solution = (round(rand(1,num_spins))*2)-1;
    
    % Initialise empty loop array
    loops = cell(1,num_loops);
    
    % Fill loop array with M loops
    loop_timer = tic;
    for i = 1:num_loops
        % Generate random walk loop
        loop = random_walk_loop_3( adj );
        % Add to loop array
        loops{i} = loop; 
        
        % Progress timer
        if toc(loop_timer) > 1
            disp(strcat(num2str(i),':',num2str(num_loops)));
            loop_timer = tic;
        end
    end
    
    % Calculate planted couplings and energies
    [J_global, gs_energy] = planted_hamiltonian_3(solution, loops);

    % Calculate sparsity
    count_adj = sum(sum(sum(adj)));
    count_J   = sum(sum(sum(abs(J_global))));
    
    out = count_J / count_adj;
        
end
