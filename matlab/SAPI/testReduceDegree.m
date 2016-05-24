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


Jzzz = ones(4, 4, 4);

[h, Jzz, pens] = threeToTwo(Jzzz, 4);

ham_1 = ising_hamiltonian(0, 0, 0, Jzzz, 0);

ham_2 = ising_hamiltonian(h, Jzz, 0, 0, 0);


h

Jzz

min(eigs(ham_1))

min(eigs(ham_2))




    