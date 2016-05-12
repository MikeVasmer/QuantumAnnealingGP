function[ solution ] = simulatedAnnealing(hamiltonian,hParams, nSpins, initialTemp, tempStep, iterations)

energies = zeros(1,iterations);
configs = cell(1,iterations);

while iterations > 0;
    spinConfig = generate_spins(nSpins,1);
    temp = initialTemp;
    kB = 1.38064852e-23;
    energy = evaluate_energy(spinConfig, hamiltonian);

    while temp > 0
       newSpinConfig = flip_spin(spinConfig,1); 
       newEnergy = evaluate_energy(newSpinConfig, hamiltonian);
       beta = (kB*temp);
       prob = transition_probability( spinConfig, newSpinConfig, hamiltonian, hParams, beta, 1, 'Metropolis');
       if prob >= rand(1)
           spinConfig = newSpinConfig;
           energy = newEnergy;
       end
       temp = temp - tempStep;
    end
    energies(1,iterations) = energy;
    %disp(energies)
    configs{iterations} = spinConfig;
    %disp(configs)
    %disp(energy)
    disp(iterations)
    iterations = iterations - 1;
end

[energy, index] = min(energies);
solution = {energy, configs{index}};

end