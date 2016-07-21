function [ ] = track_single_DW( H_b, H_p, steps, excited_level, eigvec_indices )
    % Given eigenvectors and eigenvalues, set of configurations, eigen
    % level, plot weigths of the configurations across anneal param, s
    
    % Number of qubits
    % Get number of qubits n from Hamiltonians
    size_H_b = size(H_b);
    num_qubits = log2(size_H_b(1));

    % Get configurations of non-zero states in eigenvector
    eigvec_configs = eigvec_indices_to_config( num_qubits, eigvec_indices );
    
    % Display Tracking info
    disp(sprintf(strcat( ...
        'Tracking excited state\t', num2str( excited_level ), ':' ...
    )));
    % Display configurations and weights
    for i = 1:numel(eigvec_indices)
        disp(sprintf(strcat( ...
            '\tConfig:\t', num2str( eigvec_configs(i,:) ) ...
        )));
    end
    
    % Get eigvecs and eigvals along the anneal path
    [vecs,vals] = eigenspectrum( H_b, H_p, steps );
    
    % Plot eigvec_indices at excited_level across anneal
    figure(1)
    plot( ...
        [0:1/(steps-1):1], ...
        abs(squeeze(vecs(eigvec_indices,excited_level,:))) ...
    )
    xlabel('anneal parameter, s')
    ylabel('probability')
    figure(2)
    surface( ...
        [0:1/(steps-1):1], ...
        repmat([1:num_qubits-1],steps,1)', ...
        abs(squeeze(vecs(eigvec_indices,excited_level,:))) ...
    )
    xlabel('anneal parameter, s')
    ylabel('domain wall position')
    zlabel('probability')
    az = -75;
    el = 20;
    view(az, el);

end

