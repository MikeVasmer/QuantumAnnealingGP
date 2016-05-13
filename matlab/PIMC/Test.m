spin = transpose(generate_spins(10, 10))
h = random_coef([10], 1, [-1,1], 0, 1)

length(h)

Jzz = random_coef( [10,10],  1, [-1,1], 0, 1)
Jxx = 0
Jzzz = 0
Jxxx = 0

HParams = {h, Jzz, Jxx, Jzzz, Jxxx}

Ham = ising_hamiltonian(h, Jzz, 0, 0, 0);

Conf_energy(spin, HParams, 1);

spin_confs = [spin;spin;spin]

%disp('energy is')

Ham_d1(spin_confs, HParams, 3, 1, 0.1)

nums = linspace(0.1,2.1,20)

% z = arrayfun(@(x) Ham_d1(spin_confs, HParams, 3, 1,x),nums)
% 
% plot(nums, z)
% 
% length(h)