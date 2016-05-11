function [ p ] = transition_probability( oldspin, newspin, H, T, Gamma)
%TRANSITION_PROBABILITY Calculates transition probability between two spins
%for some hamiltonian at a temperature T.

%boltzmann = 1.38e-23;
boltzmann = 1;


deltaH = evaluate_energy(newspin, H) - evaluate_energy(oldspin, H); 

if deltaH <= 0
    p = Gamma;
else
    p = Gamma * exp(-deltaH/(boltzmann*T));
end

end

