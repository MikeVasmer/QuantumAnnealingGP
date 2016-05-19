function [J,E] = test_local_hamiltonian()

    % Generate random solution, of size N
    num_spins = 5;
    solution = (round(rand(1,num_spins))*2)-1;
    
    % Single 5 node ring 
    adj = [
      [0,1,0,0,1]; ... 
      [0,0,1,0,0]; ... 
      [0,0,0,1,0]; ... 
      [0,0,0,0,1]; ... 
      [0,0,0,0,0] ... 
    ];

    % Generate random loop
    loop = random_walk_loop(adj);
    
    % Find local hamiltonian couplings and energy
    [J,E] = local_hamiltonian(solution, loop);

end

