// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol" as OZP;

// This contract just re-exports OpenZeppelin's ERC1967Proxy
// so it can be compiled and used in our tests and deployment scripts
contract ERC1967Proxy is OZP.ERC1967Proxy {
    constructor(address implementation, bytes memory _data) OZP.ERC1967Proxy(implementation, _data) {}
}
