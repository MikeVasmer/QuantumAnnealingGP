function [ p ] = transition_probability( oldspin, newspin, H, Hparams, beta, Gamma, Monty)
%TRANSITION_PROBABILITY Calculates transition probability between two spins
%for some hamiltonian at a temperature T.

switch Monty
    case 'Metropolis'

        deltaH = evaluate_energy(newspin, H) - evaluate_energy(oldspin, H); 

        if deltaH <= 0
            p = Gamma;
        else
            p = Gamma * exp(-deltaH * beta);
        end
        
    case 'HeatBath'
        
        spin_index = oldspin;
        spins = newspin;
        spinval = spins(spin_index);
        
        local_field = calculate_local_field(spin_index, spins, Hparams);
        
        if sign(local_field) == spinval
            p = Gamma * exp( -2 * spinval * local_field * beta );
        else
            p = Gamma;
        end
        
        
    otherwise
        disp('enter valid Monte Carlo Algorithm')
end

