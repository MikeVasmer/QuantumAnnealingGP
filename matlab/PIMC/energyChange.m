function [ deltaH ] = energyChange(new_spin_config, indices_to_flip, trotter_slices, J_orth, slice, h, Jzz, Jzzz)

    ediff = 0;
    n = length(new_spin_config(1,:));
    
    if h ~= 0        
        for spin_index = 1:length(indices_to_flip);
            ediff = ediff+ 2.0*h(indices_to_flip(spin_index))*new_spin_config(slice,indices_to_flip(spin_index));
        end
    end

    if Jzzz == 0 | isempty(Jzzz)
        for spin_index = 1:length(indices_to_flip);
            for neib_1 = 1:n;
                if neib_1 ~= indices_to_flip(spin_index)
%                     J_val = Jzz(indices_to_flip(spin_index), neib_1);
%                     spin_1 = new_spin_config(slice,indices_to_flip(spin_index));
%                     spin_2 = new_spin_config(slice,neib_1);
                    ediff = ediff + 2.0*Jzz(indices_to_flip(spin_index), neib_1)*new_spin_config(slice,indices_to_flip(spin_index))*new_spin_config(slice,neib_1);
                end
            end
        end
        
    elseif Jzz == 0 | isempty(Jzz)
        for spin_index = 1:length(indices_to_flip);
            for neib_1 = 1:n;
                if neib_1 ~= indices_to_flip(spin_index)
                for neib_2 = (neib_1+1):n;
                        ediff = ediff + 2.0*Jzzz(indices_to_flip(spin_index), neib_1, neib_2)*new_spin_config(slice,indices_to_flip(spin_index))*new_spin_config(slice,neib_1)*new_spin_config(slice,neib_2);
                end
                end
            end
        end
    end
    
    if trotter_slices ~= 1
        if slice == 1;
            left = trotter_slices;
            right = 2;
        elseif slice == trotter_slices;
            left = trotter_slices - 1;
            right = 1;
        else
            left = slice - 1;
            right = slice +1;
        end
        for spin_index = 1:length(indices_to_flip);
            ediff = ediff + -2.0*J_orth*new_spin_config(slice, indices_to_flip(spin_index))*new_spin_config(left, indices_to_flip(spin_index));
            ediff = ediff + -2.0*J_orth*new_spin_config(slice, indices_to_flip(spin_index))*new_spin_config(right, indices_to_flip(spin_index));
        end
    end
    
    deltaH = ediff;
end
    
        
        