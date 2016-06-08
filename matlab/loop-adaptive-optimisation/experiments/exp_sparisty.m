%function [] = exp_sparsity()

    % Parameters
    locality = 2;
    adj_type = 'Chimera';
    % num_spins_array = {10,20,30,40,50,60,70,80,90,100}; % A2A
    % num_spins_array = {9,16,25,36,49,64,81,100}; % NN
    num_spins_array = {8,16,32,48,64,72,96}; % Chimera
    num_spins_dim   = {{1,1},{2,1},{2,2},{3,2},{4,2},{3,3},{4,3}}; % Chimera
    num_loops_array = { ...
                        num_spins_array, ...
                        cellfun(@(x) x*2,num_spins_array,'un',0), ...
                        cellfun(@(x) x*3,num_spins_array,'un',0), ...
                        cellfun(@(x) x*4,num_spins_array,'un',0), ...
                        cellfun(@(x) x*5,num_spins_array,'un',0) ...
                      };
    labels = {'x', '2x', '3x', '4x', '5x'};
    num_repeats = 300;
    
    % Intialse sparisty array
    sparsities = cell(1, length(num_loops_array));
    error_bars = cell(1, length(num_loops_array));
    
    % Start timer
    sparse_timer = tic;
    
    % Run parameter loops
    for relation = 1:length(num_loops_array)
        for i = 1:length(num_spins_array)
            avg_sparsity = zeros(1,num_repeats);
            for repeat = 1:num_repeats
                switch locality
                case 2
                    % Define adjacency matrix - allowed couplings
                    switch adj_type
                        case 'A2A'
                            adj = ones(num_spins_array{i}) - eye(num_spins_array{i});
                        case 'NN'
                            adj = NearestNeighbourAdj2D(sqrt(num_spins_array{i}), sqrt(num_spins_array{i}));
                        case 'Chimera'
                            adj = chimeraAdj(num_spins_dim{i}{1}, num_spins_dim{i}{2});
                        otherwise
                            error('Invalid architecture');
                    end

                    % Run LAO
                    avg_sparsity(repeat) = lao_just_loops_2(num_spins_array{i}, num_loops_array{relation}{i}, adj);
                case 3
                    % Define adjacency matrix - allowed couplings
                    switch adj_type
                        case 'A2A'
                            adj = all_to_all_3(num_spins_array{i});
                        case 'NN'
                            adj = nearestNeighbourAdj3local(sqrt(num_spins_array{i}), sqrt(num_spins_array{i}));
                        otherwise
                            error('Invalid architecture');
                    end

                    % Run LAO
                    avg_sparsity(repeat) = lao_just_loops_3(num_spins_array{i}, num_loops_array{relation}{i}, adj);
                end

                % Progress timer
                if toc(sparse_timer) > 2
                    disp(sprintf(strcat( ...
                        'Relation: \t',num2str(relation), ':', num2str(length(num_loops_array)), '\t\t', ...
                        'Index: \t',num2str(i), ':', num2str(length(num_spins_array)), '\t\t', ...
                        'Number of spins: \t',num2str(num_spins_array{i}), '\t\t', ...
                        'Number of loops: \t',num2str(num_loops_array{relation}{i}) ...
                    )));
                    sparse_timer = tic;
                end
            end 
            sparsities{relation} = [sparsities{relation}, mean(avg_sparsity)];
            error_bars{relation} = [error_bars{relation}, std(avg_sparsity)/sqrt(num_repeats)];
        end
    end

    % Plot sparsities
    figure(1)
    for p = 1:length(num_loops_array)
        errorbar(cell2mat(num_spins_array), sparsities{p}, error_bars{p}, 'x-');  
        hold on;
    end
    xlabel('Number of spins');    
    ylabel('Coupling density');
    legend(labels);
    
%end
