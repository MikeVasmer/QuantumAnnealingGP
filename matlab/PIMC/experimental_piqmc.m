function [ solution ] = exp_piqmc(spin_start, HParams, monte_steps, trotter_slices, G_start, Temperature, step_flips)
    
    [h, Jzz, Jxx, Jzzz, Jxxx] = deal(HParams{:});
    
    start_spin_config = repmat(spin_start, trotter_slices, 1);
    
    % Calculate the initial energy
    %start_eng = Ham_d1(start_spin_config, HParams, trotter_slices, Temperature, G_start);
    
    % Create updated variables of instantaneous spin config and total
    % energy
    spin_config = start_spin_config;
    
    %total_energy = start_eng;
    
    n = length(spin_start);
    
    G = G_start;
    P = trotter_slices;
    T = Temperature;
    step_value = (G_start - (0.00000001))/monte_steps;
    
%     energyFunction = buildEnergyFunction(h, Jzz, Jzzz)
%     
%     energyFunction(spin_config(1,:))
    
    tic;
    for k = 1:monte_steps
        %disp(k);
        %sprintf('k=%d',k)
        if toc > 1
           disp(strcat(num2str(k),':', num2str(monte_steps)));
           disp(G);
           disp(J_orth);
           tic;
        end
        % Reduce the transverse field
        G = G_start - step_value*(k-1);
        for i = 1:1;
            %sprintf('i=%d',i)
            % Perform local flips and evals
            %total_energy;
            J_orth = -(P*T/2)*log(tanh(G/(P*T)));
            for slice = 1:trotter_slices;
                %sprintf('slice=%d',slice)
                % Create variables to store new energy and configuration
%                 new_spin_config = spin_config;
                indices_to_flip = randperm(n, step_flips).';
                random_spin_order = randperm(n);
                %flip local spin
%                 for flip = 1:length(indices_to_flip);
%                     new_spin_config(slice,indices_to_flip(flip)) = -new_spin_config(slice,indices_to_flip(flip));
%                 end
                for spinIndex = 1:n
                    new_spin_config = spin_config;
                    new_spin_config(slice, random_spin_order(spinIndex)) = -new_spin_config(slice, random_spin_order(spinIndex));
                    ediff = energyChange(new_spin_config, random_spin_order(spinIndex), trotter_slices, J_orth, slice, h, Jzz, Jzzz);
                    p_t = tran_prob(0,0,ediff, trotter_slices, Temperature, n, G);
                    x_1 = rand;
                    if x_1 <= p_t;
                        spin_config = new_spin_config;
                    end
                end
% %               Calculate Energy Change
%                 ediff = energyChange(new_spin_config, indices_to_flip, trotter_slices, J_orth, slice, h, Jzz, Jzzz);
%                 p_t = tran_prob(0,0,ediff, trotter_slices, Temperature, n, G);
%                 x_1 = rand;
%                 if x_1 <= p_t;
%                     spin_config = new_spin_config;
% %                     total_energy = Ham_d1(spin_config, HParams, trotter_slices, Temperature, G);
%                 end
                
                
%            
            
            end
            
%             glob_flip_index = randperm(n,step_flips);
%             % Perform global spin flips and evals
%             glob_spin_config = spin_config;
%             glob_energy_dif = 0;
%             for slice = 1:trotter_slices;
%                 for k = 1:length(glob_flip_index);
%                     glob_spin_config(slice,glob_flip_index(k)) = -glob_spin_config(slice,glob_flip_index(k));
%                     glob_energy_dif = glob_energy_dif + energyChange(glob_spin_config, glob_flip_index, trotter_slices, J_orth, slice, h, Jzz, Jzzz);
%                 end
%             end
% %             new_glob_energy = Ham_d1(glob_spin_config, HParams, trotter_slices, Temperature, G);
%             p_t_g = tran_prob(0, 0, glob_energy_dif, trotter_slices, Temperature, n, G);
%             x_g = rand;
%             if x_g <= p_t_g;
%                 spin_config = glob_spin_config;
%             end
        end
%         Ham_d1(spin_config,HParams, P,T,G)
    end

    % Get the conf with min energy
    energies = zeros([trotter_slices,1]);
    for i = 1:trotter_slices;
        energies(i) = Conf_energy(spin_config(i,:),HParams);
    end
    
    
    [energy, ind] = min(energies);
    %spin_config;
    %energies
    conf = spin_config(ind,:);
    solution = {energy, conf};
end