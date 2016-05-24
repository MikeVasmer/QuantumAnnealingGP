function [ h_new, Jzz_new, penaltiesUsed, diff ] = threeToTwo( Jzzz, nQubits )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


terms = cell(1, 0);

for i = 1:nQubits
    for j = i+1:nQubits
        for k = j+1:nQubits
            if Jzzz(i,j,k) ~= 0;
                terms{end+1} = [i, j, k];
            end
        end
    end
end

[newTerms, varsRep] = reduceDegree(terms);
                

% for i = 1 : length(newTerms)
%     fprintf('terms %d:', i);
%     disp(newTerms{i});
% end
varsRep;

penaltiesUsed = 0;

n = max(max(varsRep));
Jzz = zeros(n);
ancillas = varsRep(1,:);
for i = 1:length(newTerms)
    % Get the new interaction term
    interaction = newTerms{i};
    % Add symmetric terms representing new interaction to Jzz
    Jzz(interaction(1),interaction(2)) = 1*Jzzz(terms{i}(1),terms{i}(2),terms{i}(3));
    Jzz(interaction(2),interaction(1)) = 1*Jzzz(terms{i}(1),terms{i}(2),terms{i}(3));
    
end


% Find ancilla interaction for penalties
penterms = zeros(n);
for ancilla = 1:length(varsRep(1,:))
    % Calculate penalties
        penterms = penterms + penaltyTerm(varsRep(2,ancilla),varsRep(3,ancilla),varsRep(1, ancilla), n);
        penaltiesUsed = penaltiesUsed + 1;
end
    

Jzz = Jzz + penterms;

h_new = zeros(1,n);

for i = 1:n
    h_new(i) = Jzz(i,i);
    Jzz(i,i) = 0;
end

h_new;
Jzz_new = Jzz;
diff = n - nQubits;

end

