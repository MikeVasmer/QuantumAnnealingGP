function [ output ] = findGroundState( paramsFile, solverType, repNumber, groundStateEn, epsilon, seed  )
%UNTITLED Function to loop over a designated solver looking for the ground
%state of a Hamiltonian
%   paramsFile should be a matlab file containing an Hparams cell variable
%   as well as an n_qubits variable. Solver type is one of usual
%   algorithms. repNumber is number of repititions before loop exits.
%   groundStateEn is the energy of the ideal ground state. epsilon is the
%   percentage of GS that energy needs to reach before loop ends. seed
%   determines whether each loop uses best solution from previous loop (in
%   case that they are not equal) set equal to 1 for seeding, 0 for random
%   confs each time.

    load(paramsFile)
    
    disorder = round(n_qubits/2);
    
    spinConfig = generate_spins(n_qubits, disorder);
    
    repCount = 0;
    
    tStart = tic;
    
    solution = 0;
    
    switch solverType;
        case 'Metropolis'
            for repeats = 1:repNumber
                solution = Solver(spinConfig, Hparams, 'Metropolis');
                energy = solution{1}
                if abs(solution{1}) >= abs(groundStateEn*epsilon);
                    repCount = repeats;
                    toc(tStart);
                    break
                end
                if seed == 1 && ~isequal(solution{2}, spinConfig)
                    spinConfig = solution{2};
                else
                    spinConfig = generate_spins(n_qubits, disorder);
                end
            end
        case 'HeatBath'
            for repeats = 1:repNumber
                solution = Solver(spinConfig, Hparams, 'HeatBath');
                energy = solution{1}
                if abs(solution{1}) >= abs(groundStateEn*epsilon);
                    repCount = repeats;
                    toc(tStart);
                    break
                end
                if seed == 1 && ~isequal(solution{2}, spinConfig)
                    spinConfig = solution{2};
                else
                    spinConfig = generate_spins(n_qubits, disorder);
                end
            end
        case 'SimulatedAnnealing'
            for repeats = 1:repNumber
                solution = Solver(spinConfig, Hparams, 'SimulatedAnnealing');
                energy = solution{1}
                if abs(solution{1}) >= abs(groundStateEn*epsilon);
                    repCount = repeats;
                    toc(tStart);
                    break
                end
                if seed == 1 && ~isequal(solution{2}, spinConfig)
                    spinConfig = solution{2};
                else
                    spinConfig = generate_spins(n_qubits, disorder);
                end
            end
        case 'ParallelTempering'
            for repeats = 1:repNumber
                solution = Solver(spinConfig, Hparams, 'ParallelTempering');
                energy = solution{1}
                if abs(solution{1}) >= abs(groundStateEn*epsilon);
                    repCount = repeats;
                    toc(tStart);
                    break
                end
                if seed == 1 && ~isequal(solution{2}, spinConfig)
                    spinConfig = solution{2};
                else
                    spinConfig = generate_spins(n_qubits, disorder);
                end
            end
        case 'PIQMC'
            for repeats = 1:repNumber
                solution = Solver(spinConfig, Hparams, 'PIQMC');
                energy = solution{1}
                if abs(solution{1}) >= abs(groundStateEn*epsilon);
                    repCount = repeats;
                    toc(tStart);
                    break
                end
                if seed == 1 && ~isequal(solution{2}, spinConfig)
                    spinConfig = solution{2};
                else
                    spinConfig = generate_spins(n_qubits, disorder);
                end
            end
        otherwise
            disp('Enter valid Monte Carlo Algorithm')
    end
    
    
    
    time = toc(tStart);
    if repCount == 0
        disp('Ground State Not Found')
    end
    
    output = {repCount, time, solution{1}, solution{2}}; 
    
    
    



end

