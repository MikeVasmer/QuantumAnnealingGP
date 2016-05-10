function [] = plot_eigenspectrum( eigenvalues, plot_type )

    % If plot type not assigned, default to normal eigenspectrum
    switch nargin
    case 1
        plot_type = 0;
    end

    % Make copy and calculate energies relative to ground state
    eigenvalues_gs = eigenvalues;
    for i = 1:length(eigenvalues)
        eigenvalues_gs(:,i) = eigenvalues_gs(:,i) - min(eigenvalues_gs(:,i));
    end 
    
    % Evolution paramter
    s = [0:1/(length(eigenvalues)-1):1];

    % Plot figures
    if plot_type == 0 || plot_type == 2
        % Real energy
        figure('Position', [10, 500, 600, 450]);
        plot(s, eigenvalues);
        title('Eigenspectrum')
        xlabel('evolution parameter, s');
        ylabel('energy');
    end
    if plot_type == 1 || plot_type == 2
        % Energy relative to gound state
        figure('Position', [650, 500, 600, 450]);
        plot(s, eigenvalues_gs);
        title('Eigenspectrum (relative to ground state)')
        xlabel('evolution parameter, s');
        ylabel('energy');
    end

end

