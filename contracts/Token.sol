// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract Trealos is ERC20 {
    uint256 private maxSupply;
    mapping (address => uint) whitelist;
    mapping (address => uint) amountSentUsers;
    address[] users;
    address admin;
    uint randNonce = 0; 

    constructor() ERC20("Trealos", "TRL") {
        _setupDecimals(2);
        maxSupply=1001002093092;
        admin = msg.sender;
    }

    function getToken() external payable { 
        require(totalSupply()+msg.value<maxSupply); 
        require(msg.value!=0);
        require(whitelist[msg.sender] > 0);
        uint tiers = checkTiers(msg.value, msg.sender);
        _mint(msg.sender, msg.value*100*tiers);
    }

    function adminAddUser(address newUser) public {
        require(msg.sender == admin);
        whitelist[newUser] = 1;
        amountSentUsers[newUser] = 0;
        users.push(newUser);
    }

    function changeTiers(uint tiers, address user) internal {
        require(tiers > 0);
        require(tiers < 4);
        whitelist[user] = tiers;
    }

    function checkTiers(uint amountSend, address user) internal returns (uint tiers) {
        uint totalAmountSent = amountSend + amountSentUsers[user];
        if (totalAmountSent > 400 && whitelist[user] < 3) {
            changeTiers(3, user);
        } else if (totalAmountSent > 200 && whitelist[user] < 2) {
            changeTiers(2, user);
        }
        return whitelist[user];
    }

    function airDrop() private {
        require(msg.sender == admin);
        address luckyOne = users[randMod(users.length)];
        _mint(luckyOne, 100);
    }

    // Defining a function to generate 
    // a random number 
    function randMod(uint max) internal returns(uint)  
    { 
       // increase nonce 
       randNonce++;   
       return uint(keccak256(abi.encodePacked(block.timestamp,  
                                              msg.sender,  
                                              randNonce))) % max; 
    } 
}