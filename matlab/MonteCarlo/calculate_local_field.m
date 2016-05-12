function [ local_field ] = calculate_local_field( spin_index, spins, Hparams )
%CALCULATE_LOCAL_FIELD Calculates local field on a spin given the spin, its
%configuration and Hamiltonian parameters

%% Currently only 3-local Z fields

[h, Jzz, Jxx, Jzzz, Jxxx] = deal(Hparams{:});

local_field = 0;

local_field = local_field + h(spin_index);

ZZZ = reshape(Jzzz(spin_index, :, :), [length(spins), length(spins)]);
ZZZ(spin_index, :) = 0; % Ignore self coupled terms, see eq (27) Katzgraber
ZZZ(:, spin_index) = 0;
Sij = kron(spins', spins);
addition = ZZZ.*Sij;
addition = sum(sum(addition));

local_field = local_field - addition;




end

