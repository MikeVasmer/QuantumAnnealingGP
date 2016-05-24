function [ out ] = indicies_to_coords( indicies, num_nodes )

    out = cell(1,length(indicies));
    
    for i = 1:length(indicies)
        
        out{i} = sort([ mod((indicies(i)-1),num_nodes), floor((indicies(i)-1)/num_nodes) ]);
        
        
    end
    
    
end

