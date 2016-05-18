% Free variables
J_N=0.25;   
q_0=0.5;    
J=1;      
% Fixed variables
J_a=J;
h=q_0-J;
N=4;

% q_i values
fprime=2*J_N*ones(4,1);
fprime(1)=-fprime(1);
fprime(3)=-fprime(3);

% Set up coupling matrix
adj=zeros(8);
adj(1:4,1:4)=J*ones(4);
adj(1:4,1:4)=adj(1:4,1:4)-tril(adj(1:4,1:4));
adj(1:4,5:8)=J_a;

% Set up fields
fields=zeros(8,1);
q=zeros(4,1);

fields(1:4)=h;

for ii=1:4
    q(ii)=-1/2*(fprime(ii))+q_0;
    fields(ii+4)=J_a*(N-2*ii)+q(ii);
end

% Sigma Z
sz=[1,0;0,-1];

% Logical 4-local (with 2-locals) Hamiltonian
H4l=makeH_adj(adj,sz,sz)+makeH_single(fields,sz);