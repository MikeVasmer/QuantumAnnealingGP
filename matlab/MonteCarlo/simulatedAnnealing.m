function[ solution ] = simulatedAnnealing(hamParams, spinConfig, initialTemp,...
    spinStepSize, iterations, scheduleType)
%SIMULATED ANNEALING Runs the Simulated Annealing Algorithm given some 
%Hamiltonian parameters, an initial spin configuration, an initial
%temperature, a temperature step size and a step size (this changes how
%many spins are flipped when generating the new spin configurations)

temp = initialTemp;
kB = 1.38064852e-23;
energy = Conf_energy(spinConfig, hamParams);
tempStep = initialTemp/iterations;

%Perform metropolis steps whilst lowering the temperature linearly
%according to the tempStep parameter
for step=1:iterations
    newSpinConfig = flip_spin(spinConfig, spinStepSize); 
    newEnergy = Conf_energy(newSpinConfig, hamParams);
    beta = 1/(kB * temp);
    deltaH = newEnergy - energy;
    %deltaH = energyChange(newSpinConfig);
    if deltaH <= 0
        prob = 1;
    else
        prob = 1 * exp(-deltaH * beta);
    end
    if prob >= rand(1)
        spinConfig = newSpinConfig;
        energy = newEnergy;
    end
    %disp(temp);
    %temp = temp - tempStep;
    temp = anneal_schedule(scheduleType, temp, step, tempStep);
end

solution = {energy, spinConfig};

end