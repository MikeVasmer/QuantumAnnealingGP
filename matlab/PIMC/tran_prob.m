function [ probability ] = tran_prob(new_eng, old_eng, delta_H, P, T, n, G)
    
    if new_eng && old_eng ~= 0;
        delta_H = new_eng - old_eng;
    end
    
    %Ham_d1(new_spins, energyFunction, P, T, G)  - Ham_d1(old_spins, energyFunction, P, T, G);
    
    probability = 0;
    
    beta = 1/(P*T);
    C = sqrt(0.5*sinh((2*G/(P*T))));
    
    if delta_H <= 0;
        probability = 1;
    else
        probability = (C^(n*P))*exp(-delta_H*beta);
    end