//SPDX-License-Identifier: Unlicense
pragma solidity >0.4.0 <0.8.4;

contract Vault1{
    uint balance;

    constructor() public {
        balance = 0;
    }

    function deposit(uint _amount) public {
        balance += _amount;
    }
}
