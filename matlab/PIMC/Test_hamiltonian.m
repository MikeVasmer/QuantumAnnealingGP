
h_10 = random_coef([13], 1, [-1,1], 0, 1);
Jzz_10 = random_coef([13,13],  1, [-1,1], 0, 0.5);

Ham_10 = ising_hamiltonian(h_10, Jzz_10, [], [], []);

