function [ output ] = findGroundState( paramsFile, solverType, repNumber, groundStateEn, epsilon  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    load(paramsFile)
    
    disorder = round(n_qubits/2);
    
    spinConfig = generate_spins(n_qubits, disorder);
    
    repCount = 0;
    
    tStart = tic;
    
    switch solverType;
        case 'Metropolis'
            for repeats = 1:repNumber
                solution = Solver(spinConfig, Hparams, 'Metropolis');
                if solution{1} == groundStateEn*epsilon;
                    repCount = repeats;
                    toc(tStart);
                    break
                end
            end
        case 'HeatBath'
            for repeats = 1:repNumber
                solution = Solver(spinConfig, Hparams, 'HeatBath');
                if solution{1} == groundStateEn*epsilon;
                    repCount = repeats;
                    toc(tStart);
                    break
                end
            end
        case 'SimulatedAnnealing'
            for repeats = 1:repNumber
                solution = Solver(spinConfig, Hparams, 'SimulatedAnnealing');
                if solution{1} == groundStateEn*epsilon;
                    repCount = repeats;
                    toc(tStart);
                    break
                end
            end
        case 'ParallelTempering'
            for repeats = 1:repNumber
                solution = Solver(spinConfig, Hparams, 'ParallelTempering');
                if solution{1} == groundStateEn*epsilon;
                    repCount = repeats;
                    toc(tStart);
                    break
                end
            end
        case 'PIQMC'
            for repeats = 1:repNumber
                solution = Solver(spinConfig, Hparams, 'PIQMC');
                energy = solution{1};
                if solution{1} <= groundStateEn*epsilon;
                    repCount = repeats;
                    toc(tStart);
                    break
                end
                if solution{2} ~= spinConfig
                    spinConfig = solution{2};
                else
                    spinConfig = generate_spins(n_qubits, disorder);
                end
            end
        otherwise
            disp('Enter valid Monte Carlo Algorithm')
    end
    
    
    
    time = toc(tStart);
    output = {repCount, time}; 
    
    



end

