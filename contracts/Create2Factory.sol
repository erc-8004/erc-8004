// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Create2Factory
 * @dev Factory contract for deploying contracts using CREATE2 opcode
 * This allows for deterministic contract addresses based on salt
 */
contract Create2Factory {
    event Deployed(address addr, bytes32 salt);

    /**
     * @dev Deploy a contract using CREATE2
     * @param salt Salt for CREATE2 address calculation
     * @param bytecode Contract bytecode to deploy
     * @return addr The address of the deployed contract
     */
    function deploy(bytes32 salt, bytes memory bytecode) external returns (address addr) {
        assembly {
            addr := create2(0, add(bytecode, 0x20), mload(bytecode), salt)
            if iszero(extcodesize(addr)) {
                revert(0, 0)
            }
        }
        emit Deployed(addr, salt);
    }

    /**
     * @dev Compute the address of a contract deployed via CREATE2
     * @param salt Salt for CREATE2 address calculation
     * @param bytecodeHash Keccak256 hash of the contract bytecode
     * @return The predicted address
     */
    function computeAddress(bytes32 salt, bytes32 bytecodeHash) external view returns (address) {
        return address(uint160(uint256(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this),
            salt,
            bytecodeHash
        )))));
    }
}
