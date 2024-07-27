// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.20;

import {MyERC20} from "./ContractToken.sol";

contract MyToken is MyERC20 {
    constructor() MyERC20("Mytoken", "MTT", 20){
        owner = msg.sender;
    }

    function _mint(address account, uint value) public onlyOwner{
        mint(account, value);
    }

    function _burn(address account, uint value) public onlyOwner{
        burn(account, value);
    }
    
}