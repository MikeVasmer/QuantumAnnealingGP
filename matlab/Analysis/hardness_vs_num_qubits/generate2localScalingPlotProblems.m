hardnessParams = {0,10,5,5};

num_spins_array = [10:5:100];
num_loops_array = 2*num_spins_array;

num_repeats = 9;

for j = 1:num_repeats
    for i = 1:length(num_spins_array)

        num_spins = num_spins_array(i);
        num_loops = num_loops_array(i);
        % All to all connectivity
        adj = ones(num_spins) - eye(num_spins);

        lao_2(num_spins, num_loops, 30, adj, hardnessParams,20);

    end
end