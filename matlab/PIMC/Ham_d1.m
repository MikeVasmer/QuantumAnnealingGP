function [ out ] = Ham_d1(Multi_spins, HParams, P, T, G)
    
    n = length(Multi_spins(1,:));
    
    % This term dictates the coupling energy between slices
    J_orth = -(P*T/2)*log(tanh(G/(P*T)));
    
    
    Int_sli_tot = 0;
    % Need to calculate energy contribution for intra-slice coupling :(
    for i = 1:P;
        Slice_en = Conf_energy(Multi_spins(i,:), HParams);
%         Slice_en = energyFunction(Multi_spins(i,:));
        if i ~= P;
%             disp('slice number');
%             disp(i);
            for j = 1:n;
                spin_term = Multi_spins(i,j)*Multi_spins(i+1,j);
                Slice_en = Slice_en + (J_orth)*Multi_spins(i,j)*Multi_spins(i+1,j);
            end
        else
%             disp('Final Slice');
            for j = 1:n;
                spin_term = Multi_spins(i,j)*Multi_spins(1,j);
                Slice_en = Slice_en + (J_orth)*Multi_spins(i,j)*Multi_spins(1,j);
            end
        end
        Int_sli_tot = Int_sli_tot + Slice_en;
    end
    
    out = Int_sli_tot;
    