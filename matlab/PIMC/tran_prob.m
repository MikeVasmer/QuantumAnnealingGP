function [ probability ] = tran_prob(new_spins, old_spins, HParams, P, T, G)
    
    delta_H = Ham_d1(new_spins, HParams, P, T, G) - Ham_d1(old_spins, HParams, P, T, G)
    
    probability = 0
    
    beta = 1/(P*T)
    
    if delta_H <= 0
        probability = 1
    else
        probability = exp(-delta_H*beta)
    end
    
    
    