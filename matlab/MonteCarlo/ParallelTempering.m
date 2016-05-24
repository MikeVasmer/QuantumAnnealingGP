function [ solution ] = ParallelTempering( spin_config, Hparams, betas, totalRuns, backendMonty, sweepsMonty, Gamma, num_flips )
%PARALLELTEMPERING Implements Parallel Tempering optimisation algorithm on 
% a collection of spins 

% Initialise
num_betas = length(betas);
spins_cell = cell(num_betas, 1);
[spins_cell{:}] = deal(spin_config);
[h, Jzz, ~, Jzzz, ~] = deal(Hparams{:});

for timestep = 1:totalRuns
    
% Monte Carlo sweeps
    for i = 1:num_betas

        beta = betas(i);
        spins = spins_cell{i};

        switch backendMonty

        case 'Metropolis'
            spins = Metropolis(spins, Hparams, beta, sweepsMonty, num_flips, Gamma);
        case 'HeatBath'
            spins = HeatBath(spins, Hparams, beta, sweepsMonty, Gamma);
        otherwise
            disp('Enter valid Monte Carlo Algorithm')

        end

        spins_cell{i} = spins;

    end

    % Swaps
    for i = 1:(num_betas - 1)
        newspins = spins_cell{i+1};
        indices_to_flip = find(newspins.*spins_cell{i} == -1);
        delta = (betas(i) - betas(i+1)) * -energyChange(newspins, indices_to_flip, 1, 1, 1, h, Jzz, Jzzz);
        
        %delta = (betas(i) - betas(i+1)) * ...
        %    (Conf_energy(spins_cell{i}, Hparams) - Conf_energy(spins_cell{i+1}, Hparams));

        if rand < exp(delta)
            [spins_cell{i}, spins_cell{i+1}] = deal(spins_cell{i+1}, spins_cell{i});       
        end

    end
    
end

% Take best configuration

energies = zeros(num_betas, 1);

for i = 1:num_betas
    energies(i) = Conf_energy(spins_cell{i}, Hparams);
end

[gs_energy, gs_index] = min(energies(i));

solution = {gs_energy, spins_cell{gs_index}};

end

