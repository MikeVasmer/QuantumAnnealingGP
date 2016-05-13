import numpy as np
from matplotlib import pyplot as plt
from timeit import timeit


sig_x = np.array([[0,1],[1,0]])
sig_z = np.array([[1,0],[0,-1]])
Identity = np.array([[1,0],[0,1]])
Ham_i_term = sig_x
Ham_p_term = sig_z
Ham_coup_term = np.kron(sig_z,sig_z)




# This generates a tensor product of Identities of length n
def gen_id_kron(n):
    Id = 1
    for i in range(n):
        Id = np.kron(Id,Identity)
    return Id



# This generates a tensor product of identites and selected operator at locations specified by vals
def gen_term(vals, oper):
    term = 1
    for x in vals:
        if x == 0:
            term = np.kron(term,Identity)
        elif x != 0:
            term = np.kron(x*term, oper)
    return term

# This generates a simple transverse hamiltonian - no couplings, transverse field at each qubit
def gen_trans_Ham(n):
    terms = []
    for i in range(n):
        term = np.kron(np.kron(gen_id_kron(i),Ham_i_term),gen_id_kron(n-i-1))
        terms.append(term)
    #     print term
    # print terms
    H = 0
    for x in terms:
        H = H+x
    return H

# This generates an Ising Hamiltonian - currently only does sigma_zs, but with arbitrary number of couplings, easy adaption to sig_xs (possibly hard to do xz terms)
def gen_class_Ham(h, J, n):
    if len(h) != n:
        print "wrong length hs"
    terms = []
    for i in range(n):
        term_h = h[i]*np.kron(np.kron(gen_id_kron(i),Ham_p_term),gen_id_kron(n-i-1))
        terms.append(term_h)
    for x in J:
        term_J = gen_term(x, sig_z)
        terms.append(term_J)
    print terms
    H = 0
    for x in terms:
        H = H+x
    return H



# Calculates Hamiltonian at each step of an evolution and returns eigenvalues
def eigen_evo(H_i, H_p, s):
    eigs = []
    print H_i, H_p
    for i in range(s+1):
        n = float(i)
        H = ((s-n)/s)*H_i + (1-(s-n)/s)*H_p
        eigens = np.linalg.eigvals(H)
        eigs.append(sorted(eigens))
    return eigs


# Generates a graph of an evolution from transverse to designated Ising Ham, could do with adapting to save graphs etc.
def gen_eigen_spectrum(h, J, steps):
    n = len(h)
    ham_p = gen_class_Ham(h, J, n)
    ham_i = gen_trans_Ham(n)
    eigen_vals = eigen_evo(ham_i, ham_p, steps)
    shaped_eigen_vals = []
    for i in range(2**len(h)):
        lop = []
        for j in range(len(eigen_vals)):
            lop.append(eigen_vals[j][i])
        shaped_eigen_vals.append(lop)
    z = np.linspace(0,1,steps+1)
    fig = plt.figure()
    ax1 = fig.add_subplot(111)
    gaps = []
    for x in eigen_vals:
        gaps.append(x[1]-x[0])
    min_gap = min(gaps)
    for i in range(2**len(h)-1):
        ax1.plot(z,shaped_eigen_vals[i])
    plt.show()
    return min_gap


# h = np.ones(5)
h = [0,0,0,0,0,0,0,0]
J = np.array([[1,1,0,0,0,0,0,0],[1,0,1,0,0,0,0,0],[1,0,0,1,0,0,0,0],[0,1,1,0,0,0,0,0],[0,1,0,1,0,0,0,0],
[0,0,1,1,0,0,0,0],[1,0,0,0,1,0,0,0],[1,0,0,0,0,1,0,0],[1,0,0,0,0,0,1,0],[1,0,0,0,0,0,0,1],
[0,1,0,0,1,0,0,0],[0,1,0,0,0,1,0,0],[0,1,0,0,0,0,1,0],[0,1,0,0,0,0,0,1],
[0,0,1,0,1,0,0,0],[0,0,1,0,0,1,0,0],[0,0,1,0,0,0,1,0],[0,0,1,0,0,0,0,1],
[0,0,0,1,1,0,0,0],[0,0,0,1,0,1,0,0],[0,0,0,1,0,0,1,0],[0,0,0,1,0,0,0,1]])
gen_eigen_spectrum(h, J, 100)
