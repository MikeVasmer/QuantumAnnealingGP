function [vec, val] = eigenspectrum( H_b, H_p, steps )
    
    % Check dimensions of H_b and H_p are the same
    if size(H_b) ~= size(H_p)
        error('Require: dimensions of H_b and H_p must match');
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
    eigenvectors = zeros(2^n,2^n,length(s));
    eigenvalues  = zeros(2^n,length(s));
    for i = 1:length(s)
        % Calculate eigenvalues at particular timesteps
        [vec,val] = eig(H(:,:,i));
        eigenvalues(:,i) = diag(val);
        eigenvectors(:,:,i) = vec;
    end
    
    % Return eigenvalues
    vec = eigenvectors;
    val = eigenvalues;

end
