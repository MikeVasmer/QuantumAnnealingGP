function [ local_field ] = calculate_local_field( spin_index, spins, Hparams )
%CALCULATE_LOCAL_FIELD Calculates local field on a spin given the spin, its
%configuration and Hamiltonian parameters

%% Currently only 3-local Z fields

[h, Jzz, Jxx, Jzzz, Jxxx] = deal(Hparams{:});
spins = transpose(spins);
local_field = 0;

if h ~= 0
    local_field = local_field + h(spin_index);
end

if any(any(Jzz)) ~= 0
   ZZ = Jzz;
   addition = ZZ * spins;
   addition = addition(spin_index);
end

if any(any(any(Jzzz))) ~= 0
    ZZZ = reshape(Jzzz(spin_index, :, :), [length(spins), length(spins)]);
    ZZZ(spin_index, :) = 0; % Ignore self coupled terms, see eq (27) Katzgraber Monte Carlo
    ZZZ(:, spin_index) = 0;
    Sij = kron(spins', spins);
    addition = ZZZ.*Sij;
    addition = sum(sum(addition));
end


local_field = local_field - addition;




end

