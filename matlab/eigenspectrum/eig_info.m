function [ out ] = eig_info( vec, val, indices )
    % Given eigenvectors and eigenvalues, print them along with spin
    % configuarations
    
    % Number of qubits
    num_qubits = log2(length(diag(val)));
    
    % Loop over all indicies
    for index = indices
        % Find non-zero probability classical states in eigenvector at a given
        % index
        eigvec_indices = find(vec(:,index));

        % Get configurations of non-zero states in eigenvector
        eigvec_configs = eigvec_indices_to_config( num_qubits, eigvec_indices );

        % Display eigenvalue
        disp(sprintf(strcat( ...
            'Eigenvalue:\t', num2str( val(index,index) ) ...
        )));

        % Display configurations and weights
        for i = 1:numel(eigvec_indices)
            disp(sprintf(strcat( ...
                'Config:\t', num2str( eigvec_configs(i,:) ), ...
                '\tWeigth:\t' , num2str( vec(eigvec_indices(i),index) ) ...
            )));
        end
    end
    
end

