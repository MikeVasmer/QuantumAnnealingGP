function [ adjacency_mat ] = NearestNeighbourAdj2D( m, n )
%2D_NEAREST_NEIGHBOUR_ADJ Makes the adjacency matrix for an MxN grid of
%qubits connected to nearest neighbours

I_size = m*n;

% 1-off diagonal elements
V = repmat([ones(m-1,1); 0],n, 1);
V = V(1:end-1); % remove last zero

% n-off diagonal elements
U = ones(m*(n-1), 1);

% get the upper triangular part of the matrix
adjacency_mat = sparse(1:(I_size-1),    2:I_size, V, I_size, I_size)...
  + sparse(1:(I_size-m),(m+1):I_size, U, I_size, I_size);

% finally make W symmetric
adjacency_mat = adjacency_mat + adjacency_mat';
adjacency_mat = full(adjacency_mat);

end

