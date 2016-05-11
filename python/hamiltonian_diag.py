
import numpy as np
from matplotlib import pyplot as plt
from timeit import timeit


sig_x = np.array([[0,1],[1,0]])
sig_z = np.array([[1,0],[0,-1]])
Identity = np.array([[1,0],[0,1]])
Ham_i_term = sig_x
Ham_p_term = sig_z
Ham_coup_term = np.kron(sig_z,sig_z)


# print sig_x
# print sig_z
# print Identity


def gen_id_kron(n):
    Id = 1
    for i in range(n):
        Id = np.kron(Id,Identity)
    return Id

# print "Gen_id_kron here"
# print gen_id_kron(1)
# print np.kron(sig_x,1)

def gen_trans_Ham(n):
    terms = []
    for i in range(n):
        # print 'rep number is %s', i
        # print gen_id_kron(n-i-1)
        term = np.kron(np.kron(gen_id_kron(i),Ham_i_term),gen_id_kron(n-i-1))
        terms.append(term)
    #     print term
    # print terms
    H = 0
    for x in terms:
        H = H+x
    return H

def gen_class_Ham(h, J, n):
    if len(h) != n:
        print "wrong length hs"
    terms = []
    for i in range(n):
        # print 'rep number is %s', i
        # print gen_id_kron(n-i-1)
        term = h[i]*np.kron(np.kron(gen_id_kron(i),Ham_p_term),gen_id_kron(n-i-1))
    for i in range(len(J)):
        term =  J[i]*np.kron(np.kron(gen_id_kron(i),Ham_coup_term),gen_id_kron(n-i-2))
        terms.append(term)
    #     print term
    # print terms
    H = 0
    for x in terms:
        H = H+x
    return H

# h = [0,0,0,0,0,0,0,0,0,0]
# J = [1,1,1,1,1,1,1,1,1]

# ham_p = gen_class_Ham(h, J, 7)
# ham_i = gen_trans_Ham(7)
# print ham_i
# print ham_p
# print np.linalg.eigvals(ham_i)
# print np.linalg.eigvals(ham_p)

def eigen_evo(H_i, H_p, s):
    eigs = []
    print H_i, H_p
    for i in range(s+1):
        n = float(i)
        H = ((s-n)/s)*H_i + (1-(s-n)/s)*H_p
        eigens = np.linalg.eigvals(H)
        eigs.append(sorted(eigens))
    return eigs

# eigen_vals = eigen_evo(ham_i, ham_p, 1000)

# fig = plt.figure()
# ax1 = fig.add_subplot(111)
# z = np.linspace(0,1,1001)

# print eigen_vals[1][1]
# print len(eigen_vals[1])
# x = []
# shaped_eigen_vals = []

# for i in range(2**len(h)):
#     lop = []
#     for j in range(len(eigen_vals)):
#         lop.append(eigen_vals[j][i])
#     print lop
#     shaped_eigen_vals.append(lop)

# for i in range(101):
#     b = []
#     for j in range(2**len(h)):
#         b.append(z[i])
#     x.append(b)
    
# # for i in range(len(x)):
# #     for j in range(2**len(h)):
# #         ax1.plot(z[i],eigen_vals[i][j],)

# for i in range(2**len(h)-1):
#     ax1.plot(z,shaped_eigen_vals[i])

# plt.show()

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
    for i in range(2**len(h)-1):
        ax1.plot(z,shaped_eigen_vals[i])
    plt.show()


# h = np.ones(5)
h = [1,0.5,0.8,1]
J = [1,1,1] 
# J = np.ones(4)
gen_eigen_spectrum(h, J, 1000)

# times = []

# for i in range(4):
#     h = np.ones(i+2)
#     J = np.ones(i+1)
#     print h
#     print J
#     time = timeit(gen_eigen_spectrum(h, J, 100))


# print times
