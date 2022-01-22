//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ExampleToken is IERC20 {
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;

    string public constant name = "ExampleERC";
    string public constant symbol = "Ex";

    uint256 _totalSupply;

    constructor(uint256 total) {
        _totalSupply = total;
        balances[msg.sender] = _totalSupply;
    }

    function totalSupply() public override view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address tokenOwner) public override view returns (uint) {
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint numTokens) public override returns (bool) {
        require(numTokens <= balances[msg.sender]);
		balances[msg.sender] -= numTokens;
        balances[receiver] += numTokens;
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }

	function approve(address delegate, uint numTokens) public override returns (bool) {
		allowed[msg.sender][delegate] = numTokens;
		emit Approval(msg.sender, delegate, numTokens);
		return true;
	}

	function allowance(address owner, address delegate) public override view returns (uint) {
		return allowed[owner][delegate];
	}

	function transferFrom(address owner, address buyer, uint numTokens) public override returns (bool) {
		require(numTokens <= balances[owner]);
		require(numTokens <= allowed[owner][msg.sender]);
		balances[owner] -= numTokens;
		allowed[owner][msg.sender] -= numTokens;
		balances[buyer] += numTokens;
		emit Transfer(owner, buyer, numTokens);
		return true;
	}
}
