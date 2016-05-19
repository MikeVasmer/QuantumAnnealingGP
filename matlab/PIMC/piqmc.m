function [ conf, energy ] = piqmc(spin_start, HParams, monte_steps, trotter_slices, G_start, Temperature, step_flips)
    
    [h, Jzz, Jxx, Jzzz, Jxxx] = deal(HParams{:});
    
    start_spin_config = repmat(transpose(spin_start), trotter_slices, 1);
    
    % Calculate the initial energy
    %start_eng = Ham_d1(start_spin_config, HParams, trotter_slices, Temperature, G_start);
    
    % Create updated variables of instantaneous spin config and total
    % energy
    spin_config = start_spin_config;
    
    %total_energy = start_eng;
    
    n = length(spin_start);
    
    G = G_start;
    P = trotter_slices
    T = Temperature
    step_value = (G_start - (0.00000001))/monte_steps;
    
%     energyFunction = buildEnergyFunction(h, Jzz, Jzzz)
%     
%     energyFunction(spin_config(1,:))
    
    
    for k = 1:monte_steps
        disp(k)
        % Reduce the transverse field
        G = G_start - step_value*(k-1)
        for i = 1:n;
            
            % Perform local flips and evals
            %total_energy;
            J_orth = -(P*T/2)*log(tanh(G/(P*T)));
            for slice = 1:trotter_slices;
                % Create variables to store new energy and configuration
                new_spin_config = spin_config;
                indices_to_flip = randperm(n, step_flips).';
                %flip local spin
                for flip = 1:length(indices_to_flip);
                    new_spin_config(slice,indices_to_flip(flip)) = -new_spin_config(slice,indices_to_flip(flip));
                end
                ediff = 0;
                for spin_index = 1:length(indices_to_flip);
                    ediff = ediff+ -2.0*h(indices_to_flip(spin_index))*new_spin_config(slice,indices_to_flip(spin_index));
                end
                for spin_index = 1:length(indices_to_flip);
                    for neib = 1:n;
                        if neib ~= indices_to_flip(spin_index)
                            ediff = ediff + -2.0*Jzz(indices_to_flip(spin_index), neib)*new_spin_config(slice,indices_to_flip(spin_index))*new_spin_config(slice,neib);
                        end
                    end
                end
                if slice == 1;
                    left = trotter_slices;
                    right = 2;
                elseif slice == trotter_slices;
                    left = trotter_slices - 1;
                    right = 1;
                else
                    left == slice - 1;
                    right = slice +1;
                end
                for spin_index = 1:length(indices_to_flip);
                    ediff = ediff + -2.0*J_orth*new_spin_config(slice, indices_to_flip(spin_index))*new_spin_config(left, indices_to_flip(spin_index));
                    ediff = ediff + -2.0*J_orth*new_spin_config(slice, indices_to_flip(spin_index))*new_spin_config(right, indices_to_flip(spin_index));
                end
                ediff;
                
                p_t = tran_prob(0,0,ediff, trotter_slices, Temperature, n, G);
                x_1 = rand;
                if x_1 <= p_t;
                    spin_config = new_spin_config;
%                     total_energy = Ham_d1(spin_config, HParams, trotter_slices, Temperature, G);
                end
                ediff = 0;
%            
                
            end
%             glob_flip_index = randperm(n,step_flips);
%             % Perform global spin flips and evals
%             glob_spin_config = spin_config;
%             for slice = 1:trotter_slices;
%                 for k = 1:length(glob_flip_index);
%                     glob_spin_config(slice,glob_flip_index(k)) = -glob_spin_config(slice,glob_flip_index(k));
%                 end
%             end
%             new_glob_energy = Ham_d1(glob_spin_config, HParams, trotter_slices, Temperature, G);
%             p_t_g = tran_prob(new_glob_energy, total_energy,0, trotter_slices, Temperature, n, G);
%             x_g = rand;
%             if x_g <= p_t_g;
%                 spin_config = glob_spin_config;
%             end
        end
    end

    % Get the conf with min energy
    energies = zeros([trotter_slices,1]);
    for i = 1:trotter_slices;
        energies(i) = Conf_energy(spin_config(i,:),HParams);
    end
    
    
    [energy, ind] = min(energies)
    spin_config
    energies
    conf = spin_config(ind,:)
end
        
            

    