// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Token} from "../src/token/Token.sol";
import {Test} from "forge-std/Test.sol";

contract TokenTest is Test {
    Token public token;
    address public sender = address(1);
    address public receiver = address(2);
    address public identityRegistry = address(3);
    address public compliance = address(4);

    function setUp() public {
        token = new Token();
        token.init(identityRegistry, compliance, "TestToken", "TST", 18, address(0));
        token.addAgent(address(this));
        token.mint(sender, 100);

    }

    function testSendToken() public {
        vm.startPrank(sender);
        token.transfer(receiver, 50);
        vm.stopPrank();

        assertEq(token.balanceOf(sender), 50);
        assertEq(token.balanceOf(receiver), 50);
    }

}
