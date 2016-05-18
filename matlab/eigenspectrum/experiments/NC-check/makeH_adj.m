function H=makeH_adj(adj,m1,m2)

if ~issparse(m1)
    m1=sparse(m1);
end

if ~issparse(m2)
    m2=sparse(m2);
end

nS=length(m2);

H=sparse(nS^length(adj),nS^length(adj));
N=length(adj);

for ii=1:(length(adj)-1)
    for jj=(ii+1):length(adj)
        if adj(ii,jj)~=0
            beforeMat=speye(nS^(ii-1));
            intermediateMat=speye(nS^(jj-ii-1));
            afterMat=speye(nS^(N-jj));
            coupling=adj(ii,jj)*kron(kron(kron(kron(beforeMat,m1),intermediateMat),m2),afterMat);
            H=H+coupling;
            if nnz(m1-m1')~=0 || nnz(m2-m2')~=0 
                H=H+coupling';
            end
        end
    end
end


            