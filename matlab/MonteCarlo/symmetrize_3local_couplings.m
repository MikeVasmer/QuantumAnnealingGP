function [ Mout ] = symmetrize_3local_couplings( Jzzz )
%SYMMETRIZE_3LOCAL_COUPLINGS Sets diagonals to zero and keeps upper right
%tetrahedron of nxnxn matrix

sizeJzzz = size(Jzzz);
Mout = Jzzz;

% Pairwise terms to zero
for i = 1:sizeJzzz(1)
    for j = 1:sizeJzzz(2)
        for k = 1:sizeJzzz(3)
            if i == j || j == k || i == k
                Mout(i,j,k) = 0;
            end
            
        end
    end
end

% Permutation symmetry
for i = 1:sizeJzzz(1)
    for j = 1:sizeJzzz(2)
        for k = 1:sizeJzzz(3)
            if Mout(i,j,k) ~= 0
                Mout(j,i,k) = Mout(i,j,k);
                Mout(j,k,i) = Mout(i,j,k);
                Mout(k,j,i) = Mout(i,j,k);
                Mout(k,i,j) = Mout(i,j,k);
                Mout(i,k,j) = Mout(i,j,k);
            end
            
        end
    end
end
            
end

