function [ Mout ] = symmetrize3local( Jzzz )
%SYMMETRIZE3LOCAL Sets diagonals to zero and keeps upper right
%tetrahedron of nxnxn matrix

sizeJzzz = size(Jzzz);
Mout = zeros(sizeJzzz(1), sizeJzzz(2), sizeJzzz(3));

  %%Triangularize
for i = 1:sizeJzzz(1)
    idx = i-1;
    Mout(1:idx,1:idx,i) = triu(Jzzz(1:idx,1:idx,i), 1);
end

% % % Permutation symmetry
Mout = (permute(Mout, [1,2,3]) + permute(Mout, [1,3,2]) ...
    + permute(Mout, [2,1,3]) + permute(Mout, [2,3,1]) ...
    + permute(Mout, [3,1,2]) + permute(Mout, [3,2,1]));

end

