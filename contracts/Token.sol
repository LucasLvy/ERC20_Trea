// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
private uint256 etalonage3= 100;
private uint256 etalonage2=10;
private uint256 etalonage1=1;
//private uint256 totalSupply=0;

contract Trealos is ERC20 {
    constructor(uint256 initialSupply) ERC20("Trealos", "TRL") {
        
    }

    getToken(){  
        require(msg.value!=0);
        _mint(msg.sender, msg.value*100);
        //totalSupply+=msg.value*100
    }
}