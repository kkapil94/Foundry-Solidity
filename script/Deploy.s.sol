// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {Raffle} from "../src/Raffle.sol";
import {HelperConfig} from "../script/HelperConfig.sol";

contract DeployRaffle is Script {
    function run() external returns (Raffle,HelperConfig ){
        HelperConfig helperConfig = new HelperConfig();
        (uint256 entryFees,
        uint256 interval,
        address vrfCoordinator,
        bytes32 gasLane,
        uint64 subscriptionId,
        uint32 callbackGasLimit) = helperConfig.activeNetworkConfig();
    }

    vm.startBroadcast();
    Raffle raffle = new Raffle(entryFees, interval, vrfCoordinator, gasLane, subscriptionId, callbackGasLimit);
    vm.stopBroadcast();
    return (raffle,helperConfig);
}
