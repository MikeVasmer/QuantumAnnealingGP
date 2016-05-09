function [] = eigenspectrum( H_b, H_p, steps, rel_plot )
    
    % Check dimensions of H_b and H_p are the same
    if size(H_b) ~= size(H_p)
        error('Require: dimensions of H_b and H_p must match');
    end

    % If relative plot not assigned, default to off
    switch nargin
    case 3
        rel_plot = 0;
    end
 
    % Get number of qubits n from Hamiltonians
    size_H_b = size(H_b);
    n = log2(size_H_b(1));
    
    % Evolution steps
    s = [0:1/(steps-1):1];
    % Time dependent Hamiltonian
    H = kron((1-s),H_b) + kron(s,H_p);
    % Reshape for convinience
    H = reshape(H, [2^n,2^n,length(s)]);

    % Init empty matrix
    eigenvalues = zeros(2^n,length(s));
    for i = 1:length(s)
        % Calculate eigenvalues at particular timesteps
        eigenvalues(:,i) = eig(H(:,:,i));
    end
    
    % Make copy and calculate energies relative to ground state
    eigenvalues_gs = eigenvalues;
    for i = 1:length(s)
        eigenvalues_gs(:,i) = eigenvalues_gs(:,i) - min(eigenvalues_gs(:,i));
    end 
    
    % Display minimum gap
    disp('Minimum gap:')
    disp(min(eigenvalues_gs(2,:)))

    % Plot figures
    if rel_plot == 0 || rel_plot == 2
        % Real energy
        figure('Position', [10, 500, 600, 450]);
        plot(s, eigenvalues);
        title('Eigenspectrum')
        xlabel('evolution parameter, s');
        ylabel('energy');
    end
    if rel_plot == 1 || rel_plot == 2
        % Energy relative to gound state
        figure('Position', [650, 500, 600, 450]);
        plot(s, eigenvalues_gs);
        title('Eigenspectrum (relative to ground state)')
        xlabel('evolution parameter, s');
        ylabel('energy');
    end

end