function [ out ] = hardness_measure( type, instance )

    switch type
        case 0 % Simulated annealing - TTS
            out = rand();
        case 1 % Path integral Monte Carlo - TTS
            out = rand();
        case 2 % Q-distribution - Gaussian integral?
            out = rand();
    end

end

