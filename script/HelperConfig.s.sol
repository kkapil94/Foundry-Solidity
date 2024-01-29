//SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import {VRFConsumerBaseV2Mock} from "@chainlink/contracts/src/v0.8/tests/VRFConsumerBaseV2Mock.sol";

contract HelperConfig is Script{
    struct NetworkConfig{
         uint256 entryFees;
        uint256 interval;
        address vrfCoordinator;
        bytes32 gasLane;
        uint64 subscriptionId;
        uint32 callbackGasLimit;
    }

    NetworkConfig public activeNetworkConfig;

    constructor() {
        if(block.chainid === 11155111)
        activeNetworkConfig = SepoliaNetworkConfig();
        else activeNetworkConfig = getOrCreateAnvilEthConfig();
    }

    function SepoliaNetworkConfig() public pure returns (NetworkConfig memory){
        return NEtworkConfig({
            entryFees: 0.01 ether,
            interval: 30,
            vrfCoordinator: 0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625,
            gasLane: 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c,
            subscriptionId: 0,
            callbackGasLimit: 500000
        });
    }

    function getOrCreateAnvilEthConfig() public view returns (NetworkConfig memory){
        if(activeNetworkConfig.vrfCoordinator != address(0)){
            return activeNetworkConfig;
        }

        uint96 public baseFee = 0.25 ether;
        uint96 public gasPriceLink = 1e9;

        vm.startBroadcast();
        VRFConsumerBaseV2Mock vrfCoordinatorMock =  new VRFConsumerV2Mock(baseFee, gasPriceLink);
        vm.stopBroadcast();

        return NetworkConfig({
            entryFees: 0.01 ether,
            interval: 30,
            vrfCoordinator: address(vrfCoordinatorMock),
            gasLane: 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c,
            subscriptionId: 0,
            callbackGasLimit: 500000
        });
    }
}