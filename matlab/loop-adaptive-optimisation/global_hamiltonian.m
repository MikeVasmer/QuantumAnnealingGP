function [J_global] = global_hamiltonian( solution, loops )

    % Number of spins
    num_spins = length(solution);
    % Number of loops
    num_loops = length(loops(:,1));

    % Initialise global couplings matrix with zeros
    J_global = zeros(num_spins, num_spins);
    
    % Calculate global couplings
    disp('Calculating global Hamiltonian...');
    tic;
    for i = 1:num_loops
        % Calculate local Hamiltonian couplings
        J_local = local_hamiltonian(solution, loops(i,:));
        % Update global, by adding them together
        J_global = J_global + J_local;
        % Update global couplings, overwriting values
%         for j = 1:numel(J_global)
%             % If coupling set in local loop, then overwrite global coupling
%             if J_local(j) ~= 0
%                 J_global(j) = J_local(j);
%             end
%         end

        % Progress timer
        if toc > 1
            disp(strcat(num2str(i),':',num2str(num_loops)));
            tic;
        end
    end
    
    % Normalise final J_global
    for j = 1:numel(J_global)
        if J_global(j) > 0
            J_global(j) = 1;
        elseif J_global(j) < 0
            J_global(j) = -1;
        end
    end

end

