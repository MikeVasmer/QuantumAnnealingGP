function[ solution ] = simulatedAnnealing(hamiltonian, hamiltonianParams, initialTemp, tempStep, iterations)
%SIMULATED ANNEALING Runs the Simulated Annealing Algorithm on a
%Hamiltonian

%Compute number of spins and initialise the energy and configuration arrays
n = size(hamiltonian,1);
nSpins = log2(n);
energies = zeros(1,iterations);
configs = cell(1,iterations);

%Run the algorithm for a user-specified number of iterations
while iterations > 0;
    spinConfig = generate_spins(nSpins,1);
    temp = initialTemp;
    kB = 1.38064852e-23;
    energy = evaluate_energy(spinConfig, hamiltonian);
    %Perform metropolis steps whilst lowering the temperature linearly
    while temp > 0
       newSpinConfig = flip_spin(spinConfig,1); 
       newEnergy = evaluate_energy(newSpinConfig, hamiltonian);
       beta = (kB*temp);
       prob = transition_probability( spinConfig, newSpinConfig, hamiltonian, hamiltonianParams, beta, 1, 'Metropolis');
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
    disp(energy)
    disp(iterations)
    iterations = iterations - 1;
end

%Find the best solution
[energy, index] = min(energies);
solution = {energy, configs{index}};

end