function [ out ] = random_coef( dimensions, value_type, value_range, distribution, density )
% Dimensions: Array
% Value type: Discrete (0) / Continuous (1)
% Value range: [array] / [min, max]
% Distribution: Uniform (0) / Gaussian (1)
% Density: Int {0,1}

    switch value_type
        % Discrete values
        case 0
            % Generate empty matrix with required dimensions
            if length(dimensions) == 1
                sub_out = zeros(1,dimensions);
            else
                sub_out = zeros(dimensions);
            end   
            
            % Loops through each element
            for i = 1:numel(sub_out)
                % Set to random value from array
                sub_out(i) = value_range(randi(length(value_range)));
            end
        % Continuous values
        case 1
            value_min = value_range(1);
            value_max = value_range(2);
            
            switch distribution
                % Uniform distribution
                case 0
                     % Generate random matrix
                    if length(dimensions) == 1
                        sub_out = (rand(1,dimensions)*(value_max-value_min))+value_min;
                    else
                        sub_out = (rand(dimensions)*(value_max-value_min))+value_min;
                    end
                    % Normal/Gaussian distribution
                case 1
                    % Generate random matrix
                    if length(dimensions) == 1
                        sub_out = (randn(1,dimensions)*(value_max-value_min))+value_min;
                    else
                        sub_out = (randn(dimensions)*(value_max-value_min))+value_min;
                    end
            end
    end
            
    % Create a (1-density) of 0's
    for i = 1:numel(sub_out)
        if rand() > density
            sub_out(i) = 0;
        end
    end

    % Return final matrix
    out = sub_out;
    
end
