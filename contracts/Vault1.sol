//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

contract Vault1 {
    event Deposited(uint amount);

    function deposit(uint _amount) public payable {
        emit Deposited(_amount);
    }
}
