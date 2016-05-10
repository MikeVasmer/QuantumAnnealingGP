function [ out ] = minimum_gap( eigenvalues )

    % Calculate energies relative to ground state
    for i = 1:length(eigenvalues)
        eigenvalues(:,i) = eigenvalues(:,i) - min(eigenvalues(:,i));
    end 
    
    % Return minimum gap
    out = min(eigenvalues(2,:));

end

