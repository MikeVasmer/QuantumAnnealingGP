function[ solution ] = simulatedAnnealing(hamParams, spinConfig, initialTemp,...
    tempStep, stepSize)
%SIMULATED ANNEALING Runs the Simulated Annealing Algorithm on a
%Hamiltonian

temp = initialTemp;
kB = 1.38064852e-23;

energy = Conf_energy(spinConfig, hamParams);
%Perform metropolis steps whilst lowering the temperature linearly
while temp > 0
   newSpinConfig = flip_spin(spinConfig, stepSize); 
   newEnergy = Conf_energy(newSpinConfig, hamParams);
   beta = (kB * temp);
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

solution = {energy, spinConfig};

end