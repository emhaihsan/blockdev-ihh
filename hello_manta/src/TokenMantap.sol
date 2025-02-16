// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract TokenMantap is ERC20 {
    constructor() ERC20("TokenMantap", "MTP") {
        _mint(msg.sender, 1_000_000_000_000_000e18);
    }
}
