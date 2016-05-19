function [ Mout ] = symmetrize_2local_couplings( Jzz )
%SYMMETRIZE_3LOCAL_COUPLINGS Sets diagonals to zero and keeps upper right
%tetrahedron of nxnxn matrix

sizeJzzz = size(Jzz);
Mout = Jzz;

% Pairwise terms to zero
for i = 1:sizeJzzz(1)
    for j = 1:sizeJzzz(2)
            if i == j 
                Mout(i,j) = 0;
            end
            
    end
end

% Permutation symmetry
for i = 1:sizeJzzz(1)
    for j = 1:sizeJzzz(2)
        
            if Mout(i,j) ~= 0
                Mout(j,i) = Mout(i,j);
                
            end
            
       
    end
end
            
end

