function [ conf, energy ] = piqmc(spin_start, HParams, monte_steps, trotter_slices, G_start, Temperature, step_flips)

    start_spin_config = repmat(transpose(spin_start), trotter_slices, 1)
    
    spin_config = start_spin_config
    
    n = length(spin_start)
    
    G = G_start
    
    step_value = (G_start - (0.00000001))/monte_steps
    
    for i = 1:monte_steps
        % Reduce the transverse field
        G = G_start - step_value*(i-1)
        % Specify global spin flip indices
        glob_flip_index = randperm(n,step_flips)
        % Perform local flips and evals
        for j = 1:trotter_slices
            new_spin_config = spin_config
            new_spin_config(j,:) = flip_spin(spin_config(j,:),step_flips)
            p_t = tran_prob(new_spin_config, spin_config, HParams, trotter_slices, Temperature, G)
            x_1 = rand;
            if x_1 <= p_t
                spin_config = new_spin_config
            end
        end
        % Perform global spin flips and evals 
        glob_spin_config = spin_config
        for j = 1:trotter_slices       
            for k = 1:length(glob_flip_index)
                glob_spin_config(j,glob_flip_index(k)) = -glob_spin_config(j,glob_flip_index(k))
            end
        end
        p_t_g = tran_prob(glob_spin_config, spin_config, HParams, trotter_slices, Temperature, G)
        x_g = rand;
        if x_g <= p_t_g
            spin_config = glob_spin_config
        end
    end
    
    % Get the conf with min energy
    energies = zeros([trotter_slices,1])
    for i = 1:trotter_slices
        energies(i) = Conf_energy(spin_config(i,:),HParams)
    end
    
    
    [energy, ind] = min(energies)
    spin_config
    conf = spin_config(ind,:)
end
        
            

    