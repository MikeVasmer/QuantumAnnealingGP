function [ output ] = penaltyTerm( s1, s2, sz, n )
%Returns penalty term for reduction of Jzzz to Jzz

penMat = zeros(n);

penMat(s1,s2) = 1;
penMat(s1,sz) = -2;
penMat(s2,sz) = -2;
penMat(s1,s1) = -1;
penMat(s2,s2) = -1;
penMat(sz,sz) = 2;

output = penMat;

end

