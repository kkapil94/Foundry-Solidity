//SPDX-Licence-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Tests.sol";
import {Raffle} from "../src/Raffle.sol";
import {HelperConfig} from "../script/HelperConfig.sol";
import {DeployRaffle} from "../script/DeployRaffle.sol";


contract RaffleTest is Test{

    Raffle raffle;
    HelperConfig helperConfig;
    uint256 entryFees,
    uint256 interval,
    address vrfCoordinator,
    bytes32 gasLane,
    uint64 subscriptionId,
    uint32 callbackGasLimit

    function test() external {
        DeployRaffle deployRaffle = new DeployRaffle();
        raffle = deployRaffle.run();
        (entryFees,
        interval,
        vrfCoordinator,
        gasLane,
        subscriptionId,
        callbackGasLimit) = helperConfig.activeNetworkConfig();
    }

    function testRaffleInitializesInOpenState() external {
        assertEq(raffle.getRaffleState(), Raffle.RaffleState.OPEN);
    }
}
