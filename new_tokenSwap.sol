// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "./TRUSTT.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/utils/SafeERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";


contract TokenSwap is Ownable {

    IERC20 public USDT;
    TRUSTT_Token public TRUSTT;
    address public contractAddress;

    constructor(
        address _USDT,
        address _TRUSTT
    ) {
        USDT = IERC20(_USDT);
        TRUSTT = TRUSTT_Token(_TRUSTT);
        contractAddress = (address(this));
    }

    using SafeERC20 for IERC20;

    function getTRUSTT(uint amountUSDT) public {

        address msgSender = msg.sender;

        USDT.safeTransferFrom(msgSender, contractAddress, amountUSDT);
        TRUSTT.mint(msgSender, amountUSDT);
        
    }

    function sellTRUSTT(uint amountUSDT) public {

        address msgSender = msg.sender;
        
        TRUSTT.approve(msgSender, contractAddress, amountUSDT);
        TRUSTT.transferFrom(msgSender, contractAddress, amountUSDT);
        TRUSTT.burn(contractAddress, amountUSDT);

        USDT.safeTransfer(msgSender, amountUSDT);

    }

}

