function[ solution ] = simulatedAnnealing(hamiltonian, hamiltonianParams, initialTemp,...
    tempStep, iterations, fast, nSpins)
%SIMULATED ANNEALING Runs the Simulated Annealing Algorithm on a
%Hamiltonian

%Initialise the energy and configuration arrays
energies = zeros(1,iterations);
configs = cell(1,iterations);

%Compute the energy function
energyFunction = buildEnergyFunction(hamiltonianParams{1},hamiltonianParams{2},hamiltonianParams{4});

%Run the algorithm for a user-specified number of iterations
while iterations > 0;
    spinConfig = generate_spins(nSpins,1);
    temp = initialTemp;
    kB = 1.38064852e-23;
    if ~fast
        energy = evaluate_energy(spinConfig, hamiltonian);
    else
        energy = energyFunction(spinConfig);
    end
    %Perform metropolis steps whilst lowering the temperature linearly
    while temp > 0
       newSpinConfig = flip_spin(spinConfig,1); 
       if ~fast
           newEnergy = evaluate_energy(newSpinConfig, hamiltonian);
       else
           newEnergy = energyFunction(newSpinConfig);
       end
       beta = (kB*temp);
       deltaH = newEnergy - energy;
       if deltaH <= 0
           prob = 1;
       else
           prob = 1 * exp(-deltaH * beta);
       end
       
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
    %disp(iterations)
    iterations = iterations - 1;
end

%Find the best solution
[energy, index] = min(energies);
solution = {energy, configs{index}};

end