function [ out ] = just_couplings( in )

    mask = zeros( size(in) );
    dim = length(in);

    for i = 1:numel(in)
        i_div = floor( (i-1) / dim );
        i_mod = mod( (i-1), dim );
        
        if (i_div-i_mod) > 0
            mask(i) = 1;
        end

    end
    out = in .* mask;

end

