function H=makeH_single(strs,m)

if ~issparse(m)
    m=sparse(m);
end

nS=length(m);

H=sparse(nS^length(strs),nS^length(strs));
N=length(strs);

for ii=1:length(strs)
    beforeMat=speye(nS^(ii-1));
    afterMat=speye(nS^(N-ii));
    addMat=kron(kron(beforeMat,m),afterMat);
    H=H+strs(ii)*addMat;
end