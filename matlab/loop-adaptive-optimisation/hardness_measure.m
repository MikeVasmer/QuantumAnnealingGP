function [ out ] = hardness_measure( type, J, gs_energy )

    switch type
        case 'SA' % Simulated annealing - TTS
            out = rand();
        case 'PIMC' % Path integral Monte Carlo - TTS
            out = rand();
        case 'Q' % Q-distribution - Gaussian integral?
            out = rand();
        otherwise
            disp('Invalid hardness type.')
            out = 0;
    end

end

