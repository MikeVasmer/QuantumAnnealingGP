function [] = n_qubit( H_p, rel_plot )
    
    % If relative plot not assigned, default to off
    switch nargin
    case 1
        rel_plot = 0;
    end
 
    size_H_p = size(H_p);
    n = log2(size_H_p(1));
    H_b = transverse_field(n);
    s = [0:0.02:1];
    H = kron((1-s),H_b) + kron(s,H_p);
    H = reshape(H, [2^n,2^n,length(s)]);

    eigenvalues = zeros(2^n,length(s));
    for i = 1:length(s)
        eigenvalues(:,i) = eig(H(:,:,i));
    end
    
    % Make copy and calculate energies relative to ground state
    eigenvalues_gs = eigenvalues;
    for i = 1:length(s)
        eigenvalues_gs(:,i) = eigenvalues_gs(:,i) - min(eigenvalues_gs(:,i));
    end 
    
    disp('Minimum gap:')
    disp(min(eigenvalues_gs(2,:)))

    if rel_plot == 0 || rel_plot == 2
        figure('Position', [10, 500, 600, 450]);
        plot(s, eigenvalues);
        title('Eigenspectrum')
        xlabel('evolution parameter, s');
        ylabel('energy');
    end
    if rel_plot == 1 || rel_plot == 2
        figure('Position', [650, 500, 600, 450]);
        plot(s, eigenvalues_gs);
        title('Eigenspectrum (relative to ground state)')
        xlabel('evolution parameter, s');
        ylabel('energy');
    end
    

end