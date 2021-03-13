// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract Trealos is ERC20 {
    uint256 private maxSupply;
    mapping (address => uint) public whitelist;
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
        uint tiers = checkTiers(msg.value, msg.sender);
        require(
            totalSupply()+msg.value*100*tiers<maxSupply,
            "All tokens have been sold"
        ); 
        require(
            msg.value>0,
            "Value is negative or =0"
        );
        require(
            whitelist[msg.sender] > 0,
            "User is not whitelisted"
        );
        
        _mint(msg.sender, msg.value*100*tiers);
    }

    function adminAddUser(address newUser) public {
        require(
            msg.sender == admin,
            "Sender is not admin"
        );
        whitelist[newUser] = 1;
        amountSentUsers[newUser] = 0;
        users.push(newUser);
    }

    function changeTiers(uint tiers, address user) internal {
        require(
            tiers > 0,
            "Tier is negative"
        );
        require(
            tiers < 4,
            "Tier is too high"
        );
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

    function airDrop() public {
        require(
            msg.sender == admin,
            "Sender is not admin"
        );
        address luckyOne = users[randMod(users.length)];
        _mint(luckyOne, 100);
    }
    function whiteList ()public view returns( address  [] memory){
        return users;
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