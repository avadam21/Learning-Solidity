// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LockedTokens{
    string public name; //token_name
    string public symbol; //token_symbol
    uint256 public TotalSupply; //read the total no. of tokens with default getter

    mapping(address => uint256) public BalanceOf; //read token balance of specific address
    uint256 public lockedBalance;
    address payable public receiverAdd;
    uint256 tokensDaily = 1000; //1000 tokens per day;
    
    
    uint256 lastTimestamp;
    
    //uint public constant duration = 1 days;

    //constructor func.
    constructor() {
        name = "Hardik Token"; //token_name
        symbol = "HG"; //token_symbol
        BalanceOf[msg.sender] = 10000; //ref. above mapping
        TotalSupply = 10000; //set total no. of tokens
    }
    
    //initializing our client
    function reciever(address payable _reciever) public{
        receiverAdd = _reciever;
        BalanceOf[_reciever] = 0;
        lockedBalance = 10000;
    }
    
   
    
   function transferNew(address payable _reciever) public {
       require(lockedBalance > 0, "Already paid the full amount!");
       if(BalanceOf[_reciever] == 0){
           //payable(msg.sender).transfer(tokensDaily);
           lockedBalance -= tokensDaily;
           BalanceOf[_reciever] += tokensDaily;
           BalanceOf[msg.sender] -= tokensDaily;
           lastTimestamp = block.timestamp;
       }
       else{
           require(lastTimestamp + 10 <= block.timestamp, "Done for today!");
           //payable(msg.sender).transfer(tokensDaily);
           lockedBalance -= tokensDaily;
           BalanceOf[_reciever] += tokensDaily;
           BalanceOf[msg.sender] -= tokensDaily;
           lastTimestamp = block.timestamp;
       }
   }
    
}
