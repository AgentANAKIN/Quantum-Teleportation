OPENQASM 2.0;
include "qelib1.inc";
qreg q[3];
creg c[3];

z q[0];
h q[0]; // secret unitary: hz

// Alice starts with qubit 1.
// Bob starts with qubit 2.
// Alice is given qubit 0.
// Alice and Bob do not know what has been done to qubit 0.

barrier q; // Alice and Bob entangle their starting qubits.
h q[1];
cx q[1], q[2];

// Alice keeps qubits 0 and 1.
// Bob leaves with qubit 2.

barrier q; // Alice teleports the quantum state of qubit 0 to Bob's qubit.
cx q[0], q[1];
measure q[1] -> c[1];
h q[0];
cx q[1], q[2];
measure q[0] -> c[0];
cz q[0], q[2];

barrier q; // Based on Alice's measurements, Bob reverses the secret unitary.
// 00 do nothing
// 01 apply X
// 10 apply Z
// 11 apply ZX
h q[2];
z q[2];
measure q[2] -> c[2]
