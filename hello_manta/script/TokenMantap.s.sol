// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {TokenMantap} from "../src/TokenMantap.sol";

contract TokenMantapScript is Script {
    TokenMantap public tokenMantap;

    function setUp() public {}

    function run() public {
        vm.createSelectFork(vm.envString("RPC_URL"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        tokenMantap = new TokenMantap();
        console.log("TokenMantap deployed at:", address(tokenMantap));

        vm.stopBroadcast();
    }
}
