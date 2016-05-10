function [ out ] = minimum_gap( eigenvalues, perc_range )

    % If perc_range not set, default to full range
    switch nargin
    case 1
        perc_range = 1;
    end

    % Calculate energies relative to ground state
    for i = 1:length(eigenvalues(1,:))
        eigenvalues(:,i) = eigenvalues(:,i) - min(eigenvalues(:,i));
    end 
    
    % Get stop index given range (i.e. 0 to perc_range)
    mat_size = size(eigenvalues);
    stop_ind = floor(perc_range*mat_size(2));
    
    % Return minimum gap
    out = min(eigenvalues(2,1:stop_ind));
     
end

