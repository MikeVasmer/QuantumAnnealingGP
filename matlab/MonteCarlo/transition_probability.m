function [ p ] = transition_probability( oldspin, newspin, H, beta, Gamma)
%TRANSITION_PROBABILITY Calculates transition probability between two spins
%for some hamiltonian at a temperature T.



deltaH = evaluate_energy(newspin, H) - evaluate_energy(oldspin, H); 

if deltaH <= 0
    p = Gamma;
else
    p = Gamma * exp(-deltaH/beta);
end

end

