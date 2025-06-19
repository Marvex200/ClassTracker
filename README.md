# ClassTracker Smart Contract

A Clarity smart contract for tracking student attendance on the Stacks blockchain.

## Features

- **Teacher-only attendance marking:** Only the contract deployer (teacher) can mark students as present.
- **Public attendance check:** Anyone can check if a student has been marked present.
- **On-chain record:** Attendance data is stored securely and transparently on-chain.

## Contract Functions

### `mark-present (student principal)`

Marks a student as present.  
**Access:** Only the contract owner (teacher) can call this function.

**Arguments:**
- `student` — The principal address of the student to mark as present.

**Returns:**  
`(ok true)` on success, or an error if called by a non-owner.

---

### `is-present (student principal)`

Checks if a student has been marked present.  
**Access:** Public (anyone can call).

**Arguments:**
- `student` — The principal address of the student to check.

**Returns:**  
`true` if the student is present, `false` otherwise.

---

## Usage

1. **Deploy the contract**  
   Deploy `ClassTracker.clar` to the Stacks blockchain. The deployer becomes the contract owner (teacher).

2. **Mark attendance**  
   The contract owner calls `mark-present` with a student's principal address.

3. **Check attendance**  
   Anyone can call `is-present` with a student's principal address to check their attendance status.

