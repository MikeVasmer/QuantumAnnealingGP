# Eigenspectrum

Calculate the eigenspectrum between two Hamilontians

### Functions:

-   Function: eigenspectrum
    - Description: Used to plot evolution of the eigenspectrum between two Hamiltonians   
    -   Parameters:
        -   required: start hamiltonian (2^n by 2^n matrix)
        -   required: finish hamiltonian (2^n by 2^n matrix)
        -   required: number of steps (int)
        -   optional: figures to plot (0,1,2)
            - 0: Normal eigenspectrum (default)
            - 1: Relative to ground eigenspectrum
            - 2: Both
    -   Example: 'test_eigenspectrum'

```Matlab
% Array of h coef for local fields
h=[1,0.5,0.8,1];
% Matrix of J coef for couplings
J=[[0,1,0,0];[1,0,0,0];[1,1,0,0];[1,0,1,0]];

% Calculate and plot eigenspectrum between two Hamilontians
eigenspectrum(  transverse_hamiltonian(4),...   % Starting Hamiltonian
                ising_hamiltonian(h, J), ...    % Finishing Hamiltonian
                21, ...                         % Steps
                2);                             % Optional: figures to plot
```

-   Function: transverse_hamiltonian
    - Description: Returns an n-qubit transverse field Hamiltonian  
    -   Parameters:
        -   required: number of qubits, n (int)
-   Function: ising_hamiltonian
    - Description: Given local fields, h and couplings, J returns the Ising Hamiltonian  
    -   Parameters:
        -   required: array of h coefficients, h (n-array)
        -   required: matrix of J coefficients, J (n by n matrix)
    -   Return: Ising Hamiltonian
-   Function: recursive_kron
    - Description: Returns Kronnecker tensor product of a single qubit matrix on a specified qubit with the identity matrix on all other qubits
    -   Parameters:
        -   required: total number of qubits, n (int)
        -   required: index of qubit to insert matrix, i (int)
        -   required: single qubit operation (2 by 2 matrix)
        -   ignore: matrix from previous recursive call (leave empty)
    -   Return: Hamiltonian with operation on a single qubit (2^n by 2^n matrix)
-   Function: recursive_kron_double
    - Description: Returns Kronnecker tensor product of two single qubit matrices on two specified qubits with the identity matrix on all other qubits
    -   Parameters:
        -   required: total number of qubits, n (int)
        -   required: index of first qubit to insert matrix, i (int)
        -   required: first single qubit operation (2 by 2 matrix)
        -   required: index of second qubit to insert matrix, i (int)
        -   required: second single qubit operation (2 by 2 matrix)
        -   ignore: matrix from previous recursive call (leave empty)
    -   Return: Hamiltonian with operations on two single qubits (2^n by 2^n matrix)