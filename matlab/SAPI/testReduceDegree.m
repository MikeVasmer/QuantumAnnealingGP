% terms = cell(1, 3);
% 
% terms{1} = [1, 2, 3];
% terms{2} = [2, 3, 4];
% terms{3} = [3, 4, 5];
% [newTerms, varsRep] = reduceDegree(terms);
% 
% for i = 1 : length(newTerms)
%     fprintf('terms %d:', i);
%     disp(newTerms{i});
% end
% varsRep
% 
% penaltiesUsed = 0
% 
% n = max(max(varsRep));
% Jzz = zeros(n);
% ancillas = varsRep(1,:);
% for i = 1:length(newTerms)
%     % Get the new interaction term
%     interaction = newTerms{i}
%     % Add symmetric terms representing new interaction to Jzz
%     Jzz(interaction(1),interaction(2)) = 1;
%     Jzz(interaction(2),interaction(1)) = 1;
%     % Find ancilla interaction for penalties
%     index_1 = find(ancillas==interaction(1))
%     index_2 = find(ancillas==interaction(2))
%     % Calculate penalties
%     if ~isempty(index_1)
%         Jzz = Jzz +penaltyTerm(varsRep(2,index_1),varsRep(3,index_1),varsRep(1, index_1), n)
%         penaltiesUsed = penaltiesUsed + 1
%     end
%     if ~isempty(index_2)
%         Jzz = Jzz +penaltyTerm(varsRep(2,index_2),varsRep(3,index_2),varsRep(1, index_2), n)
%         penaltiesUsed = penaltiesUsed + 1 
%     end
% end


Jzzz = -ones(6, 6, 6);

for i = 1:6;
    for j = 1:6;
        for k = 1:6;
            p = rand;
            if p < 0.5;
                Jzzz(i,j,k) = Jzzz(i,j,k)*-1;
            end
            if i == j || i == k || j == k
                Jzzz(i,j,k) = 0;
            end
        end
    end
end


% Hparams = generate_random_3local_hamiltonian(5, 0.5, [0,0], [1,1]);
% [h, Jzz, Jxx, Jzzz, Jxxx] = deal(Hparams{:});

[hs, Jzz, pens, diff] = threeToTwo(Jzzz, 6);

ham_1 = ising_hamiltonian(0, 0, 0, Jzzz, 0);
% 
ham_2 = ising_hamiltonian(hs, Jzz, 0, 0, 0);

diff

hs;

Jzz;

min(eig(ham_1))
% 
min(eig(ham_2))

spinConfig_1 = generate_spins(6, 3);

spinConfig_2 = generate_spins(6+diff, 3);

Hparams_1 = {0,0,0,Jzzz,0};

Hparams_2 = {hs,Jzz,0,0,0};

solution1 = Solver(spinConfig_1, Hparams_1, 'SimulatedAnnealing')

solution2 = Solver(spinConfig_2, Hparams_2, 'SimulatedAnnealing')


disp('Exact diag result')
min(eig(ham_1))
% 
min(eig(ham_2))+3*diff

disp('Native three local')

solution1{1}

solution1{2};

disp('Two local conversion')

solution2{1}+diff*3

solution2{2};




    