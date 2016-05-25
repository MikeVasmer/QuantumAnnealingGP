function [ adj_mat ] = chimeraAdj( m, n )
%CHIMERAADJ Returns adjacency matrix for a chimera on m x n unit cells

adj_mat = full(getChimeraAdjacency(m, n, 4));

end

