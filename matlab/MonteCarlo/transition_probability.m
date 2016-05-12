function [ p ] = transition_probability( oldspin, newspin, H, Hparams, beta, Gamma, Monty)
%TRANSITION_PROBABILITY Calculates transition probability between two spins
%for some hamiltonian at a temperature T.

switch Monty
    case 'Metropolis'

        deltaH = evaluate_energy(newspin, H) - evaluate_energy(oldspin, H); 

        if deltaH <= 0
            p = Gamma;
        else
            p = Gamma * exp(-deltaH/beta);
        end
        
    case 'HeatBath'
        
        spins = oldspin;
        [h, Jzzz]
        
        
    otherwise
        disp('enter valid Monte Carlo Algorithm')
end

