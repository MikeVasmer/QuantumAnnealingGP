hardnessParams = {0,10,5,1};

num_spins_array = [5:5:100];
num_loops_array = 2*num_spins_array;

num_repeats = 10;

for j = 1:num_repeats
    for i = 1:length(num_spins_array)

        num_spins = num_spins_array(i);
        num_loops = num_loops_array(i);
        % All to all connectivity
        adj = all_to_all_3(num_spins);

        lao_no_optimisation_2(num_spins, num_loops, adj, hardnessParams);

    end
end