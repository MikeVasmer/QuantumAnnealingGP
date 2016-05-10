% Create a remote SAPI connection handle
conn_1 = sapiLocalConnection();
% List solvers’ names
sapiListSolvers(conn_1)
% Create a SAPI solver handle using a solver listed
solver_1 = sapiSolver(conn_1, 'c4-sw_optimize');
% Retrieve solver properties from a SAPI solver handle
props_1 = sapiSolverProperties(solver_1)
