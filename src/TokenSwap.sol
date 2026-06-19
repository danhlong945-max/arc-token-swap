// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title TokenSwap - Simple token swap on Arc Network
/// @notice Swap between two ERC20 tokens at a fixed rate
contract TokenSwap {
    IERC20 public tokenA;
    IERC20 public tokenB;
    uint256 public rate;
    address public owner;

    event Swapped(address indexed user, uint256 amountIn, uint256 amountOut);

    constructor(address _tokenA, address _tokenB, uint256 _rate) {
        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
        rate = _rate;
        owner = msg.sender;
    }

    function swap(uint256 amount) external {
        uint256 amountOut = amount * rate / 1e18;
        tokenA.transferFrom(msg.sender, address(this), amount);
        tokenB.transfer(msg.sender, amountOut);
        emit Swapped(msg.sender, amount, amountOut);
    }

    function setRate(uint256 _rate) external {
        require(msg.sender == owner, "Not owner");
        rate = _rate;
    }
}
