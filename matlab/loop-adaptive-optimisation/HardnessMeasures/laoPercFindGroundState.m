function [ output ] = laoPercFindGroundState( Hparams, n_qubits, solverType, repNumber, groundStateEn, epsilon, seed  )
%UNTITLED Function to loop over a designated solver looking for the ground
%state of a Hamiltonian
%   


    
%     dims = size(Hparams{2});
    
%     if length(dims(1)) > 2
%         Hparams = fliplr(Hparams)
%     end
    
        
    
    
 
    
    disorder = round(n_qubits/2);
    
    startSpinConfig = generate_spins(n_qubits, disorder);
    
    spinConfig = startSpinConfig;
    
    totCorrect = 0;
    
   
    
   
    
    switch solverType;
        case 'Metropolis'
            for repeats = 1:repNumber
                solution = Solver(spinConfig, Hparams, 'Metropolis');
                energy = solution{1}
                if abs(solution{1}) >= abs(groundStateEn*epsilon);
                    totCorrect = totCorrect + 1;
                    spinConfig = generate_spins(n_qubits, disorder);
                elseif seed == 1 && ~isequal(solution{2}, spinConfig)
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
                    totCorrect = totCorrect + 1;
                    spinConfig = generate_spins(n_qubits, disorder);
                elseif seed == 1 && ~isequal(solution{2}, spinConfig)
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
                    totCorrect = totCorrect + 1;
                    spinConfig = generate_spins(n_qubits, disorder);
                elseif seed == 1 && ~isequal(solution{2}, spinConfig)
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
                    totCorrect = totCorrect + 1;
                    spinConfig = generate_spins(n_qubits, disorder);
                elseif seed == 1 && ~isequal(solution{2}, spinConfig)
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
                    totCorrect = totCorrect + 1;
                    spinConfig = generate_spins(n_qubits, disorder);
                elseif seed == 1 && ~isequal(solution{2}, spinConfig)
                    spinConfig = solution{2};
                else
                    spinConfig = generate_spins(n_qubits, disorder);
                end
            end
        otherwise
            disp('Enter valid Monte Carlo Algorithm')
    end
    
    
    
    perCorrect = totCorrect/repNumber;
    
    output = perCorrect; 
    
    
    



end

