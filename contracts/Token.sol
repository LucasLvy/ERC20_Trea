// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";



contract Trealos is ERC20 {
    uint256 private maxSupply;
    constructor() ERC20("Trealos", "TRL") {
        _setupDecimals(2);
        maxSupply=1001002093092;
    }

    function getToken() external payable { 
        require(totalSupply()+msg.value<maxSupply); 
        require(msg.value!=0);
        _mint(msg.sender, msg.value*100);
    }
}