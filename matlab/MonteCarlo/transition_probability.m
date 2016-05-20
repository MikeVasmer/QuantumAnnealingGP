function [ p ] = transition_probability( oldspin, newspin, Hparams, beta, Gamma, Monty)
%TRANSITION_PROBABILITY Calculates transition probability between two spins
%for some hamiltonian at a temperature T.

switch Monty
    case 'Metropolis'
        [h, Jzz, ~, Jzzz, ~] = deal(Hparams{:});
        indeces_to_flip = oldspin;
        deltaH = energyChange(newspin, indeces_to_flip, 1, 1, 1, h, Jzz, Jzzz);
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

