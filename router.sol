// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;


interface IERC20 {
    function transfer(address to, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
}

contract router {

    function routTokens(IERC20 token, address[] memory recipients, uint256[] memory values, uint amount) external {

        token.transferFrom(msg.sender, address(this), amount);

        for (uint i = 0; i < recipients.length; i++)
            token.transfer(recipients[i], values[i]);
    }
}