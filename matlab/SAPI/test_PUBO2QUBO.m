% terms = cell(1,4);
% terms{1} = [1 2 3];
% terms{2} = [1 2 4];
% terms{3} = [1 3 4];
% terms{4} = [2 3 4];
% [qTerms varRepl] = reduceDegree(terms);
% 
% for i = 1 : length(qTerms)
% fprintf('terms %d:', i);
% disp(qTerms{i});
% end
% disp(varRepl);

f = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 1; 1; 1; 1; 0];
[Q, qTerms, varRepl] = makeQuadratic(f);
disp(Q);
for i = 1 : length(qTerms)
fprintf('terms %d:', i);
disp(qTerms{i});
end
disp(varRepl);